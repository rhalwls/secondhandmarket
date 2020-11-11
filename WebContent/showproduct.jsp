<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
div{
width:100;
height:300;
}
</style>
<script type="text/javascript" charset='EUC-KR' src="jslib.js"></script>
<link href="style1.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String user_id= request.getParameter("user_id");
String my_id = request.getParameter("my_id");
String admin_id= (String)session.getAttribute("admin_id");
System.out.println(my_id);

if(admin_id==null||admin_id==""){
	System.out.println("not admin");
}else if(admin_id=="admin"){
	System.out.println("is admin");
	my_id=user_id;
}

%>
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
<div id= "bigwindow">
결과 없음
</div>


<script>

    var user_id= "<%=user_id%>";
   var my_id = "<%=my_id%>";
    console.log(user_id);
	  var user_data = firebase.database().ref('product/'+user_id);
	  

	  
	var counter=0;
    user_data.once('value', function(snapshot) {
      snapshot.forEach(function(childSnapshot) {
    	  var tmp = childSnapshot.val();
    	  
    
          var product_name = tmp.product_name;
          var product_instruction= tmp.product_instruction;
          var product_date = tmp.product_date;
          var product_onsale = tmp.product_onsale;
          var product_price = tmp.product_price;
          var product_seller =childSnapshot.ref.parent.key;
          var product_ref = childSnapshot.ref;
          
          var bigwindow= document.getElementById("bigwindow");
	  if(counter==0){
    		  bigwindow.innerHTML="";
    	  }
          //create a small window and attach to the big window
          
	 	 var smallwindow = productWindow(product_name,product_instruction,product_date,product_onsale,product_price,
    		  product_seller,product_ref,my_id);
      bigwindow.appendChild(smallwindow);
      counter =counter+1;
      
      });
    });
  </script>
</body>
</html>