<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/language.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
            
            <table class="form">
              <tr>
                <td><?php echo $text_filename; ?></td>
                <td><?php echo $filename; ?></td>
              </tr>
            </table>
            
          <div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="language<?php echo $language['language_id']; ?>">
            <input type="hidden" name="language_manager[<?php echo $language['language_id']; ?>][language_id]" value="<?php echo isset($information_description[$language['language_id']]) ? $language_manager[$language['language_id']]['language_id'] : $language['language_id']; ?>" />
            <table class="form">
              <?php
              foreach ($language_manager[$language['language_id']]['default'] as $key => $value) {
              ?>
              <tr>
                  <td><?php echo ucwords(str_replace('_', ' ', $key)); ?></td>
                <?php
                if (array_key_exists($key, $language_manager[$language['language_id']]['value']))
                {
                ?><td><input type="checkbox" value="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" checked="checked" /></td><td><input type="text" name="language_manager[<?php echo $language['language_id']; ?>][value][<?php echo $key; ?>]" size="100" placeholder="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" value="<?php echo $language_manager[$language['language_id']]['value'][$key]; ?>" /></td>
                <?php
                } else {
                ?><td><input type="checkbox" value="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" /></td><td><input type="text" name="language_manager[<?php echo $language['language_id']; ?>][value][<?php echo $key; ?>]" size="100" placeholder="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" value="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" disabled="disabled" /></td>
                <?php
                }
                ?>
              </tr>
              <?php
              }
              ?>
              
            </table>
          </div>
          <?php } ?>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#languages a').tabs(); 


$('#tab-general input[type=text]').parents('td').click(function () {
    if (!$(this).parents('tr').find('input[type=checkbox]').is(':checked')) {
        $(this).parents('tr').find('input[type=checkbox]').trigger('click');
    }
});

$('#tab-general input[type=checkbox]').change(function () {
    if ($(this).is(':checked')) {
        $(this).parents('tr').find('input[type=text]').attr('disabled', false).trigger('focus');
    } else {
        $(this).parents('tr').find('input[type=text]').attr('disabled', 'disabled').val($(this).attr('value'));
    }
});
//--></script> 
<?php echo $footer; ?>