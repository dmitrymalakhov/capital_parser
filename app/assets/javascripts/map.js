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
			var titlebox;
			var paper = Raphael(map).translate(50, 0);
					
			paper.forEach(function(element) {
			
		        element.click(function(e) {
		        	attr = JSON.parse($(e.target).attr('font'));
		        	if (typeof(titlebox) != "undefined") {
		        		titlebox.remove();
		        	}

		        	if (attr.titlebox == null) {
		        		box = element.getBBox();
		        		
		        		$.each(box, function(i,item) {
		        			box[i] = Math.round(item);
		        		});

		        		titlebox = initTitlebox(box.x,box.y,box.width,box.height, element);
		        	} else {
		        		points = attr.titlebox.split(',');

		        		titlebox = initTitlebox(points[0],points[1],points[2],points[3], element);		        		
		        	}

		        	$("#region").val(attr.id);
		      		$("#pavilion").val(attr.pavilion_id);
		      		$("#color").val(attr.color);

		      		$(".titlebox").change(function() {
		      			points = $(this).val().split(',');
		      			titlebox.attr({
		      				x: $("#titlebox_x").val(),
		      				y: $("#titlebox_y").val(),
		      				width: $("#titlebox_width").val(),
		      				height: $("#titlebox_height").val()
		      			});
		      		});
		        });
		    });

		    $("svg").removeAttr("style");
		}
	});

	function initTitlebox(x, y, width, height, element) {
		$("#titlebox_x").val(x);
		$("#titlebox_y").val(y);
		$("#titlebox_width").val(width);
		$("#titlebox_height").val(height);

		titlebox = element.paper.rect(x, y, width, height);

		return titlebox;
	}
})