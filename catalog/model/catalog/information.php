<?php
class ModelCatalogInformation extends Model {
	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE i.information_id = '" . (int)$information_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1'");
	
                if ($query->num_rows) {
                        $description = html_entity_decode($query->row['description'], ENT_QUOTES, 'UTF-8');
                        $pattern = "/\[information_id=(.*)\]/i";
                        
                        while (preg_match($pattern, $description, $matches)) {
                            $embed_id = $matches[1];
                            $embed_info = $this->getInformation($embed_id);
                            if ($embed_info)
                                $replace_text = html_entity_decode($embed_info['description'], ENT_QUOTES, 'UTF-8');
                            else
                                $replace_text = "INFORMATION ID " . $embed_id . " NOT FOUND";
                            $replace_pattern = "/\[information_id=" . $embed_id . "\]/i";
                            $description = preg_replace($replace_pattern, $replace_text, $description);
                        }
                        
			$query->row['description'] = $description;
                }
		return $query->row;
	}
	
	public function getInformations() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");
		
		return $query->rows;
	}
	
	public function getInformationLayoutId($information_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
		 
		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return $this->config->get('config_layout_information');
		}
	}	
}
?>