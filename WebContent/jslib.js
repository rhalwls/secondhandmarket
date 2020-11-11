/**
 * 
 */

          function productWindow(product_name,product_instruction,product_date,product_onsale,product_price,
        		  product_seller,product_ref,my_id){//my_id에 조심하기
        	  var smallwindow= document.createElement("div");
              var product_img = document.createElement("img");
              product_img.style = "width:200px;height:200px;"
              var pick_button = document.createElement("button");
              pick_button.innerHTML = "관심상품";
              pick_button.mykey = product_ref.key;
              
              pick_button.addEventListener("click",pick_onclick,true);
              
              var chat_button = document.createElement("button");
              chat_button.innerHTML = "제품문의";
              chat_button.product_ref= product_ref;
              chat_button.onclick = goToConversation;
              console.log("product_onsale : "+product_onsale)
              
              smallwindow.innerHTML = "판매자 : "+product_seller+"<br>"+"상품명 : "+ product_name+"<br>"+"정보 : "+product_instruction+"<br>"
              +"올린 날짜 : "+product_date+"<br>"+(product_onsale?"판매중입니다":"판매 완료")+"<br>"+"가격 :"+product_price+"<br>";
              
              
              var storageRef = firebase.storage().ref();
              
              storageRef.child(product_seller+"/"+product_name+'.jpg').getDownloadURL().then(function(url) {
              	  // `url` is the download URL for 'images/stars.jpg'

              	  // This can be downloaded directly:
              	  var xhr = new XMLHttpRequest();
              	  xhr.responseType = 'blob';
              	  xhr.onload = function(event) {
              	    var blob = xhr.response;
              	  };
              	  xhr.open('GET', url);
              	  xhr.send();

              	  // Or inserted into an <img> element:
              	  product_img.src= url;
              	  smallwindow.appendChild(product_img);
              	  
                
                  if(product_seller ==my_id){
                	  var new_form = document.createElement("form");
                	  new_form.innerHTML +="내가 파는 상품으로, 판매중 상태 수정과  매물 내리기가 가능합니다.<br>판매중 상태";
                	  var newCheckBox = document.createElement('input');
                	    newCheckBox.type = 'checkbox';
                	    /**
                	     * 
                	     */

                	              function productWindow(product_name,product_instruction,product_date,product_onsale,product_price,
                	            		  product_seller,product_ref,my_id){//my_id에 조심하기
                	            	  var smallwindow= document.createElement("div");
                	                  var product_img = document.createElement("img");
                	                  product_img.style = "width:200px;height:200px;"
                	                  var pick_button = document.createElement("button");
                	                  pick_button.innerHTML = "관심상품";
                	                  pick_button.mykey = product_ref.key;
                	                  
                	                  pick_button.addEventListener("click",pick_onclick,true);
                	                  
                	                  var chat_button = document.createElement("button");
                	                  chat_button.innerHTML = "제품문의";
                	                  chat_button.product_ref= product_ref;
                	                  chat_button.onclick = goToConversation;
                	                  console.log("product_onsale : "+product_onsale)
                	                  
                	                  smallwindow.innerHTML = "판매자 : "+product_seller+"<br>"+"상품명 : "+ product_name+"<br>"+"정보 : "+product_instruction+"<br>"
                	                  +"올린 날짜 : "+product_date+"<br>"+(product_onsale?"판매중입니다":"판매 완료")+"<br>"+"가격 :"+product_price+"<br>";
                	                  
                	                  
                	                  var storageRef = firebase.storage().ref();
                	                  
                	                  storageRef.child(product_seller+"/"+product_name+'.jpg').getDownloadURL().then(function(url) {
                	                  	  // `url` is the download URL for 'images/stars.jpg'

                	                  	  // This can be downloaded directly:
                	                  	  var xhr = new XMLHttpRequest();
                	                  	  xhr.responseType = 'blob';
                	                  	  xhr.onload = function(event) {
                	                  	    var blob = xhr.response;
                	                  	  };
                	                  	  xhr.open('GET', url);
                	                  	  xhr.send();

                	                  	  // Or inserted into an <img> element:
                	                  	  product_img.src= url;
                	                  	  smallwindow.appendChild(product_img);
                	                  	  
                	                    
                	                      if(product_seller ==my_id){
                	                    	  var new_form = document.createElement("form");
                	                    	  new_form.innerHTML +="판매중입니까?";
                	                    	  var newCheckBox = document.createElement('input');
                	                    	    newCheckBox.type = 'checkbox';
                	                    	  newCheckBox.checked = product_onsale;
                	                    	  newCheckBox.product_ref = product_ref;
                	                    	  newCheckBox.onchange = function(){
                	                    		  var product_ref = this.product_ref;
                	                    		  
                	                    		  var currentchecked = this.checked;
                	                    		  firebase.database().ref(product_ref).update({ onsale: currentchecked });
                	                    		  alert("판매상태 변경완료");
                	                    	  }
                	                    	  var new_button =document.createElement("button");
                	                    	  new_button.innerHTML = "삭제하기";
                	                    	  new_button.product_ref = product_ref;
                	                    	  
                	                    	  new_button.parentDiv = smallwindow;
                	                    	  //console.log("new_button produet_ref : "+childSnapshot.ref);
                	                    	 
                	                    	  new_button.onclick=function(){
                	                    		  
                	                    		 console.log(this.produce_ref);
                	                    		var product_data = firebase.database().ref(this.product_ref);
                	                    		var product_key = this.product_ref.key;

                	                    		product_data.remove();//판매자 매대에서 지움
                	                    		
                	                    		var user_profile = firebase.database().ref("user_profile");
                	                    		user_profile.once('value', function(snapshot) {
                	                    			snapshot.forEach(function(childSnapshot) {
                	                    				var tobedeleted = childSnapshot.child("picked_products/"+product_key).ref;
                	                        			console.log(childSnapshot.child("picked_products/"+product_key).ref.toString());
                	                        			
                	                        			tobedeleted.remove();
                	                    			      }
                	                    			    );
                	                    		
                	                    			
                	                    		  });


                	                    		
                	                    		 var storageRef = firebase.storage().ref();

                	                    	  	    storageRef.child(product_seller+"/"+product_name+'.jpg').delete().then(function(){
                	                    	  	    	console.log("picture deleted!");
                	                    	  	    });
                	                    	  	   this.parentDiv.remove();
                	                    	  	 alert("삭제완료");
                	                    	  }
                	                    	  
                	                    	  new_form.appendChild(newCheckBox);
                	                    	  new_form.appendChild(new_button);
                	                    	 
                	                    	  smallwindow.appendChild(new_form);
                	                      }
                	                      smallwindow.appendChild(pick_button);
            	                          smallwindow.appendChild(chat_button);
                	              
                	                  });
                	                  return smallwindow;
                	            }
                	              
                	              function goToConversation(){
                	            	  
                	        		  var product_key = this.product_ref.key;
                	        		  var seller_id= this.product_ref.parent.key;
                	        	  var url = "conversation.jsp?my_id="+my_id+"&seller_id="+seller_id+"&product_key="+product_key;
                	        	  console.log(this.product_ref);
                	        	  
                	        	  window.open(url, '_blank', 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
                	        	 
                	          }

                	              function pick_onclick(){
                	          		var product_key = this.mykey;
                	          		var my_pick = firebase.database().ref("user_profile/"+my_id+"/picked_products/"+product_key);
                	          		var current_time = new Date().toString();
                	          		my_pick.set({
                	          			time_picked: current_time	
                	          		});
                	          		alert("관심상품 등록 완료")
                	          	
                	          	}  newCheckBox.checked = product_onsale;
                	  newCheckBox.product_ref = product_ref;
                	  newCheckBox.onchange = function(){
                		  var product_ref = this.product_ref;
                		  
                		  var currentchecked = this.checked;
                		  firebase.database().ref(product_ref).update({ onsale: currentchecked });
                		  alert("판매상태 변경완료");
                	  }
                	  var new_button =document.createElement("button");
                	  new_button.innerHTML = "삭제하기";
                	  new_button.product_ref = product_ref;
                	  
                	  new_button.parentDiv = smallwindow;
                	  //console.log("new_button produet_ref : "+childSnapshot.ref);
                	 
                	  new_button.onclick=function(){
                		  
                		 console.log(this.produce_ref);
                		var product_data = firebase.database().ref(this.product_ref);
                		var product_key = this.product_ref.key;

                		product_data.remove();//판매자 매대에서 지움
                		
                		var user_profile = firebase.database().ref("user_profile");
                		user_profile.once('value', function(snapshot) {
                			snapshot.forEach(function(childSnapshot) {
                				var tobedeleted = childSnapshot.child("picked_products/"+product_key).ref;
                    			console.log(childSnapshot.child("picked_products/"+product_key).ref.toString());
                    			
                    			tobedeleted.remove();
                			      }
                			    );
                		
                			
                		  });


                		
                		 var storageRef = firebase.storage().ref();

                	  	    storageRef.child(product_seller+"/"+product_name+'.jpg').delete().then(function(){
                	  	    	console.log("picture deleted!");
                	  	    });
                	  	   this.parentDiv.remove();
                	  	 alert("삭제완료");
                	  }
                	  
                	  new_form.appendChild(newCheckBox);
                	  new_form.appendChild(new_button);
                	  
                	  smallwindow.appendChild(new_form);
                  }
                  smallwindow.appendChild(pick_button);
                  smallwindow.appendChild(chat_button);
          
              });
              smallwindow.setAttribute("class","productwindow");
              smallwindow.style = " border: 2px solid pink; border-radius: 25px;padding:20px;";
      
              return smallwindow;
        }
          
          function goToConversation(){
        	  
    		  var product_key = this.product_ref.key;
    		  var seller_id= this.product_ref.parent.key;
    	  var url = "conversation.jsp?my_id="+my_id+"&seller_id="+seller_id+"&product_key="+product_key;
    	  console.log(this.product_ref);
    	  
    	  window.open(url, '_blank', 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
    	 
      }

          function pick_onclick(){
      		var product_key = this.mykey;
      		var my_pick = firebase.database().ref("user_profile/"+my_id+"/picked_products/"+product_key);
      		var current_time = new Date().toString();
      		my_pick.set({
      			time_picked: current_time	
      		});
      		alert("관심상품 등록 완료")
      	
      	}