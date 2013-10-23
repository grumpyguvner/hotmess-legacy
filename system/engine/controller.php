<?php

abstract class Controller {

    protected $registry;
    protected $id;
    protected $layout;
    protected $template;
    protected $children = array();
    protected $data = array();
    protected $data_layer = array();
    protected $output;

    public function __construct($registry) {
        $this->registry = $registry;
    }

    public function __get($key) {
        return $this->registry->get($key);
    }

    public function __set($key, $value) {
        $this->registry->set($key, $value);
    }

    protected function forward($route, $args = array()) {
        return new Action($route, $args);
    }

    protected function redirect($url, $status = 302) {
        header('Status: ' . $status);
        header('Location: ' . str_replace('&amp;', '&', $url));
        exit();
    }

    protected function getChild($child, $args = array()) {
        $action = new Action($child, $args);
        $file = $action->getFile();
        $class = $action->getClass();
        $method = $action->getMethod();

        if (file_exists($file)) {
            require_once($file);

            $controller = new $class($this->registry);
            
            //Pass the data layer to all children
            $controller->setDataLayer($this->data_layer);

            $controller->$method($args);

            return $controller->output;
        } else {
            trigger_error('Error: Could not load controller ' . $child . '!');
            exit();
        }
    }

    protected function setDataLayer($data_layer) {
        $this->data_layer = $data_layer;
    }
    
    protected function setTemplate($template) {
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $template)) {
            $this->template = $this->config->get('config_template') . '/template/' . $template;
        } elseif (file_exists(DIR_TEMPLATE . $this->config->get('config_base_template') . '/template/' . $template)) {
            $this->template = $this->config->get('config_base_template') . '/template/' . $template;
        } else {
            $this->template = 'default/template/' . $template;
        }
    }

    protected function render() {
        foreach ($this->children as $child) {
            $this->data[basename($child)] = $this->getChild($child);
        }

        if (file_exists(DIR_TEMPLATE . $this->template)) {

            if (is_object($this->language)) {
                extract($this->language->getAllData());
            }

            extract($this->data);

            $data_layer = $this->data_layer;
            
            ob_start();

            require(DIR_TEMPLATE . $this->template);

            $this->output = ob_get_contents();

            ob_end_clean();

            return $this->output;
        } else {
            trigger_error('Error: Could not load template ' . DIR_TEMPLATE . $this->template . '!');
            exit();
        }
    }

}

?>