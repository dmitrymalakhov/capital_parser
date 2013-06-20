$(document).ready(function() {
	var store = $(".attr").attr("store");
	var floor = $(".attr").attr("floor");

	$('#color').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	}).bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});

	$.ajax({
		type: 'POST',
		data: {store: store, floor: floor},
		url: "/map/viewer/json/path",
		success: function (response){

			var map = [0,0,1000,1000];
			$.each(response, function(i,item){
				map.push(item);
			})

			var paper = Raphael(map).translate(50, 0);

			paper.forEach(function(element) {
		        element.click(function(e) {
		        	attr = JSON.parse($(e.target).attr('font'));

		        	$("#region").val(attr.id);
		      		$("#pavilion").val(attr.pavilion_id);
		      		$("#color").val(attr.color);
		        });
		    });

		    $("svg").removeAttr("style");
		}
	});


})