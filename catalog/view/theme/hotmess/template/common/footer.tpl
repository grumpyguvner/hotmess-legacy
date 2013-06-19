</div>
<div class="clearfix"></div>
</div>
<div id="container_footer">
    <div id="footer">
        <div class="container_24">
            <div class="footer-column">
                <?php /*                 * ****************FOOTER SETTINGS******************** */ ?>
                <?php include "catalog/view/theme/hotmess/template/bossthemes/Boss_footer_setting.php"; ?>
                <?php if ($informations) { ?>
                    <div class="columns">
                        <div class="column">
                            <div class="column_content">
                                <h3><?php echo $text_information; ?></h3>
                                <ul>
                                    <?php 
                                    foreach ($informations as $key => $information) {
                                        if ($information['sort_order'] < 10) {
                                            ?>
                                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                            <?php
                                        }
                                    }
                                    ?>
                                </ul>
                            </div>
                        </div>

                        <div class="column">
                            <div class="column_content">
                                <h3>HELP</h3>
                                <ul>
                                    <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                                    <?php
                                    foreach ($informations as $key => $information) {
                                        if ($information['sort_order'] >= 10 && $information['sort_order'] < 20) {
                                            ?>
                                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                            <?php
                                        }
                                    }
                                    ?>
                                </ul>
                            </div>
                        </div>

                        <div class="column">
                            <div class="column_content">
                                <h3><?php echo $text_service; ?></h3>
                                <ul>
                                    <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                                    <?php
                                    foreach ($informations as $key => $information) {
                                        if ($information['sort_order'] >= 20 && $information['sort_order'] < 30) {
                                            ?>
                                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                            <?php
                                        }
                                    }
                                    ?>
                                </ul>
                            </div>
                        </div>

                        <div class="column">
                            <div class="column_content">
                                <h3>COOL STUFF</h3>
                                <ul>
                                    <?php
                                    foreach ($informations as $key => $information) {
                                        if ($information['sort_order'] >= 30) {
                                            ?>
                                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                            <?php
                                        }
                                    }
                                    ?>
                                </ul>
                            </div>
                        </div>
                    </div>
<?php } ?>
                <div id="social-footer">
                    <div class="media-links">
                        <a href="http://twitter.com/hotmessclothes"><img src="/image/data/FOOTER/Twitter.png" ></a>
                        <a href="http://www.facebook.com/pages/Hotmess/467402680008369"><img src="/image/data/FOOTER/Facebook.png" ></a>
                        <a href="#"><img src="/image/data/FOOTER/youtube.png" ></a>
                        <a href="#"><img src="/image/data/FOOTER/linkedin.png" ></a>
                    </div>
                    <div class="youth">
                    <a href="uk-youth-charity"><img src="/image/data/FOOTER/UK-Youth.png" ></a>
                    </div>

<!--                    <form action="/index.php" method="get" class="newsletter-form" target="_blank">
                        <input type="hidden" name="route" value="module/newsletter/callback">
                        <input type="hidden" name="subscribe" value="1">
                        <div class="newsletter_input input-container">
                            <a class="button-submit submit" href="#"></a>
                            <input type="email" name="email" placeholder="Email Address">
                        </div>
                    </form>-->
                </div>
            </div>



        </div>
        <div id="powered"><div class="container_24"><div class="powered-1"><?php echo $powered; ?></div></div></div>
    </div>
</div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
</div>
</body></html>