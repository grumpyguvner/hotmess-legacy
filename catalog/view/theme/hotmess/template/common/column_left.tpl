<?php if ($modules) { ?>
<?php
$B_Layout_Settings = explode(',', $this->config->get('b_Layout_Setting'));
$column_left = $B_Layout_Settings[0];
?>
<div id="column-left" class="<?php echo $column_left; ?> alpha">
  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>
</div>
<?php } ?> 