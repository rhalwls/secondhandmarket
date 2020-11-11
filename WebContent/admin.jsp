<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>admin</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<table id="infotable" border=1>
<tr>
<td>ID</td>
<td>이름</td>
<td>학년</td>
<td>전공</td>
<td>성별</td>
<td>관심사</td>
<td>접속시간</td>
<td>관리</td>
<td>허위매물 관리</td>

</tr>
</table>



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
allUserdata();
function del_click(id){
	alert("id:"+ id);
	var user_data = firebase.database().ref('user_data/'+id);
	user_data.remove();
	var user_prof = firebase.database().ref('user_profile/'+id);
	user_prof.remove();
	alert("변경 완료");

}
function del_product_click(){
	<%
	String admin_id= "admin";
	session.setAttribute("admin_id",admin_id);
	%>
	
	var id = this.id;
	console.log("this.id는 "+id);
	var url= "showproduct.jsp?user_id="+id+"&my_id="+"<%=admin_id%>";
	
	window.open(url, '_blank', 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
}
function allUserdata(){
	var user_data = firebase.database().ref('user_data');
	user_data.once('value', function(snapshot) {
	    snapshot.forEach(function(childSnapshot) {
	      var tmp = childSnapshot.val();
	      allUserProfile(tmp.user_id, tmp.last_login);
	    });
	  });
}
function allUserProfile(id, time){
	table = document.getElementById("infotable");
	var user_data = firebase.database().ref('user_profile/'+id);
	user_data.once('value', function(snapshot) {
	      var tmp = snapshot.val();
	      
	      new_tr = document.createElement("tr");
	      
	      td_id = document.createElement("td");
	      td_id.innerHTML = id;
	      new_tr.appendChild(td_id);
	      
	      td_name = document.createElement("td");
	      td_name.innerHTML = tmp.user_name;
	      new_tr.appendChild(td_name);
	      
	      td_account = document.createElement("td");
	      td_account.innerHTML = tmp.user_account;
	      new_tr.appendChild(td_account);

	      td_phone = document.createElement("td");
	      td_phone.innerHTML = tmp.user_phone;
	      new_tr.appendChild(td_phone);

	      td_shipping = document.createElement("td");
	      td_shipping.innerHTML = tmp.user_shipping;
	      new_tr.appendChild(td_shipping);
	      
	      td_h = document.createElement("td");
	      td_h.innerHTML = tmp.user_hobby;
	      new_tr.appendChild(td_h);
	      
	      td_time = document.createElement("td");
	      td_time.innerHTML = time;
	      new_tr.appendChild(td_time);
	     
	      td_del_btn= document.createElement("td");
	      del_btn = document.createElement("input");
	      del_btn.setAttribute("type", "button");
	      del_btn.setAttribute("onclick", "del_click("+id+")");
	      del_btn.setAttribute("value", "삭제");
	      td_del_btn.appendChild(del_btn);
	      new_tr.appendChild(td_del_btn);
	      
	      td_del_product=document.createElement("td");
	      del_product_of_id= document.createElement("input");
	      del_product_of_id.setAttribute("type","button");
	     del_product_of_id.id=id;
	     del_product_of_id.onclick= del_product_click;
	      del_product_of_id.setAttribute("value",id+"의 허위매물 관리");
	      td_del_product.appendChild(del_product_of_id);
	      new_tr.appendChild(td_del_product);
	      
	      table.appendChild(new_tr);
	  });
}
</script>
</body>
</html>