$(document).ready(function(){

	$(".entity-link").on('click', function(){
		if ($(this).attr("loaded") == "false"){
			var target = $(this).attr("data-target");
			var value = $(this).attr('entity_name');
			var type = $(this).attr('entity_type');
			$.ajax({
				url: '/details/get_dbp',
				type: 'get',
				async: false,
				dataType: 'text',
				data: {value: value, type: type},
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
