<?php
class ModelModuleLanguageManager extends Model {
    public function createDatabaseTables() {
        $sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "language_manager` (
                    `language_manager_id` int(11) NOT NULL AUTO_INCREMENT,
                    `language_id` int(11) NOT NULL,
                    `application` varchar(180) NOT NULL,
                    `directory` varchar(45) NOT NULL,
                    `filename` varchar(100) NOT NULL,
                    `value` text NOT NULL,
                    PRIMARY KEY (`language_manager_id`),
                    KEY `language_id` (`language_id`),
                    KEY `application` (`application`, `directory`, `filename`)
		) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin";
        $this->db->query($sql);

        $sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "language_manager_to_store` (
                `language_manager_id` int(11) NOT NULL,
                `store_id` int(11) NOT NULL,
                PRIMARY KEY (`language_manager_id`,`store_id`)
              ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin";
        $this->db->query($sql);
    }

    public function dropDatabaseTables() {
        $sql = "DROP TABLE IF EXISTS `" . DB_PREFIX . "language_manager_to_store`";
        $this->db->query($sql);

        $sql = "DROP TABLE IF EXISTS `" . DB_PREFIX . "language_manager`";
        $this->db->query($sql);
    }
}
?>