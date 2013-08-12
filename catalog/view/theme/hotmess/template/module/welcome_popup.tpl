<?php echo $content; ?>
<script>
   
   $(window).resize(function() {
    $('#welcomeSplash .middleElement').css('height', ($(window).height()-160) + 'px');
  }).trigger('resize');
   $('#welcomeSplash').show(); 
</script>
