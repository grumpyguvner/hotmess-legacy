<?php  
class ControllerModuleBlocks extends Controller {
	protected function index($setting) {

		$this->data['content'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
                
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blocks.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/blocks.tpl';
		} else {
			$this->template = 'default/template/module/blocks.tpl';
		}
		
		$this->render();

	}
}
?>