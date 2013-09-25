<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div> <!-- End .breadcrumb-->
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
        </div> <!-- End .heading -->

        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

                <div class="htabs" id="mainTabs">
                    <a href="#BlockContent"><?php echo $tab_content; ?></a>
                    <a href="#BlockHeader"><?php echo $tab_header; ?></a>
                    <a href="#BlockFooter"><?php echo $tab_footer; ?></a>

                </div> <!-- End .mainTabs -->

                <!-- CUSTOM BLOCK CONTENT -->
                <div id="BlockContent" class="htabs-content">
                    <div id="blockcontenttab" class="vtabs">
                        <?php $module_row = 1; ?>
                        <?php foreach ($modules as $module) { ?>
                            <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_block . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
                            <?php $module_row++; ?>
                        <?php } ?>
                        <span id="module-add"><?php echo $button_add_new_block; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> 
                    </div>
                    <?php $module_row = 1; ?>
                    <?php foreach ($modules as $module) { ?>
                        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
                            <div id="language-<?php echo $module_row; ?>" class="htabs">
                                <?php foreach ($languages as $language) { ?>
                                    <a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                <?php } ?>
                            </div>
                            <?php foreach ($languages as $language) { ?>
                                <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
                                    <table class="form">
                                        <tr>
                                            <td><?php echo $entry_content; ?></td>
                                            <td><textarea name="blocks_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea></td>
                                        </tr>
                                    </table>
                                </div>
                            <?php } ?>
                            <table class="form">
                                <tr>
                                    <td><?php echo $entry_layout; ?></td>
                                    <td><select name="blocks_module[<?php echo $module_row; ?>][layout_id]">
                                            <?php foreach ($layouts as $layout) { ?>
                                                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td><?php echo $entry_store; ?></td>
                                    <td><div class="scrollbox">
                                            <?php $class = 'even'; ?>
                                            <div class="<?php echo $class; ?>">
                                                <?php if (isset($module['store_id']) && in_array(0, $module['store_id'])) { ?>
                                                    <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="0" checked="checked" />
                                                <?php } else { ?>
                                                    <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="0" />
                                                <?php } ?>
                                                <?php echo $text_default; ?>
                                            </div>
                                            <?php foreach ($stores as $store) { ?>
                                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                                <div class="<?php echo $class; ?>">
                                                    <?php if (isset($module['store_id']) && in_array($store['store_id'], $module['store_id'])) { ?>
                                                        <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                        <?php echo $store['name']; ?>
                                                    <?php } else { ?>
                                                        <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" />
                                                        <?php echo $store['name']; ?>
                                                    <?php } ?>
                                                </div>
                                            <?php } ?>
                                        </div></td>
                                </tr>
                                <tr>
                                    <td><?php echo $entry_position; ?></td>
                                    <td><select name="blocks_module[<?php echo $module_row; ?>][position]">
                                            <?php if ($module['position'] == 'content_top') { ?>
                                                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                                            <?php } else { ?>
                                                <option value="content_top"><?php echo $text_content_top; ?></option>
                                            <?php } ?>
                                            <?php if ($module['position'] == 'content_bottom') { ?>
                                                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                                            <?php } else { ?>
                                                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                                            <?php } ?>
                                            <?php if ($module['position'] == 'column_left') { ?>
                                                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                                            <?php } else { ?>
                                                <option value="column_left"><?php echo $text_column_left; ?></option>
                                            <?php } ?>
                                            <?php if ($module['position'] == 'column_right') { ?>
                                                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                                            <?php } else { ?>
                                                <option value="column_right"><?php echo $text_column_right; ?></option>
                                            <?php } ?>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td><?php echo $entry_status; ?></td>
                                    <td><select name="blocks_module[<?php echo $module_row; ?>][status]">
                                            <?php if ($module['status']) { ?>
                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                <option value="0"><?php echo $text_disabled; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                            <?php } ?>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td><?php echo $entry_sort_order; ?></td>
                                    <td><input type="text" name="blocks_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
                                </tr>
                            </table>
                        </div>
                        <?php $module_row++; ?>
                    <?php } ?>
                </div>
                <!-- END CUSTOM BLOCK CONTENT -->
                                
                <!-- CUSTOM BLOCK HEADER -->
                <div id="BlockHeader" class="htabs-content">
                    <div id="blockheadertab" class="vtabs">
                        <?php $module_header_row = 1; ?>
                        <?php foreach ($modules_header as $module_header) { ?>
                            <a href="#tab-module_header-<?php echo $module_header_row; ?>" id="module_header-<?php echo $module_header_row; ?>"><?php echo $tab_block . ' ' . $module_header_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module_header-<?php echo $module_header_row; ?>').remove(); $('#tab-module_header-<?php echo $module_header_row; ?>').remove(); return false;" /></a>
                            <?php $module_header_row++; ?>
                        <?php } ?>
                        <span id="module_header-add"><?php echo $button_add_new_block; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModuleHeader();" /></span> 
                    </div>
                    
                    <?php $module_header_row = 1; ?>
                    <?php foreach ($modules_header as $module_header) { ?>
                        <div id="tab-module_header-<?php echo $module_header_row; ?>" class="vtabs-content">
                            <div id="language_header-<?php echo $module_header_row; ?>" class="htabs">
                                <?php foreach ($languages as $language) { ?>
                                    <a href="#tab-language_header-<?php echo $module_header_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                <?php } ?>
                            </div>
                            <?php foreach ($languages as $language) { ?>
                                <div id="tab-language_header-<?php echo $module_header_row; ?>-<?php echo $language['language_id']; ?>">
                                    <table class="form">
                                        <tr>
                                            <td><?php echo $entry_content; ?></td>
                                            <td><textarea name="blocks_module_header[<?php echo $module_header_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description2-<?php echo $module_header_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module_header['description'][$language['language_id']]) ? $module_header['description'][$language['language_id']] : ''; ?></textarea></td>
                                        </tr>
                                    </table>
                                </div>
                            <?php } ?>
                            <table class="form">
                                <!--tr>
                                    <td><?php /* echo $entry_layout; ?></td>
                                    <td><select name="blocks_module_header[<?php echo $module_header_row; ?>][layout_id]">
                                            <?php foreach ($layouts as $layout) { ?>
                                                <?php if ($layout['layout_id'] == $module_header['layout_id']) { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                <?php } ?>
                                            <?php } */ ?>
                                        </select></td>
                                </tr-->
                                <tr>
                                    <td><?php echo $entry_store; ?></td>
                                    <td><div class="scrollbox">
                                            <?php $class = 'even'; ?>
                                            <div class="<?php echo $class; ?>">
                                                <?php if (isset($module_header['store_id']) && in_array(0, $module_header['store_id'])) { ?>
                                                    <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="0" checked="checked" />
                                                <?php } else { ?>
                                                    <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="0" />
                                                <?php } ?>
                                                <?php echo $text_default; ?>
                                            </div>
                                            <?php foreach ($stores as $store) { ?>
                                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                                <div class="<?php echo $class; ?>">
                                                    <?php if (isset($module_header['store_id']) && in_array($store['store_id'], $module_header['store_id'])) { ?>
                                                        <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                        <?php echo $store['name']; ?>
                                                    <?php } else { ?>
                                                        <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" />
                                                        <?php echo $store['name']; ?>
                                                    <?php } ?>
                                                </div>
                                            <?php } ?>
                                        </div></td>
                                </tr>
                                <!--tr>
                                    <td><?php /* echo $entry_position; ?></td>
                                    <td><select name="blocks_module_header[<?php echo $module_header_row; ?>][position]">
                                            <?php if ($module_header['position'] == 'content_top') { ?>
                                                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                                            <?php } else { ?>
                                                <option value="content_top"><?php echo $text_content_top; ?></option>
                                            <?php } ?>
                                            <?php if ($module_header['position'] == 'content_bottom') { ?>
                                                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                                            <?php } else { ?>
                                                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                                            <?php } ?>
                                            <?php if ($module_header['position'] == 'column_left') { ?>
                                                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                                            <?php } else { ?>
                                                <option value="column_left"><?php echo $text_column_left; ?></option>
                                            <?php } ?>
                                            <?php if ($module_header['position'] == 'column_right') { ?>
                                                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                                            <?php } else { ?>
                                                <option value="column_right"><?php echo $text_column_right; ?></option>
                                            <?php } */ ?>
                                        </select></td>
                                </tr-->
                                <tr>
                                    <td><?php echo $entry_status; ?></td>
                                    <td><select name="blocks_module_header[<?php echo $module_header_row; ?>][status]">
                                            <?php if ($module_header['status']) { ?>
                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                <option value="0"><?php echo $text_disabled; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                            <?php } ?>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td><?php echo $entry_sort_order; ?></td>
                                    <td><input type="text" name="blocks_module_header[<?php echo $module_header_row; ?>][sort_order]" value="<?php echo $module_header['sort_order']; ?>" size="3" /></td>
                                </tr>
                            </table>
                        </div>
                        <?php $module_header_row++; ?>
                    <?php } ?>
                
                    
                </div>
                <!-- END CUSTOM BLOCK HEADER -->
                
                <!-- CUSTOM BLOCK FOOTER -->
                <div id="BlockFooter" class="htabs-content">
                    <div id="blockfootertab" class="vtabs">
                        <?php $module_footer_row = 1; ?>
                        <?php foreach ($modules_footer as $module_footer) { ?>
                            <a href="#tab-module_footer-<?php echo $module_footer_row; ?>" id="module_footer-<?php echo $module_footer_row; ?>"><?php echo $tab_block . ' ' . $module_footer_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module_footer-<?php echo $module_footer_row; ?>').remove(); $('#tab-module_footer-<?php echo $module_footer_row; ?>').remove(); return false;" /></a>
                            <?php $module_footer_row++; ?>
                        <?php } ?>
                        <span id="module_footer-add"><?php echo $button_add_new_block; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModuleFooter();" /></span> 
                    </div>
                    
                    <?php $module_footer_row = 1; ?>
                    <?php foreach ($modules_footer as $module_footer) { ?>
                        <div id="tab-module_footer-<?php echo $module_footer_row; ?>" class="vtabs-content">
                            <div id="language_footer-<?php echo $module_footer_row; ?>" class="htabs">
                                <?php foreach ($languages as $language) { ?>
                                    <a href="#tab-language_footer-<?php echo $module_footer_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                <?php } ?>
                            </div>
                            <?php foreach ($languages as $language) { ?>
                                <div id="tab-language_footer-<?php echo $module_footer_row; ?>-<?php echo $language['language_id']; ?>">
                                    <table class="form">
                                        <tr>
                                            <td><?php echo $entry_content; ?></td>
                                            <td><textarea name="blocks_module_footer[<?php echo $module_footer_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description1-<?php echo $module_footer_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module_footer['description'][$language['language_id']]) ? $module_footer['description'][$language['language_id']] : ''; ?></textarea></td>
                                        </tr>
                                    </table>
                                </div>
                            <?php } ?>
                            <table class="form">
                                <!--tr>
                                    <td><?php /* echo $entry_layout; ?></td>
                                    <td><select name="blocks_module_footer[<?php echo $module_footer_row; ?>][layout_id]">
                                            <?php foreach ($layouts as $layout) { ?>
                                                <?php if ($layout['layout_id'] == $module_footer['layout_id']) { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                <?php } ?>
                                            <?php } */ ?>
                                        </select></td>
                                </tr-->
                                <tr>
                                    <td><?php echo $entry_store; ?></td>
                                    <td><div class="scrollbox">
                                            <?php $class = 'even'; ?>
                                            <div class="<?php echo $class; ?>">
                                                <?php if (isset($module_footer['store_id']) && in_array(0, $module_footer['store_id'])) { ?>
                                                    <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="0" checked="checked" />
                                                <?php } else { ?>
                                                    <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="0" />
                                                <?php } ?>
                                                <?php echo $text_default; ?>
                                            </div>
                                            <?php foreach ($stores as $store) { ?>
                                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                                <div class="<?php echo $class; ?>">
                                                    <?php if (isset($module_footer['store_id']) && in_array($store['store_id'], $module_footer['store_id'])) { ?>
                                                        <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                        <?php echo $store['name']; ?>
                                                    <?php } else { ?>
                                                        <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" />
                                                        <?php echo $store['name']; ?>
                                                    <?php } ?>
                                                </div>
                                            <?php } ?>
                                        </div></td>
                                </tr>
                                <!--tr>
                                    <td><?php /* echo $entry_position; ?></td>
                                    <td><select name="blocks_module_footer[<?php echo $module_footer_row; ?>][position]">
                                            <?php if ($module_footer['position'] == 'content_top') { ?>
                                                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                                            <?php } else { ?>
                                                <option value="content_top"><?php echo $text_content_top; ?></option>
                                            <?php } ?>
                                            <?php if ($module_footer['position'] == 'content_bottom') { ?>
                                                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                                            <?php } else { ?>
                                                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                                            <?php } ?>
                                            <?php if ($module_footer['position'] == 'column_left') { ?>
                                                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                                            <?php } else { ?>
                                                <option value="column_left"><?php echo $text_column_left; ?></option>
                                            <?php } ?>
                                            <?php if ($module_footer['position'] == 'column_right') { ?>
                                                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                                            <?php } else { ?>
                                                <option value="column_right"><?php echo $text_column_right; ?></option>
                                            <?php } */ ?>
                                        </select></td>
                                </tr-->
                                <tr>
                                    <td><?php echo $entry_status; ?></td>
                                    <td><select name="blocks_module_footer[<?php echo $module_footer_row; ?>][status]">
                                            <?php if ($module_footer['status']) { ?>
                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                <option value="0"><?php echo $text_disabled; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                            <?php } ?>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td><?php echo $entry_sort_order; ?></td>
                                    <td><input type="text" name="blocks_module_footer[<?php echo $module_footer_row; ?>][sort_order]" value="<?php echo $module_footer['sort_order']; ?>" size="3" /></td>
                                </tr>
                            </table>
                        </div>
                        <?php $module_footer_row++; ?>
                    <?php } ?>
                
                    
                </div>
                <!-- END CUSTOM BLOCK FOOTER -->
            </form>
        </div> <!-- End .content -->

    </div> <!-- End .box -->

</div> <!-- End #content -->
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php $module_footer_row = 1; ?>
  <?php foreach ($modules_footer as $module_footer) { ?>
      <?php foreach ($languages as $language) { ?>
        CKEDITOR.replace('description1-<?php echo $module_footer_row; ?>-<?php echo $language['language_id']; ?>', {
            filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
        });
        <?php } ?>
    <?php $module_footer_row++; ?>
<?php } ?>
<?php $module_header_row = 1; ?>
  <?php foreach ($modules_header as $module_header) { ?>
      <?php foreach ($languages as $language) { ?>
        CKEDITOR.replace('description2-<?php echo $module_header_row; ?>-<?php echo $language['language_id']; ?>', {
            filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
        });
        <?php } ?>
    <?php $module_header_row++; ?>
<?php } ?>    
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
    <?php foreach ($languages as $language) { ?>
            CKEDITOR.replace('description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
                filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
            });
    <?php } ?>
    <?php $module_row++; ?>
<?php } ?>
    //--></script>
<script type="text/javascript"><!--
    var module_row = <?php echo $module_row; ?>;

    function addModule() {	
        html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
        html += '  <div id="language-' + module_row + '" class="htabs">';
<?php foreach ($languages as $language) { ?>
                html += '    <a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
<?php } ?>
            html += '  </div>';

<?php foreach ($languages as $language) { ?>
                    html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
                    html += '      <table class="form">';
                    html += '        <tr>';
                    html += '          <td><?php echo $entry_content; ?></td>';
                    html += '          <td><textarea name="blocks_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
                    html += '        </tr>';
                    html += '      </table>';
                    html += '    </div>';
<?php } ?>

                html += '  <table class="form">';
                html += '    <tr>';
                html += '      <td><?php echo $entry_layout; ?></td>';
                html += '      <td><select name="blocks_module[' + module_row + '][layout_id]">';
<?php foreach ($layouts as $layout) { ?>
                    html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
<?php } ?>
                html += '      </select></td>';
                html += '    </tr>';
                html += '    <tr>';
                html += '      <td><?php echo $entry_store; ?></td>';
                html += '      <td><div class="scrollbox">';
                divclass = 'even';
                html += '      	  <div class="' + divclass + '">';
                html += '		    <input type="checkbox" name="blocks_module[' + module_row + '][store_id][]" value="0" checked="checked" />';
                html += '			<?php echo $text_default; ?>';
                html += '         </div>';
<?php foreach ($stores as $store) { ?>
                    divclass = (divclass == 'even' ? 'odd' : 'even');
                    html += '         <div class="' + divclass + '">';
                    html += '           <input type="checkbox" name="blocks_module[' + module_row + '][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />';
                    html += '           <?php echo $store['name']; ?>';
                    html += '          </div>';
<?php } ?>
            html += '      </div></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_position; ?></td>';
            html += '      <td><select name="blocks_module[' + module_row + '][position]">';
            html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
            html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
            html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
            html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
            html += '      </select></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_status; ?></td>';
            html += '      <td><select name="blocks_module[' + module_row + '][status]">';
            html += '        <option value="1"><?php echo $text_enabled; ?></option>';
            html += '        <option value="0"><?php echo $text_disabled; ?></option>';
            html += '      </select></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_sort_order; ?></td>';
            html += '      <td><input type="text" name="blocks_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
            html += '    </tr>';
            html += '  </table>'; 
            html += '</div>';
	
            $('#BlockContent').append(html);
	
<?php foreach ($languages as $language) { ?>
                    CKEDITOR.replace('description-' + module_row + '-<?php echo $language['language_id']; ?>', {
                        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
                    });  
<?php } ?>
	
                $('#language-' + module_row + ' a').tabs();
	
                $('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_block; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');

                $('#blockcontenttab a').tabs();
	
                $('#module-' + module_row).trigger('click');
	
                module_row++;
            }
            //--></script> 

<script type="text/javascript"><!--
    $('#blockcontenttab .vtabs a').tabs();
    //--></script> 

<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
        $('#language-<?php echo $module_row; ?> a').tabs();
    <?php $module_row++; ?>
<?php } ?> 
    //--></script> 
<!----------------------------------- FOOTER ---------------------------------------->
<script type="text/javascript"><!--
    var module_footer_row = <?php echo $module_footer_row; ?>;

    function addModuleFooter() {	
        html  = '<div id="tab-module_footer-' + module_footer_row + '" class="vtabs-content">';
        html += '  <div id="language_footer-' + module_footer_row + '" class="htabs">';
<?php foreach ($languages as $language) { ?>
                html += '    <a href="#tab-language_footer-'+ module_footer_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
<?php } ?>
            html += '  </div>';

<?php foreach ($languages as $language) { ?>
                    html += '    <div id="tab-language_footer-'+ module_footer_row + '-<?php echo $language['language_id']; ?>">';
                    html += '      <table class="form">';
                    html += '        <tr>';
                    html += '          <td><?php echo $entry_content; ?></td>';
                    html += '          <td><textarea name="blocks_module_footer[' + module_footer_row + '][description][<?php echo $language['language_id']; ?>]" id="description1-' + module_footer_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
                    html += '        </tr>';
                    html += '      </table>';
                    html += '    </div>';
<?php } ?>

                html += '  <table class="form">';
                html += '    <tr>';
                html += '      <td><?php echo $entry_store; ?></td>';
                html += '      <td><div class="scrollbox">';
                divclass = 'even';
                html += '      	  <div class="' + divclass + '">';
                html += '		    <input type="checkbox" name="blocks_module_footer[' + module_footer_row + '][store_id][]" value="0" checked="checked" />';
                html += '			<?php echo $text_default; ?>';
                html += '         </div>';
<?php foreach ($stores as $store) { ?>
                    divclass = (divclass == 'even' ? 'odd' : 'even');
                    html += '         <div class="' + divclass + '">';
                    html += '           <input type="checkbox" name="blocks_module_footer[' + module_footer_row + '][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />';
                    html += '           <?php echo $store['name']; ?>';
                    html += '          </div>';
<?php } ?>
            html += '      </div></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_status; ?></td>';
            html += '      <td><select name="blocks_module_footer[' + module_footer_row + '][status]">';
            html += '        <option value="1"><?php echo $text_enabled; ?></option>';
            html += '        <option value="0"><?php echo $text_disabled; ?></option>';
            html += '      </select></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_sort_order; ?></td>';
            html += '      <td><input type="text" name="blocks_module_footer[' + module_footer_row + '][sort_order]" value="" size="3" /></td>';
            html += '    </tr>';
            html += '  </table>'; 
            html += '</div>';
	
            $('#BlockFooter').append(html);
	
<?php foreach ($languages as $language) { ?>
                    CKEDITOR.replace('description1-' + module_footer_row + '-<?php echo $language['language_id']; ?>', {
                        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
                    });  
<?php } ?>
	
                $('#language_footer-' + module_footer_row + ' a').tabs();
	
                $('#module_footer-add').before('<a href="#tab-module_footer-' + module_footer_row + '" id="module_footer-' + module_footer_row + '"><?php echo $tab_block; ?> ' + module_footer_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module_footer-' + module_footer_row + '\').remove(); $(\'#tab-module_footer-' + module_footer_row + '\').remove(); return false;" /></a>');

                $('#blockfootertab a').tabs();
	
                $('#module_footer-' + module_footer_row).trigger('click');
	
                module_footer_row++;
            }
            //--></script>

<script type="text/javascript"><!--
    $('#blockfootertab .vtabs a').tabs();
    //--></script>

<script type="text/javascript"><!--
<?php $module_footer_row = 1; ?>
<?php foreach ($modules_footer as $module_footer) { ?>
        $('#language_footer-<?php echo $module_footer_row; ?> a').tabs();
    <?php $module_footer_row++; ?>
<?php } ?> 
    //--></script> 
<!---------------------------------- END FOOTER ----------------------------------------->

<!----------------------------------- HEADER ---------------------------------------->
<script type="text/javascript"><!--
    var module_header_row = <?php echo $module_header_row; ?>;

    function addModuleHeader() {	
        html  = '<div id="tab-module_header-' + module_header_row + '" class="vtabs-content">';
        html += '  <div id="language_header-' + module_header_row + '" class="htabs">';
<?php foreach ($languages as $language) { ?>
                html += '    <a href="#tab-language_header-'+ module_header_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
<?php } ?>
            html += '  </div>';

<?php foreach ($languages as $language) { ?>
                    html += '    <div id="tab-language_header-'+ module_header_row + '-<?php echo $language['language_id']; ?>">';
                    html += '      <table class="form">';
                    html += '        <tr>';
                    html += '          <td><?php echo $entry_content; ?></td>';
                    html += '          <td><textarea name="blocks_module_header[' + module_header_row + '][description][<?php echo $language['language_id']; ?>]" id="description2-' + module_header_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
                    html += '        </tr>';
                    html += '      </table>';
                    html += '    </div>';
<?php } ?>

                html += '  <table class="form">';
                html += '    <tr>';
                html += '      <td><?php echo $entry_store; ?></td>';
                html += '      <td><div class="scrollbox">';
                divclass = 'even';
                html += '      	  <div class="' + divclass + '">';
                html += '		    <input type="checkbox" name="blocks_module_header[' + module_header_row + '][store_id][]" value="0" checked="checked" />';
                html += '			<?php echo $text_default; ?>';
                html += '         </div>';
<?php foreach ($stores as $store) { ?>
                    divclass = (divclass == 'even' ? 'odd' : 'even');
                    html += '         <div class="' + divclass + '">';
                    html += '           <input type="checkbox" name="blocks_module_header[' + module_header_row + '][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />';
                    html += '           <?php echo $store['name']; ?>';
                    html += '          </div>';
<?php } ?>
            html += '      </div></td>';
            html += '    </tr>';
            html += '      <td><?php echo $entry_status; ?></td>';
            html += '      <td><select name="blocks_module_header[' + module_header_row + '][status]">';
            html += '        <option value="1"><?php echo $text_enabled; ?></option>';
            html += '        <option value="0"><?php echo $text_disabled; ?></option>';
            html += '      </select></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_sort_order; ?></td>';
            html += '      <td><input type="text" name="blocks_module_header[' + module_header_row + '][sort_order]" value="" size="3" /></td>';
            html += '    </tr>';
            html += '  </table>'; 
            html += '</div>';
	
            $('#BlockHeader').append(html);
	
<?php foreach ($languages as $language) { ?>
                    CKEDITOR.replace('description2-' + module_header_row + '-<?php echo $language['language_id']; ?>', {
                        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
                    });  
<?php } ?>
	
                $('#language_header-' + module_header_row + ' a').tabs();
	
                $('#module_header-add').before('<a href="#tab-module_header-' + module_header_row + '" id="module_footer-' + module_header_row + '"><?php echo $tab_block; ?> ' + module_header_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module_footer-' + module_header_row + '\').remove(); $(\'#tab-module_footer-' + module_header_row + '\').remove(); return false;" /></a>');

                $('#blockheadertab a').tabs();
	
                $('#module_header-' + module_header_row).trigger('click');
	
                module_header_row++;
            }
            //--></script>

<script type="text/javascript"><!--
    $('#blockheadertab .vtabs a').tabs();
    //--></script>

<script type="text/javascript"><!--
<?php $module_header_row = 1; ?>
<?php foreach ($modules_header as $module_header) { ?>
        $('#language_header-<?php echo $module_header_row; ?> a').tabs();
    <?php $module_header_row++; ?>
<?php } ?> 
    //--></script> 
<!---------------------------------- END HEADER ----------------------------------------->

<script type="text/javascript"><!--
    <!-- TABS -->
    $('#mainTabs a').tabs();
    $('#tabs1 a').tabs();
    $('#tabs2 a').tabs();
    $('#blockcontenttab a').tabs();
    $('#blockfootertab a').tabs();
    $('#blockheadertab a').tabs();
    $('#languages_header_top a').tabs(); 
    $('#languages_header_bottom a').tabs(); 
    $('#languages_footer_1 a').tabs(); 
    $('#languages_footer_2 a').tabs(); 
    $('#languages_footer_3 a').tabs(); 
    //--></script>
<?php echo $footer; ?>