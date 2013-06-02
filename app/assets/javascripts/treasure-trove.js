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

	$(document).on("click", ".show-button", function(){
		var entity = $(this).attr('id');

		for (var i=2;i<6;i++){ 
			$('#'+entity+"-"+i).removeClass('hidden');
		}

		$('#less-'+entity).removeClass('hidden');
		$(this).hide();

    });

    $(document).on("click", ".show-less-button", function(){
		var entity = $(this).attr('infotype');

		for (var i=2;i<6;i++){ 
			$('#'+entity+"-"+i).addClass('hidden');
		}

		$(this).addClass('hidden');
		$('#'+entity).show();

    });

});
