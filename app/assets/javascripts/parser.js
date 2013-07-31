$(document).ready(function() {
	$(".parsing").click(function() {

		var store = $(this).attr("name");
		var pavilion = $("#pavilion_"+store).is(":checked");
		var news = $("#news_"+store).is(":checked");
		var cinema = $("#cinema_"+store).is(":checked");
		
		$.ajax({
			type: 'POST',
			data: {id: store, pavilion: pavilion, news: news, cinema: cinema},
			url: "parser/go",
			success: function (response){
				
			}
		});
	});
	
});