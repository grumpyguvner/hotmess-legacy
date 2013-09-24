<?php
class Language {
    private $default = 'english';
    private $directory;
    private $theme = array('default');
    private $data = array();
    private $db;
    private $config;
    private $language_manager = false;
    private $language_manager_log = false;

    public function __construct($directory, $registry = null) {
        
        if (!is_null($registry))
        {
            $this->config = $registry->get('config');
            $this->db = $registry->get('db');
            
            if ($this->config->get("config_template") && !in_array($this->config->get("config_template"), $this->theme)) 
            {
                $this->theme[] = $this->config->get("config_template");
            }
            $this->language_manager = ($this->config->get("language_manager_status")) ? true : false;
            
            $this->language_manager_log = ($this->config->get("language_manager_log")) ? true : false;
            
            if ($this->language_manager_log && !isset($this->session->data['language_manager']))
            {
                $this->request->data['language_manager'] = array();
            }
        }
        
        $this->directory = $directory;
    }

    public function get($key) {
        return (isset($this->data[$key]) ? $this->data[$key] : $key);
    }
    
    public function getAllData() {
        
        return $this->data;
    }

    public function load($filename) {
        
        $is_default = ($filename == $this->directory) ? true : false;

        $directories = array();
        $directories[] = $this->default;
        if ($this->default != $this->directory)
        {
            $directories[] = $this->directory;
        }

        foreach ($directories as $directory) {
            
            if ($is_default)
            {
                $filename = $directory;
            }
            
            $files = array();
            $files[] = DIR_LANGUAGE . $directory . '/' . $filename . '.php';

            foreach ($this->theme as $theme) {
                $files[] = DIR_TEMPLATE . $theme . "/language/" . $directory . '/' . $filename . '.php';
            }

            foreach ($files as $file) {
                if (file_exists($file)) {
                    $_ = array();

                    require($file);

                    $this->data = array_merge($this->data, $_);
                }
            }
        }
        
        if ($this->language_manager) {
            $sql = "SELECT value "
                    . "FROM `" . DB_PREFIX . "language_manager` "
                    . "WHERE application = '" . $this->db->escape(DIR_APPLICATION) . "' "
                    . "AND directory = '" . $this->db->escape($this->directory) . "' "
                    . "AND filename = '" . $this->db->escape($filename) . "'";
            $query = $this->db->query($sql);
            if ($query->num_rows > 0) {
                foreach ($query->rows as $row) {
                    $_ = unserialize($row['value']);

                    if (is_array($_)) {
                        $this->data = array_merge($this->data, $_);
                    }
                }
            }
        }

        if ($this->language_manager_log) {
            $this->request->data['language_manager'] = array('directory' => $this->directory,
                'filename' => $filename);
        }

        return $this->data;
    }

}

?>