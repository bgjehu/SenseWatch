/* global $,document,console,Parse */
$(document).ready(function() {

	Parse.initialize("5xLComLHX1pDr9ziaEnsaGLaxAkrHXT1DoOeIr1r", "ZXTQfqtjb33uZOlReHWoEXHwevsosi0djUL3gh0D");
	var CommentObject = Parse.Object.extend("CommentObject");

	$("#commentForm").on("submit", function(e) {
		e.preventDefault();

		console.log("Handling the submit");
		//add error handling here
		//gather the form data

		var data = {};
		data.name = $("#name").val();
		data.email = $("#email").val();
		data.area = $("#phone").val();
		data.comments = $("#message").val();

		var comment = new CommentObject();
		comment.save(data, {
			success:function() {
				console.log("Success");
				//Alerts are lame - but quick and easy
				alert("Thanks for filling the form!");
			},
			error:function(e) {
				console.dir(e);
			}
		});

	});

});
