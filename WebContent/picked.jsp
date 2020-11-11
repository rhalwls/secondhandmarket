<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
String my_id = request.getParameter("my_id");
%>
<link href="style1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jslib.js"></script>
</head>
<body>
<div id = "bigwindow">

</div>


<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
	<script>
	  // Initialize Firebase
	  var config = {
	    apiKey: "AIzaSyBHRpr9Cd0gFYUWT2gkm6uUVydnlRQA4Bo",
	    authDomain: "a-7d887.firebaseapp.com",
	    databaseURL: "https://a-7d887.firebaseio.com",
	    projectId: "a-7d887",
	    storageBucket: "a-7d887.appspot.com",
	    messagingSenderId: "228418263622"
	  };
	  firebase.initializeApp(config);
	</script>
	<script>
	var my_id= "<%=my_id%>";
	var my_pick = firebase.database().ref("user_profile/"+my_id+"/picked_products");
	
	function delete_onclick(){
		var product_key = this.mykey;

		var my_pick = firebase.database().ref("user_profile/"+my_id+"/picked_products/"+product_key);
		console.log(product_key+"will be deleted");
		my_pick.remove();
		
		
		var tobedeleted = document.getElementById(product_key);
		
		tobedeleted.remove();
	}

	my_pick.once('value',function(snapshot){
		console.log("outer loop");
		
		
		 snapshot.forEach(function(childSnapshot) {
			 //console.log(childSnapshot.key);
			 var product_key = childSnapshot.key;
			 //여기서부터 products본다
			var products= firebase.database().ref("product");
			
			console.log("inner loop1");
			
		      products.once('value', function(snapshot) {
		    	  console.log("inner loop2");
		    	  
		          snapshot.forEach(function(childSnapshot) {
		        	  console.log("inner loop3");
		        	  childSnapshot.forEach(function(ChildSnapshot){
		        		  console.log("product key"+product_key);
		        		  console.log("database key"+ChildSnapshot.key);
		        		  console.log("database ref"+ChildSnapshot.ref);
		        		  
		        		  if(product_key== ChildSnapshot.key){
		        		  console.log(ChildSnapshot.key);
		        		  var tmp = ChildSnapshot.val();
		        		  console.log(tmp.product_name);
		        		  
		        		  
		        		  
		        		  var bigwindow= document.getElementById("bigwindow");
		                  
		                  
		                  var product_name = tmp.product_name;
		                  var product_instruction= tmp.product_instruction;
		                  var product_date = tmp.product_date;
		                  var product_onsale = tmp.product_onsale;
		                  var product_price = tmp.product_price;
		                  var product_seller = ChildSnapshot.ref.parent.key;
		                  var product_ref = ChildSnapshot.ref;
		                  var smallwindow = productWindow(product_name,product_instruction,product_date,product_onsale,product_price,
		                   		  product_seller,product_ref,my_id);
		                  smallwindow.setAttribute("id",product_key);
		                     bigwindow.appendChild(smallwindow);
		                  
		                  
		                  var delete_button = document.createElement("button");
		                  delete_button.innerHTML = "삭제하기";
		                 
		                  console.log("snapshot의 부모 "+ ChildSnapshot.ref.parent.key);
		                  //console.log("제품 키"+childSnapshot.ref.key);
		                  delete_button.mykey = ChildSnapshot.key;
		                  delete_button.onclick = delete_onclick;
		                  
		                  smallwindow.innerHTML+="<br>";
		                  smallwindow.appendChild(delete_button);
		        	}
		          });
		        });
		
		 });
	});
	});
	
	</script>


</body>
</html>