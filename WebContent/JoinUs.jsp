<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style1.css" rel="stylesheet" type="text/css">
</head>
<body>


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
    var user_data = firebase.database().ref('user_data');

    var data = new Array();
    user_data.on('value', function(snapshot) {
      data.splice(0, data.length);
      snapshot.forEach(function(childSnapshot) {
        var childData = childSnapshot.val();
        data.push(childData.user_id);
      });
    });
    
    function signup() {
    	alert("disable?:"+document.getElementById("id").disabled);
      var id = document.getElementById("id").value;
      var pw = document.getElementById("pwd").value;
      var sex= document.getElementById("account").value;
      var name= document.getElementById("name").value;
      var major= document.getElementById("phone").value;
      var grade= document.getElementById("shipping").value;
      var hobby= document.getElementById("hobby").value;
      
      alert(id +" " + pw +" " + name +" " + sex +" " + major +" " + grade +" " + hobby);
      
      var user_data = firebase.database().ref('user_data/'+id);
      
      if(document.getElementById("id").disabled){
    	user_data.set({
          user_id: id,
          user_pw: pw,
          last_login: getTimeStamp()
        });
    	myProfile(id, sex, name, major, grade, hobby);
        alert("sign up successed");
        history.back();
      } else {
        alert("sign up failed");
      }

    }
    
    function myProfile(id, sex, name, major, grade, hobby){
    	var user_ref = firebase.database().ref('user_profile/'+id);
      	alert("myProfile");
      	user_ref.set({
            user_name: name,
            user_account: sex,
            user_phone: major,
            user_shipping: grade,
            user_hobby: hobby
          });
    }

    function mycheck(){
        var id = document.getElementById("id").value;
        var checked = 0;

        data.forEach(function(tmp) {
          if(tmp==id){
            alert("id able to use");
            checked = 1;
          }
        });
        if(checked==0){
          alert("duplicate check");
          document.getElementById("id").disabled = true;
        }
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


<form name="form1" method="GET">   
	<table>
	<tr>
  <td>id:</td><td><input type="text" id = "id" name="username"></td>
 <td><input type="button" onclick="mycheck()" id="check" value="중복확인"></td>
  <td>비밀번호 :</td><td><input type="text" id="pwd" name="pwd"></td>
  </tr>
  <tr>
  <Td>이름 :</Td><td><input type="text" id="name"></td>
  </tr>
  <tr>
  <td>계좌번호 :</td><td><input type="text" id="account"></td>
  </tr>
  <tr>
 <td>전화번호:</td><td><input type="text" id="phone"></td>
 </tr>
 <tr>
 <td>배송지역 :</td><td><input type="text" id="shipping"></td>
 </tr>
 <tr>
  <td>관심분야 : </td><Td><input type="text" id="hobby"></Td>
  </tr>
</table>
 <input type="submit" onclick="signup()" value="가입">
</form>
* 아이디 비밀번호 외의 정보는 거래시 상대방에게 편하게 거래정보를 주고받기 위함으로 수집되며,
나중에 거래하실 상대에게 보여줄지 말지 선택할 수 있습니다. *
</body>
</html>