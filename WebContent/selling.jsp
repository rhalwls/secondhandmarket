<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<%
String user_id= request.getParameter("user_id");
%>
<link href="style1.css" rel="stylesheet" type="text/css">
<style>
input[type = "text"]{
width:300px;
}
</style>
</head>
<body>
<form>
	제품 카테고리 :
	<select id = "category">
    <option value="">카테고리선택</option>
    <option value="전자제품">전자제품</option>
    <option value="주방용품">주방용품</option>
    <option value="책">책</option>
</select>
<br>
        제품명 : <input type = "text" id = "productName" style= "width:300px">
        <br>
        <p id="status" class="success"></p>
        사진 등록 : <p><input type="file" id = "productIMG"></p>
        <br>
        <div id="holder"></div>
        <br>
       상품 설명 : <textarea id = "productInstruction" cols="40" rows="8"></textarea>
       <br>
       가격 : <input id = "price" type = "number">
       <br>
       
        <input type= "button" value= "올리기" onclick= "uploadProduct()">
        
      </form>
      

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
function uploadProduct(){
	var user_id ="<%=user_id%>";
	
	var date = new Date().toString();
	var onsale= true;
	var name = document.getElementById("productName").value;
	var img = document.getElementById("productIMG").files[0];
	var instruction = document.getElementById("productInstruction").value;
	var price = document.getElementById("price").value;
	var category = document.getElementById("category").value;
	name ="[ "+ category+" ] "+name;
	var product_ref = firebase.database().ref('product/'+user_id);
  	alert("uploading..");
  	var pushed_product = product_ref.push({
        product_name: name,
        product_img: img,
       	product_instruction: instruction,
       	product_date: date,
       	product_onsale: onsale,
       	product_price: price
      });
  	var pushed_key =pushed_product.key;
  	

 // Create a root reference
 var storageRef = firebase.storage().ref();

 // Create a reference to 'mountains.jpg'
 var mountainsRef = storageRef.child(name+'.jpg');

 // Create a reference to 'images/mountains.jpg'
 var mountainImagesRef = storageRef.child(user_id+"/"+name+'.jpg');

 // While the file names are the same, the references point to different files
 mountainsRef.name === mountainImagesRef.name            // true
 mountainsRef.fullPath === mountainImagesRef.fullPath    // false

 var file = document.getElementById("productIMG").files[0]; // use the Blob or File API
 mountainImagesRef.put(file).then(function(snapshot) {
   alert("사진 등록 완료");
   window.location.reload();
 });

 
}
</script>
      
      <script>
      var upload = document.getElementById("productIMG"),
          holder = document.getElementById('holder'),
          state = document.getElementById('status');
      
      if (typeof window.FileReader === 'undefined') {
        state.className = 'fail';
      } else {
        state.className = 'success';
       
      }
       
      upload.onchange = function (e) {
        e.preventDefault();
      
        var file = upload.files[0],
            reader = new FileReader();
        reader.onload = function (event) {
          var img = new Image();
          img.src = event.target.result;
          // note: no onload required since we've got the dataurl...I think! :)
          if (img.width > 560) { // holder width
            img.width = 560;
          }
          holder.innerHTML = '';
          holder.appendChild(img);
        };
        reader.readAsDataURL(file);
      
        return false;
      };
      </script>
</body>
</html>