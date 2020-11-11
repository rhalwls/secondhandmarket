<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div{
width:100;
height:300;

}
</style>
<link href="style1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jslib.js"></script>
</head>
<body>
<%
String keyword= request.getParameter("keyword");
String my_id = request.getParameter("my_id");
%>
<div>
<%=keyword %> 추천상품
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
<div id= "bigwindow">
결과 없음
</div>


<script>

    var keyword= "<%=keyword%>";
    var my_id = "<%=my_id%>"
  
	  var products = firebase.database().ref('product');
	  /*
	products.once('value',function(snapshot){
		snapshot.forEach(fucntion(childSnaps))
		
	})*/
	var counter = 0;
    products.once('value', function(snapshot) {
      snapshot.forEach(function(childSnapshot) {
    	  childSnapshot.forEach(function (ChildSnapshot){
    		  var tmp = ChildSnapshot.val();
        	  
        	  var bigwindow= document.getElementById("bigwindow");
             
              var product_name = tmp.product_name;
              var product_instruction= tmp.product_instruction;
              var product_date = tmp.product_date;
              var product_onsale = tmp.product_onsale;
              var product_price = tmp.product_price;
              var product_seller = ChildSnapshot.ref.parent.key;
              var product_ref = ChildSnapshot.ref;
              
              if(product_name.includes(keyword)){
            	  if(counter==0){
            		  bigwindow.innerHTML= "";
            	  }
         		 var smallwindow = productWindow(product_name,product_instruction,product_date,product_onsale,product_price,
           		  product_seller,product_ref,my_id);
             	bigwindow.appendChild(smallwindow);
            	counter=counter+1;
              }
  
    	  });
           });
      	
      });
   		
 
  
</script>
</body>
</html>