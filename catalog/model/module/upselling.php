<?php
class ModelModuleUpselling extends Model {
	public function getUpsellingProducts($product_id = null) {
        
            if ($this->config->get('upselling_product'))
            {
                $products = explode(',', $this->config->get('upselling_product'));

                $related_products = array();
                $ignore_products  = array();
                
                if (!empty($product_id))
                {
                    $ignore_products[] = $product_id;
                }
                
                $this->load->model('catalog/product');
                $cart_products = $this->cart->getProducts();

                foreach ($this->cart->getProducts() as $cart)
                {
                    $ignore_products[] = $cart['product_id'];
                }

                if (!empty($product_id))
                {
                    if (!in_array($product_id, $products))
                    {
                        $results = $this->model_catalog_product->getProductRelated($product_id);
                        $related_products = array_merge($related_products, array_keys($results));
                    }
                } else {
                    foreach ($ignore_products as $pid)
                    {
                        if (!in_array($pid, $products))
                        {
                            $results = $this->model_catalog_product->getProductRelated($pid);
                            $related_products = array_merge($related_products, array_keys($results));
                        }
                    }
                }
                
                $front = array();
                $back = array();
                foreach ($products as $pid)
                {
                    if (!in_array($pid, $ignore_products))
                    {
                       if (in_array($pid, $related_products))
                       {
                           $front[] = $pid;
                       } else {
                           $back[] = $pid;
                       }
                    }
                }
                
                if ($this->config->get('upselling_only_related'))
                {
                    $products = $front;
                } else {
                    $products = array_merge($front, $back);
                }

                $upselling_products  = array();
                foreach ($products as $pid)
                {
                    $product_info = $this->model_catalog_product->getProduct($pid);
                    if ($product_info)
                    {
                         $upselling_products[] = $product_info;
                    }
                }

                return $upselling_products;
            }
	}
}
?>