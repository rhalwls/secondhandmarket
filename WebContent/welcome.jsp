	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style1.css" rel="stylesheet" type="text/css">
	</head>
	<body>
	
	
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
	  function gosignup() {
	      location.href="JoinUs.jsp";
	    }
	  
	  function mylogin() {
	      var id = document.getElementById("id").value;
	      var pw = document.getElementById("pwd").value;
		  var user_data = firebase.database().ref('user_data');
	      user_data.once('value', function(snapshot) {
	        snapshot.forEach(function(childSnapshot) {
	          var tmp = childSnapshot.val();
	          if(tmp.user_id==id){
	            if(tmp.user_pw==pw){
	              alert("로그인 성공!");
	              updateLoginTime(id, pw);
	              location.href="Profile.html?user_id="+id;
	            } else {
	              alert("잘못된 비밀번호입니다");
	            }
	          }
	        });
	      });
	    }
	  
	  function updateLoginTime(id, pw){
	      var user_ref = firebase.database().ref("user_data/"+id);
	      user_ref.set({
	        user_id: id,
	        user_pw: pw,
	        last_login : getTimeStamp()
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
	  
	  function myjsplogin() {
	      var id = document.getElementById("id").value;
	      var pw = document.getElementById("pwd").value;
		  var user_data = firebase.database().ref('user_data');
	      user_data.once('value', function(snapshot) {
	        snapshot.forEach(function(childSnapshot) {
	          var tmp = childSnapshot.val();
	          if(tmp.user_id==id){
	            if(tmp.user_pw==pw){
	              alert("로그인 성공!");
	              updateLoginTime(id, pw);
	              var form = document.getElementById("form1");
	              form.setAttribute("action", "./LoginServlet?id="+id+"&&pwd="+pw+"");
	              form.submit();
	            } else {
	              alert("잘못된 비밀번호입니다");
	            }
	          }
	        });
	      });
	    }
	  
	  function myjsplogin2() {
	      var id = document.getElementById("id").value;
	      var pw = document.getElementById("pwd").value;
		  var user_data = firebase.database().ref('user_data');
		  var con = false;
	      user_data.once('value', function(snapshot) {
	        snapshot.forEach(function(childSnapshot) {
	          var tmp = childSnapshot.val();
	          alert("tmp.user_id"+tmp.user_id);
	          alert("tmp.user_pw"+tmp.user_pw);
	          if(tmp.user_id==id){
	            if(tmp.user_pw==pw){
	              updateLoginTime(id, pw);
	              con=true;
	            }
	          }
	        });
	      });
		  alert("con:"+con);
	      if(con==true){
	          alert("로그인 성공!");
	    	  var form = document.getElementById("form1");
	          form.setAttribute("action", "./LoginServlet");
	          alert(id + " " + pw);
	          form.submit();
	      }
	      else alert("잘못된 비밀번호입니다");
	    }
	  </script>
	<form id="form1" method="POST">
	<table>
	<tr>
	<td>ID: </td><td><input type="text" id="id"></td>
	 </tr>
	 <tr>
	  <td>비밀번호: </td><td><input type="text" id="pwd">   </td>
	  </tr>
	  <tr>
	  <td><input type="button" onclick="myjsplogin()" value="로그인"></td><td><input type="button" onclick="gosignup()" value="회원가입"></td>
	  </tr>
	 </table>
	 
	 
	</form>  
	  
	<br>
	</body>
	</html>