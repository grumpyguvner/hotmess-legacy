</div>

<div class="clearfix"></div>
</div>
<div id="container_footer">
    <div id="footer">
        <div class="container_24">
            <div class="footer-column">
                <?php /*                 * ****************FOOTER SETTINGS******************** */ ?>
                <div class="block-about-us">
                    <div class="block-content"><?php if(isset($blocks[0]['description'])){echo $blocks[0]['description'];} ?></div>
                </div>
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
                
                <div id="newsletter_footer" class="inputContainer" style="float: right;margin-top: 67px;">
                  <div style="margin-top: 2px;"class="button-enter" title="sign up"></div>
                  <input type="email" name="email" placeholder="enter your email here for the latest" value="" />
                </div>
                <div id="social-footer" style="display: inline-block;margin-top: 20px;float: none">
                    <div class="media-links">
                        <a href="http://twitter.com/hotmessclothes" target="_blank"><img src="/image/data/FOOTER/Twitter.png" ></a>
                        <a href="http://www.facebook.com/pages/Hotmess/467402680008369" target="_blank"><img src="/image/data/FOOTER/Facebook.png" ></a>
                        <a href="http://www.youtube.com/channel/UC_0MRGFFNu7z7GByJwXqnQA" target="_blank"><img src="/image/data/FOOTER/youtubeb.png" ></a>
                        <a href="http://instagram.com/HOTMESSCLOTHING" target="_blank"><img src="/image/data/FOOTER/instagramb.png" ></a>
                    </div>
                    <div class="youth">
                    <a href="uk-youth-charity"><img src="/image/data/FOOTER/UK-Youth.png" ></a>
                    </div>

                </div><br />
                <div class="powered-1" style="float: right;margin-top: 20px;color: #fff"><?php echo $powered; ?></div>
                <div style="display: inline-block;margin-top: 20px;">
                <img src="/image/data/FOOTER/payment.png" >
                </div>
            </div>



        </div>
<!--        <div id="powered"><div class="container_24"><div class="powered-1"><?php echo $powered; ?></div></div></div>-->
    </div>
</div>

</div>
<?php echo $welcome_popup; ?>
</body></html>