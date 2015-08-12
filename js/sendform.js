/* global $,document,console,Parse */
$(document).ready(function() {

	Parse.initialize("5xLComLHX1pDr9ziaEnsaGLaxAkrHXT1DoOeIr1r", "ZXTQfqtjb33uZOlReHWoEXHwevsosi0djUL3gh0D");
	var CommentObject = Parse.Object.extend("CommentObject");

	$("#contactForm").on("submit", function(e) {
		e.preventDefault();

		console.log("Handling the submit");
		//add error handling here
		//gather the form data

		var name = $("#name").val();
		var email = $("#email").val();

		if (name != "" && email != "") {
			var data = {};
			data.name = name;
			data.email = email;
			data.phone = $("#phone").val();
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
		} else {
			alert("Please enter your name and email!");
			console.log("Fail");
		}

	});

});
