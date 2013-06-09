$(document).ready(function() {
	var store = $(".store").attr("name");
	$.ajax({
		type: 'POST',
		data: {store: store},
		url: "/map/viewer/json/path",
		success: function (response){

			var map = [0,0,600,600];
			$.each(response, function(i,item){
				map.push(item);
			})

			var paper = Raphael(map).translate(200, 200);
		
			paper.forEach(function(element) {
		        element.click(function(e) {
		      		$("#region").val($(e.target).attr('font'));
		   //    		$.ajax({
					// 	type: 'POST',
					// 	data: {path: path},
					// 	url: "/map/viewer/json/pavilion_by_path",
					// 	success: function (response){
					// 		alert(response)
					// 	}
					// });
		        });
		    });
		}
	});


})