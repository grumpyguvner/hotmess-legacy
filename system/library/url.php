<?php

class Url {

    private $url;
    private $ssl;
    private $rewrite = array();

    public function __construct($url, $ssl = '') {
        $this->url = $url;
        $this->ssl = $ssl;
    }

    public function addRewrite($rewrite) {
        $this->rewrite[] = $rewrite;
    }

    public function link($route, $args = '', $connection = 'NONSSL') {

        if (!$this->permission($route))
            return false;

        if ($connection == 'NONSSL') {
            $url = $this->url;
        } else {
            $url = $this->ssl;
        }

        $url .= 'index.php?route=' . $route;

        if ($args) {
            $url .= str_replace('&', '&amp;', '&' . ltrim($args, '&'));
        }

        foreach ($this->rewrite as $rewrite) {
            $url = $rewrite->rewrite($url);
        }

        return $url;
    }

    public function setCheckPermission($checkPermission, $user = null) {
        if (!is_null($user))
            $this->user = $user;

        if (isset($this->user)) {
            $this->checkPermission = $checkPermission;
        }
    }

    private function permission($route) {
        if (isset($this->checkPermission) && $this->checkPermission) {

            if (!isset($this->user))
                $this->user = $this->registry->get('user');

            $part = explode('/', $route);

            $route = '';

            if (isset($part[0])) {
                $route .= $part[0];
            }

            if (isset($part[1])) {
                $route .= '/' . $part[1];
            }

            $ignore = array(
                'common/home',
                'common/login',
                'common/logout',
                'common/forgotten',
                'common/reset',
                'error/not_found',
                'error/permission'
            );

            if (!in_array($route, $ignore) && !$this->user->hasPermission('access', $route)) {
                return false;
            }
        }
        return true;
    }

}

?>