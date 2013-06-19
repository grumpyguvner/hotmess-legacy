<?php

class ModelLocalisationLanguageManager extends Model {

    private $default = 'english';
    private $default_file_flag = 'DEFAULT';

    public function updateLanguageDB($filename, $data) {
        $language_file_data = $this->getLanguageFileData($filename);

        foreach ($language_file_data as $language_id => $language_manager) {

            $sql = "SELECT language_manager_id "
                    . "FROM `" . DB_PREFIX . "language_manager` "
                    . "WHERE application = '" . $this->db->escape($language_manager['application']) . "' "
                    . "   AND directory = '" . $this->db->escape($language_manager['directory']) . "' "
                    . "   AND filename = '" . $this->db->escape($language_manager['filename']) . "'";
            $query = $this->db->query($sql);

            if (isset($data['language_manager'][$language_id]['value'])) {
                    array_walk($data['language_manager'][$language_id]['value'], function(&$n) {
                            $n = html_entity_decode($n, ENT_QUOTES, 'UTF-8');
                    });
                if ($query->num_rows > 0) {
                    $sql = "UPDATE `" . DB_PREFIX . "language_manager` "
                            . "SET language_id = '" . (int) $language_id . "', "
                            . "   application = '" . $this->db->escape($language_manager['application']) . "', "
                            . "   directory = '" . $this->db->escape($language_manager['directory']) . "', "
                            . "   filename = '" . $this->db->escape($language_manager['filename']) . "', "
                            . "   value = '" . $this->db->escape(serialize($data['language_manager'][$language_id]['value'])) . "' "
                            . "WHERE language_manager_id = '" . (int) $query->row['language_manager_id'] . "'";
                    $this->db->query($sql);
                } else {
                    $sql = "INSERT INTO `" . DB_PREFIX . "language_manager` "
                            . "SET language_id = '" . (int) $language_id . "', "
                            . "   application = '" . $this->db->escape($language_manager['application']) . "', "
                            . "   directory = '" . $this->db->escape($language_manager['directory']) . "', "
                            . "   filename = '" . $this->db->escape($language_manager['filename']) . "', "
                            . "   value = '" . $this->db->escape(serialize($data['language_manager'][$language_id]['value'])) . "'";
                    $this->db->query($sql);
                    
                    $language_manager_id = $this->db->getLastId();
                    
                    $sql = "INSERT INTO `" . DB_PREFIX . "language_manager_to_store` "
                            . "SET language_manager_id = '" . (int) $language_manager_id . "', "
                            . "   store_id = '" . 0 . "'";
                    $this->db->query($sql);
                }
            } else {
                $sql = "DELETE lm.*, lm2s.* "
                        . "FROM `" . DB_PREFIX . "language_manager` lm "
                        . "LEFT JOIN `" . DB_PREFIX . "language_manager_to_store` lm2s ON lm2s.language_manager_id = lm.language_manager_id "
                        . "WHERE lm.application = '" . $this->db->escape($language_manager['application']) . "' "
                        . "   AND (lm.directory = '" . $this->db->escape($language_manager['directory']) . "' OR lm.language_id = '" . (int) $language_id . "')  "
                        . "   AND lm.filename = '" . $this->db->escape($language_manager['filename']) . "'";
                $query = $this->db->query($sql);
            }
        }
    }

    public function getLanguageFiles() {
        $this->load->model('localisation/language');

        $languageFiles = array();

        $folders = self::getLanguageFolders();
        $languages = $this->model_localisation_language->getLanguages();

        foreach ($folders as $folder) {
            $folderFiles = array();

            $files = glob($folder  . '/' . $this->default . '/*/*.php');
            if ($files) {
                $folderFiles = $files;
            }

            foreach ($languages as $language) {
                $files = glob($folder . '/' . $language['directory'] . '/*/*.php');
                if ($files) {
                    $folderFiles = $files;
                }
            }

            foreach ($folderFiles as $file) {
                $data = explode('/', dirname($file));

                $file = end($data) . '/' . basename($file, '.php');

                if (!in_array($file, $languageFiles)) {
                    $languageFiles[] = $file;
                }
            }
        }

        natcasesort($languageFiles);

        array_unshift($languageFiles, $this->default_file_flag);

        return $languageFiles;
    }

    public function getLanguageFileData($filename) {
        $app_dir = self::getApplicationDir();

        $this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();

        $data = array();

        foreach ($languages as $language) {
            $data[$language['language_id']] = array('language_id' => $language['language_id'],
                'application' => $app_dir,
                'directory' => $language['directory'],
                'filename' => ($filename == $this->default_file_flag) ? $language['filename'] : $filename,
                'value' => $this->dataLoadDB($language['directory'], ($filename == $this->default_file_flag) ? $language['filename'] : $filename),
                'default' => array());
        }

        foreach ($data as &$language) {
            $language_data = $this->dataLoadFiles($language['directory'], $language['filename']);

            foreach ($language_data as $key => $value) {
                if (!array_key_exists($key, $language['default'])) {
                    foreach ($data as &$l) {
                        $l['default'][$key] = false;
                    }
                }
                $language['default'][$key] = $value;
            }
        }

        return $data;
    }

    private function dataLoadFiles($directory, $filename) {
        $data = array();

        $app_dir = self::getApplicationDir();
        $folders = self::getLanguageFolders($this->config->get('config_base_template'), $this->config->get('config_template'));
        
        $files = array();

        foreach ($folders as $value) {
            $files[] = $value . '/' . $this->default . '/' . $filename . '.php';
            if ($directory != $this->default)
            {
                $files[] = $value . '/' . $directory . '/' . $filename . '.php';
            }
        }

        foreach ($files as $file) {
            if (file_exists($file)) {
                $_ = array();

                require($file);

                array_walk($_, function(&$n) {
                            $n = htmlentities($n, ENT_QUOTES, 'UTF-8');
                        });

                $data = array_merge($data, $_);
            }
        }

        return $data;
    }

    private function dataLoadDB($directory, $filename) {
        $data = array();

        $app_dir = self::getApplicationDir();

        $sql = "SELECT value "
                . "FROM `" . DB_PREFIX . "language_manager` "
                . "WHERE application = '" . $this->db->escape($app_dir) . "' "
                . "AND directory = '" . $this->db->escape($directory) . "' "
                . "AND filename = '" . $this->db->escape($filename) . "'";
        $query = $this->db->query($sql);
        if ($query->num_rows > 0) {
            foreach ($query->rows as $row) {
                $_ = unserialize($row['value']);

                if (is_array($_)) {
                    
                    array_walk($_, function(&$n) {
                            $n = htmlentities($n, ENT_QUOTES, 'UTF-8');
                    });
                    $data = array_merge($data, $_);
                }
            }
        }

        return $data;
    }

    static function getApplicationDir() {
        return DIR_CATALOG;
    }

    static function getLanguageFolders($base, $default) {
        
        $folders = array(DIR_CATALOG . 'language');
        
        if (is_dir(DIR_CATALOG . 'view/theme/' . $base . '/language'))
        {
            $folders[] = DIR_CATALOG . 'view/theme/' . $base . '/language';
        }
        
        if (is_dir(DIR_CATALOG . 'view/theme/' . $default . '/language'))
        {
            $folders[] = DIR_CATALOG . 'view/theme/' . $default . '/language';
        }
        
        return $folders;
    }

}

?>