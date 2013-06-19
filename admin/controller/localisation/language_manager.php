<?php

class ControllerLocalisationLanguageManager extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('localisation/language_manager');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('localisation/language_manager');

        $this->getList();
    }

    public function update() {
        $this->load->language('localisation/language_manager');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('localisation/language_manager');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

            $this->model_localisation_language_manager->updateLanguageDB($this->request->get['file'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->redirect($this->url->link('localisation/language_manager', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    private function getList() {
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'name';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('localisation/language_manager', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );

        $this->data['language_files'] = array();

        $data = array(
            'sort' => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_admin_limit'),
            'limit' => $this->config->get('config_admin_limit')
        );

        $results = $this->model_localisation_language_manager->getLanguageFiles($data);

        foreach ($results as $result) {
            $action = array();

            $action[] = array(
                'text' => $this->language->get('text_edit'),
                'href' => $this->url->link('localisation/language_manager/update', 'token=' . $this->session->data['token'] . '&file=' . $result . $url, 'SSL')
            );

            $this->data['language_files'][] = array(
                'file' => $result,
                'action' => $action
            );
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_no_results'] = $this->language->get('text_no_results');

        $this->data['column_name'] = $this->language->get('column_name');
        $this->data['column_code'] = $this->language->get('column_code');
        $this->data['column_sort_order'] = $this->language->get('column_sort_order');
        $this->data['column_action'] = $this->language->get('column_action');


        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;

        $this->template = 'localisation/language_manager_list.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    private function getForm() {
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');

        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_code'] = $this->language->get('entry_code');
        $this->data['entry_locale'] = $this->language->get('entry_locale');
        $this->data['entry_image'] = $this->language->get('entry_image');
        $this->data['entry_directory'] = $this->language->get('entry_directory');
        $this->data['entry_filename'] = $this->language->get('entry_filename');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $this->data['entry_status'] = $this->language->get('entry_status');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('localisation/language_manager', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );

        $this->data['cancel'] = $this->url->link('localisation/language_manager', 'token=' . $this->session->data['token'] . $url, 'SSL');


        $this->load->model('localisation/language');
        
        $this->data['text_filename'] = $this->language->get('text_filename');
        $this->data['filename'] = $this->request->get['file'];

        $this->data['languages'] = $this->model_localisation_language->getLanguages();

        $this->data['language_manager'] = $this->model_localisation_language_manager->getLanguageFileData($this->request->get['file']);

        if (isset($this->request->post['language_manager'])) {
            foreach ($this->data['language_manager'] as $language_id => &$language_manager) {
                $value = array();
                if (isset($this->request->post['language_manager'][$language_id]['value'])) {
                    $value = (array) $this->request->post['language_manager'][$language_id]['value'];
                }
                $language_manager['value'] = $value;
            }
        }

        $this->template = 'localisation/language_manager_form.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    private function validateForm() {
        if (!$this->user->hasPermission('modify', 'localisation/language')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function validateDelete() {
        if (!$this->user->hasPermission('modify', 'localisation/language')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}

?>