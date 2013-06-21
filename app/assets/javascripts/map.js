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
			var titlebox;

			paper.forEach(function(element) {
		        element.click(function(e) {
		        	attr = JSON.parse($(e.target).attr('font'));
		        	if (typeof(titlebox) != "undefined") {
		        		titlebox.remove();
		        	}

		        	if (attr.titlebox == null) {
		        		box = element.getBBox();
						titlebox = element.paper.rect(box.x,box.y,box.width,box.height);
						$("#titlebox").val([box.x,box.y,box.width,box.height].join(","));
		        	} else {
		        		$("#titlebox").val(attr.titlebox);
		        		points = attr.titlebox.split(',');
		        		titlebox = element.paper.rect(points[0],points[1],points[2],points[3]);
		        	}

		        	$("#region").val(attr.id);
		      		$("#pavilion").val(attr.pavilion_id);
		      		$("#color").val(attr.color);

		      		$("#titlebox").change(function() {
		      			points = $(this).val().split(',');
		      			titlebox.attr({
		      				x: points[0],
		      				y: points[1],
		      				width: points[2],
		      				height: points[3]
		      			})
		      		});
		        });
		    });

		    $("svg").removeAttr("style");
		}
	});


})