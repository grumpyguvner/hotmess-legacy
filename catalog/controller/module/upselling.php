<?php
class ControllerModuleUpselling extends Controller {
	protected function index($setting) {
		$this->language->load('module/upselling'); 

                $this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/product'); 
		
		$this->load->model('tool/image');
		
                $this->load->model('module/upselling');

                $this->data['upselling_products'] = array();

                $upselling_products = $this->model_module_upselling->getUpsellingProducts();
		
		foreach ($upselling_products as $product_info) {
                        if ($product_info['image']) {
                                $image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
                        } else {
                                $image = false;
                        }

                        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                                $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                                $price = false;
                        }

                        if ((float)$product_info['special']) {
                                $special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                                $special = false;
                        }

                        if ($this->config->get('config_review_status')) {
                                $rating = $product_info['rating'];
                        } else {
                                $rating = false;
                        }

                        $this->data['upselling_products'][] = array(
                                'product_id' => $product_info['product_id'],
                                'thumb'   	 => $image,
                                'name'    	 => $product_info['name'],
                                'price'   	 => $price,
                                'special' 	 => $special,
                                'rating'     => $rating,
                                'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
                                'href'    	 => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
                        );
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/upselling.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/upselling.tpl';
		} else {
			$this->template = 'default/template/module/upselling.tpl';
		}

		$this->render();
	}
}
?>