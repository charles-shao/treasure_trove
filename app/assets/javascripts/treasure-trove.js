$(document).ready(function(){

	$(".entity-link").on('click', function(){
		if ($(this).attr("loaded") == "false"){
			var target = $(this).attr("data-target");
			var value = $(this).attr('entity_name');
			
			$.ajax({
				url: '/details/get_dbp',
				type: 'get',
				async: false,
				dataType: 'text',
				data: {value: value},
				success: function(data) {
					$(target + " > .well").append(data);
					console.log(data);
				},
				error: function(request, error){
					console.log("Something went wrong");
					alert(request + ":" + error);
				}
			});

			$(this).attr("loaded", "true");
		}
		

		//
	});

});
