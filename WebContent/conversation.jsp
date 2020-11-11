<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<%
String product_key= request.getParameter("product_key");
String seller_id = request.getParameter("seller_id");
String my_id= request.getParameter("my_id");
%>

<style>
.sent{
background-image: url("./baloonright.jpg");
background-repeat: no-repeat;
background-size:  contain; 
padding:20px;
}
.replies{
background-image: url("./baloonleft.jpg");
background-repeat: no-repeat;
background-size: contain; 
padding:20px;
}


</style>
<link href="style1.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id= "chat">

</div>


<input type = "text" id = "myword">

<button onclick = "onSubmit()">전송</button>


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
var user_array = new Array();

var chat_ref = firebase.database().ref("product/"+"<%=seller_id%>"+"/"+"<%=product_key%>"+"/"+"chat");
var my_id = "<%=my_id%>";
chat_ref.on('child_added', function (data) {
  var type;
  if(data.val().user_id == my_id){
    type="sent";
  }
  else{
    type="replies";
  }
  var big_div = document.getElementById("chat");
  var new_div= document.createElement("div");
  new_div.classList.add(type);
  var id_part = document.createElement("div");
  id_part.style = "font: italic bold 12px/30px Georgia, serif;"
  var word_part = document.createElement("div");
	var time_part  = document.createElement("div");
time_part.syle = "font: 7px";
	
  var dataval = data.val();
  

  user_array.push(dataval.user_id);
  id_part.innerHTML=dataval.user_id;
  word_part.innerHTML =dataval.words;
  time_part.innerHTML = dataval.time_sent;
  
  new_div.appendChild(id_part);
  new_div.appendChild(word_part);
  new_div.appendChild(time_part);
  
  big_div.appendChild(new_div);  
});



function onSubmit(){
	var words = document.getElementById("myword").value;
	var current = new Date().toString('YYYY-MM-dd'); 
	
	
	chat_ref.push({
	    user_id :my_id,
	    words: words,
	    time_sent: current
	  });
}

function showMe(){
	
	//window.open()
}

</script>



</body>
</html>