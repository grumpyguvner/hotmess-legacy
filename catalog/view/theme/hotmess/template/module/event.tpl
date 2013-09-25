<div class="box">
    <div class="box-heading"><?php echo strtoupper($heading_title); ?></div>
  <div class="box-content">
    <div id="module_ec"><?php echo $event_cal;?></div>  
  </div>
  <div class="social">
      <div class="addthis_toolbox addthis_default_style ">
        <a class="addthis_button_tweet" tw:count="none"></a>
        <a class="addthis_button_pinterest_pinit"></a>
        <a class="addthis_button_facebook_like" style="width:47px;overflow:hidden"></a><br /><br />
        <a class="addthis_button_google_plusone" g:plusone:size="medium" g:plusone:count="false"></a>
        <a class="addthis_button_facebook_send"></a>
      </div>
  </div>
</div>
<script type="text/javascript">
function do_cal(yr, mt) {
	var myData = 'x='+mt+'&y='+yr;
	$.ajax({
		type: 'get',
		url: 'index.php?route=module/event/callback',
		dataType: 'html',
		data: myData,
		success: function (html) {
		$('#module_ec').html(html);
	}
	,
	complete: function () {
		
	}
	});
} 
</script>
<script type="text/javascript" async="true" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-51c425d953829875"></script>