<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use think\Db;

/**
 * 小程序系统管理
 *
 * @icon fa fa-cog
 */
class SystemConfig extends Backend
{
    protected $model = null;
    const CONFIG_ID = 1;
    const PAY_TYPE_TRC20 = 'USDT-TRC20';
    const PAY_TYPE_ERC20 = 'USDT-ERC20';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappSystemConfig;
    }

    public function index()
    {
        if (!$this->request->isPost()) {
            $row = $this->getConfigRow();
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }

        $params = $this->request->post('row/a');
        if (!$params) {
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $saveData = [
            'recharge_address'      => trim((string)($params['trc20_address'] ?? '')),
            'fixed_commission_rate' => $this->normalizeRate($params['fixed_commission_rate'] ?? 0),
            'parent_rebate_rate'    => $this->normalizeRate($params['parent_rebate_rate'] ?? 0, 'Parent rebate rate'),
            'status'                => 1,
        ];
        $payConfigs = [
            self::PAY_TYPE_TRC20 => [
                'address' => trim((string)($params['trc20_address'] ?? '')),
                'qrcode'  => trim((string)($params['trc20_qrcode'] ?? '')),
                'sort'    => 100,
            ],
            self::PAY_TYPE_ERC20 => [
                'address' => trim((string)($params['erc20_address'] ?? '')),
                'qrcode'  => trim((string)($params['erc20_qrcode'] ?? '')),
                'sort'    => 99,
            ],
        ];

        Db::startTrans();
        try {
            $row = $this->model->lock(true)->where('id', self::CONFIG_ID)->find();
            if ($row) {
                $row->allowField(true)->save($saveData);
            } else {
                $saveData['id'] = self::CONFIG_ID;
                $this->model->allowField(true)->save($saveData);
            }
            $this->saveGlobalRechargeConfigs($payConfigs);
            $this->saveDefaultCommissionRate($saveData['fixed_commission_rate']);
            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }

    protected function getConfigRow()
    {
        $row = $this->model->where('id', self::CONFIG_ID)->find();
        $payConfigs = $this->getGlobalRechargeConfigs();
        if ($row) {
            $row['trc20_address'] = $payConfigs[self::PAY_TYPE_TRC20]['address'];
            $row['trc20_qrcode'] = $payConfigs[self::PAY_TYPE_TRC20]['qrcode'];
            $row['erc20_address'] = $payConfigs[self::PAY_TYPE_ERC20]['address'];
            $row['erc20_qrcode'] = $payConfigs[self::PAY_TYPE_ERC20]['qrcode'];
            $row['parent_rebate_rate'] = isset($row['parent_rebate_rate']) && $row['parent_rebate_rate'] !== ''
                ? sprintf('%.2f', (float)$row['parent_rebate_rate'])
                : '15.00';
            return $row;
        }

        return [
            'id'                    => self::CONFIG_ID,
            'recharge_address'      => $payConfigs[self::PAY_TYPE_TRC20]['address'],
            'trc20_address'         => $payConfigs[self::PAY_TYPE_TRC20]['address'],
            'trc20_qrcode'          => $payConfigs[self::PAY_TYPE_TRC20]['qrcode'],
            'erc20_address'         => $payConfigs[self::PAY_TYPE_ERC20]['address'],
            'erc20_qrcode'          => $payConfigs[self::PAY_TYPE_ERC20]['qrcode'],
            'fixed_commission_rate' => $this->getDefaultCommissionRate(),
            'parent_rebate_rate'    => '15.00',
        ];
    }

    protected function normalizeRate($value, $fieldName = 'Fixed commission rate')
    {
        $value = trim((string)$value);
        if ($value === '') {
            return '0.00';
        }
        if (!is_numeric($value)) {
            $this->error(__($fieldName . ' must be numeric'));
        }
        $rate = round((float)$value, 2);
        if ($rate < 0 || $rate > 100) {
            $this->error(__($fieldName . ' must be between 0 and 100'));
        }
        return sprintf('%.2f', $rate);
    }

    protected function getRechargeTypes()
    {
        return [self::PAY_TYPE_TRC20, self::PAY_TYPE_ERC20];
    }

    protected function getGlobalRechargeConfigs()
    {
        $defaults = [
            self::PAY_TYPE_TRC20 => ['address' => '', 'qrcode' => ''],
            self::PAY_TYPE_ERC20 => ['address' => '', 'qrcode' => ''],
        ];

        $rows = Db::name('miniapp_pay_config')
            ->where('user_id', 0)
            ->where('status', 1)
            ->where('type', 'in', $this->getRechargeTypes())
            ->order('sort desc,id desc')
            ->field('usercode,qrcode,type')
            ->select();

        $seenTypes = [];
        foreach ($rows as $row) {
            $type = (string)$row['type'];
            if (!isset($defaults[$type]) || isset($seenTypes[$type])) {
                continue;
            }
            $seenTypes[$type] = true;
            $defaults[$type] = [
                'address' => (string)$row['usercode'],
                'qrcode'  => (string)($row['qrcode'] ?? ''),
            ];
        }

        return $defaults;
    }

    protected function saveGlobalRechargeConfigs(array $payConfigs)
    {
        $now = time();
        foreach ($payConfigs as $type => $config) {
            $existing = Db::name('miniapp_pay_config')
                ->where('user_id', 0)
                ->where('type', $type)
                ->order('id desc')
                ->find();

            $data = [
                'usercode'    => (string)($config['address'] ?? ''),
                'qrcode'      => (string)($config['qrcode'] ?? ''),
                'status'      => 1,
                'sort'        => (int)($config['sort'] ?? 0),
                'update_time' => $now,
            ];

            if ($existing) {
                Db::name('miniapp_pay_config')->where('id', (int)$existing['id'])->update($data);
                continue;
            }

            $data['user_id'] = 0;
            $data['type'] = $type;
            $data['create_time'] = $now;
            Db::name('miniapp_pay_config')->insert($data);
        }
    }

    protected function getDefaultCommissionRate()
    {
        $value = Db::name('miniapp_config')->where('name', 'level_bili')->order('id asc')->value('value');
        if ($value === null || $value === '' || !is_numeric($value)) {
            return '0.00';
        }

        return sprintf('%.2f', round((float)$value * 100, 2));
    }

    protected function saveDefaultCommissionRate($rate)
    {
        $configValue = rtrim(rtrim(sprintf('%.6f', ((float)$rate) / 100), '0'), '.');
        if ($configValue === '') {
            $configValue = '0';
        }

        $now = time();
        foreach (['1', '2'] as $language) {
            $exists = Db::name('miniapp_config')->where('name', 'level_bili')->where('language', $language)->find();
            if ($exists) {
                Db::name('miniapp_config')->where('id', (int)$exists['id'])->update([
                    'value'       => $configValue,
                    'status'      => 1,
                    'update_time' => $now,
                ]);
                continue;
            }

            Db::name('miniapp_config')->insert([
                'name'        => 'level_bili',
                'value'       => $configValue,
                'language'    => $language,
                'status'      => 1,
                'create_time' => $now,
                'update_time' => $now,
            ]);
        }
    }
}
