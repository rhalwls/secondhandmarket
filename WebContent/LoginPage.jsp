<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<link href="style1.css" rel="stylesheet" type="text/css">

<title>Insert title here</title>
<style>
header{
font:italic bold 50px Georgia, serif;
color: yellow;
text-align: center;
margin:100px;
background-image: url('./star.jpeg');
height :200px;
margin:60px;
}

aside{
  float:left;
  width: 300px;
  margin-left: 100px;
  border:solid;
 padding:30px;
}

section{
float:left;
margin-right:100px;

}
</style>



</head>
<body>

<canvas id="myCanvas" width="1300" height="400" onclick= "window.location.reload()"
style="display: table; margin-left: auto; margin-right: auto;margin-bottom:30px;border-width: 10px;
	border-style: dotted"></canvas>

    <script>
        var canvas = document.getElementById('myCanvas');
     
        var context = canvas.getContext('2d');
        
        context.font = 'bold 80pt cursive'
        var x=200,y=250;
        context.fillText('인하인의 중고장터', x, y);

	</script>

	
<aside>
<% String id = (String) session.getAttribute("id"); %>
<p id="login_id"></p><br>

<table>
<tr>
<td>name : </td><td><input id="name"></input></td>
</tr>
<tr>
<td>account : </td><td><input id="account"></input></td>
</tr>
<tr>
<td>phone : </td><td><input id="phone"></input></td>
</tr>
<tr>
<td>shipping : </td><td><input id="shipping"></input></td>
</tr>
<tr>
<td>hobby : </td><td><input id="hobby"></input></td>
</tr>
</table>
<p id="last"></p><br>

비밀번호 변경란<br>
<input type = "text" id = "password">
<input type = "button" onclick = "changeP()" value ="비밀번호 변경">
<hr>
 <input type = "button" onclick= "category(this.value)" value = "전자제품">
 <hr>
 <input type = "button" onclick = "category(this.value)" value = "주방용품">
 <hr>
 <input type = "button"onclick = "category(this.value)" value = "책">
 <hr>
 
 <script>
 function category(val){
	 alert(val);
	 var queryType= "제품명";
	 var keyword=val;
	 if(queryType == "작성자"){
		seeID(keyword);
	}
	else if(queryType=="제품명"){
		seeKey(keyword);
	}
	 
 }
 
 </script>
 
 </aside>
<section style = "margin:10px;">
<article>
<script>
function changeToWriting(){
	var user_id = "<%=id%>";
	console.log(user_id);
	document.getElementById("changableFrame").src= "selling.jsp?user_id="+user_id;
}
</script>


<form action>
  <input list="queryTypes" id="queryType">
  <datalist id="queryTypes">
    <option value="작성자">
    <option value="제품명">
  </datalist>
  <input id= "query" type="text" value="검색">
<input type = "button" onclick="makeSubmit()" value = "검색">
</form>
<button onclick="changeToWriting()">
상품 올리기
</button>
<button onclick= "seeMine()">내가 올린 상품</button>
<button onclick = "seePicked()">내 관심 상품</button>
<script>
var user_id= "<%=id%>";
function seeMine(){
	
	document.getElementById("changableFrame").src= "showproduct.jsp?user_id="+user_id+"&my_id="+user_id;
}
function seeKey(keyword){
	document.getElementById("changableFrame").src= "showproductbykey.jsp?keyword="+keyword+"&my_id="+user_id;
}

function makeSubmit(){
	var queryType= document.getElementById("queryType").value;
	var keyword= document.getElementById("query").value;
	if(queryType == "작성자"){
		seeID(keyword);
	}
	else if(queryType=="제품명"){
		seeKey(keyword);
		
	}
	else{
		alert("올바른 종류를 선택해주세요");
	}
	
}

function seeID(his_id){
	var user_id= "<%=id%>";
	document.getElementById("changableFrame").src= "showproduct.jsp?user_id="+his_id+"&my_id="+user_id;
}
function seePicked(){
	var my_id= "<%=id%>";
	var url = "picked.jsp?my_id="+my_id;
	
	window.open(url, '_blank', 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
}
</script>
</article>

<article>
<iframe id= "changableFrame" width="700px" height= "500px" style= "border: 2px solid; border-radius: 25px;padding:20px;margin:10px;">

</iframe>
</article>
</section>


<script src="https://www.gstatic.com/firebasejs/5.6.0/firebase.js"></script>
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
  var id = "<%=id %>";

  document.getElementById("login_id").innerHTML = "ID: " + id+"님 환영합니다!";

var user_data = firebase.database().ref('user_data/');

user_data.once('value', function(snapshot) {
    snapshot.forEach(function(childSnapshot) {
      var tmp = childSnapshot.val();
      if(tmp.user_id==id)
        document.getElementById("last").innerHTML = "last login : "+tmp.last_login;
    });
  });

var user_ref2 = firebase.database().ref('user_profile/'+id);
var hobby;
console.log('a');
user_ref2.once('value', function(snapshot) {
	console.log('b');
		    var tmp = snapshot.val();
			    document.getElementById("name").value = tmp.user_name;
  			    document.getElementById("account").value = tmp.user_account;
  			    document.getElementById("phone").value =tmp.user_phone;
  			    document.getElementById("shipping").value = tmp.user_shipping;
  			    document.getElementById("hobby").value = tmp.user_hobby;
  			    
  			    hobby= tmp.user_hobby; 
  			    
  			  seeKey(hobby);
  			  ``//여기다 물건 서치해 interested에 넣기
		  });
console.log('c');

var user_profile = firebase.database().ref('user_profile/');


function btnonclick(){
	alert("sending message");
	var user_ref = firebase.database().ref('user_profile/'+this.user_id);
	
	user_ref.once('value', function(snapshot) {
	    var tmp = snapshot.val();
		    name = tmp.user_name;
			    sex = tmp.user_sex;
			    major =tmp.user_major;
			    grade = tmp.user_grade;
			    hobby = tmp.user_hobby;
	  });
	var message = document.getElementById("message").value;
	user_ref.set({
    	user_name: name,
        user_sex: sex,
        user_major: major,
        user_grade: grade,
        user_hobby: hobby,
        user_message: message
     });
	 
  }
 function changeP(){
	
	 var user_ref = firebase.database().ref('user_data/'+id);
	 var pw = document.getElementById("password").value;
   	 alert("myProfile");
   	user_ref.set({
         user_id: id,
         user_pw: pw,
         last_login: getTimeStamp()
       });
 }


 function getTimeStamp() {
     var d = new Date();
     var s =
     leadingZeros(d.getFullYear(), 4) + '-' +
     leadingZeros(d.getMonth() + 1, 2) + '-' +
     leadingZeros(d.getDate(), 2) + ' ' +

     leadingZeros(d.getHours(), 2) + ':' +
     leadingZeros(d.getMinutes(), 2) + ':' +
     leadingZeros(d.getSeconds(), 2);

     return s;
   }

 function leadingZeros(n, digits) {
     var zero = '';
     n = n.toString();

     if (n.length < digits) {
       for (i = 0; i < digits - n.length; i++)
         zero += '0';
     }
     return zero + n;
   }
 
  </script> 
  <script>
  
  </script>
</body>
</html>