<?php

class ControllerModuleLanguageManager extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('module/language_manager');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->load->model('module/language_manager');
            $this->model_module_language_manager->createDatabaseTables();
            
            $this->model_setting_setting->editSetting('language_manager', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');

        $this->data['entry_status'] = $this->language->get('entry_status');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->request->post['language_manager_status'])) {
            $this->data['language_manager_status'] = $this->request->post['language_manager_status'];
        } elseif ($this->config->get('language_manager_status')) {
            $this->data['language_manager_status'] = $this->config->get('language_manager_status');
        } else {
            $this->data['language_manager_status'] = 0;
        }

        if (isset($this->request->post['language_manager_files'])) {
            $this->data['language_manager_files'] = $this->request->post['language_manager_files'];
        } elseif ($this->config->get('language_manager_files')) {
            $this->data['language_manager_files'] = $this->config->get('language_manager_files');
        } else {
            $this->data['language_manager_files'] = 0;
        }

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/language_manager', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/language_manager', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->template = 'module/language_manager.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );

        $this->response->setOutput($this->render());
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/language_manager')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    public function install() {
        $this->load->model('module/language_manager');
        $this->model_module_language_manager->createDatabaseTables();

        $this->load->model('setting/setting');
        $settings = $this->model_setting_setting->getSetting('language_manager');
        $settings['language_manager_status'] = 1;
        $this->model_setting_setting->editSetting('language_manager', $settings);
    }

    public function uninstall() {
        $this->load->model('module/language_manager');
        $this->model_module_language_manager->dropDatabaseTables();

        $this->load->model('setting/setting');
        $settings = $this->model_setting_setting->getSetting('language_manager');
        $settings['language_manager_status'] = 0;
        $this->model_setting_setting->editSetting('language_manager', $settings);
    }

}

?>