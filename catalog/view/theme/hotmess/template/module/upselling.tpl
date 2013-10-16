<?php
if ($upselling_products)
{
    $html = '<div style="height: 20px;"></div>';
    $html .= '<div class="iconline homepage-header" style="clear:both; font-size: 18px; margin-bottom: 10px;">COMPLETE YOUR LOOK WITH...</div>';
    foreach ($upselling_products as $key => $product) {
         $html .= '<div class="product" style="float: left; width: 25%;">';
        if ($product['thumb']) {
            $html .= '<div class="image" style="float: left;"><a href="'.$product['href'].'"><img src="'.$product['thumb'].'" alt="'.$product['name'].'" title="'.$product['name'].'" /></a></div>';
        }

        $html .= '<div class="name"><a href="'.$product['href'].'">'.$product['name'].'</a></div>';

        $html .= '<div class="price">';
        if (!$product['special']) {
        $html .= $product['price'];
        } else {
        $html .= '<span class="price-old">'.$product['price'].'</span> <span class="price-new">'.$product['special'].'</span>';
        }
        $html .= '</div>';
        $html .= '</div>';
        
        if ($key >= 3) break;
    }

    echo $html;
}
?>