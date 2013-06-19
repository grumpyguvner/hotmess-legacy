<?php 
foreach ($categories as $category) {
    if ($category['children']) {

        foreach ($category['children'] as $child) {
          if ($child['category_id'] == $category_id) {
              $child_id = $category_id;
              $category_id = $category['category_id'];
          }
          }
    }
}

foreach ($categories as $category) { ?>
    <?php if ($category['category_id'] == $category_id) { ?>
    <div class="box">
      <div class="box-heading"><?php echo $category['name']; ?></div>
      <div class="box-content">
        <?php if ($category['children']) { ?>
        <ul class="box-category">
          <?php foreach ($category['children'] as $child) { ?>
          <li>
            <?php if ($child['category_id'] == $child_id) { ?>
            <a href="<?php echo $child['href']; ?>" class="active"><?php echo $child['name']; ?></a>
            <?php } else { ?>
            <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
            <?php } ?>
          </li>
          <?php } ?>
        </ul>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
<?php } ?>
