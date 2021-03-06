<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<style>
		
			#logo{
				width: 1080px;
				text-align: center;
				font-size: large;
				display: inline-block;
				margin: 0 auto;
				margin-bottom: 20px;
			}
			
			.userMsg{
				width: 1080px;
				text-align: right;
			}
			#logoImg{
				width: 300px;
				height: 100px; 
			}
			.layer{
				width: auto;
				text-align: center;
			}
	
			.page {
				height: auto;
				width: 1080px;
				/* border: 1px solid; */
				display: inline-block;
				margin: 0 auto;
			} 
			.col2{
				width:20%;
				padding-top: 30px;
				border: 1px solid blue;
			}
			.col5{
				width: 60%;
				text-align: center;
				padding-left: 1%;
				padding-right: 1%;
				border: 1px solid red;
			}
			.col3{
				width: 20%;
				border: 1px solid ;
			}
		    
				
			.content {
				height: auto;
				/* border: 1px solid; */
	            float: left;
	    	}
			
		/**게시판 스타일**/
			.totalTable{
				width: 700px;
				text-align: center;
				border-bottom: 1px solid silver;
			}
			
		/**검색 스타일(글작성 없음)**/	
			#searchManager{
				width: 970px;
				text-align: right;
			}
		
		/**검색 스타일(글작성 있음)**/	
			#searchList{
				position: absolute;
				left: 270px; 
				width: 700px;
			}
			
		/**border 한방향 스타일**/
			.borderLeft{
				border-left: 1px solid;
			}
			.borderRight{
				border-right: 1px solid;
			}
			.borderBottom{
				border-bottom: 1px solid;
			}
			.borderTop{
				border-top: 1px solid;
			}	
			
		/**텍스트 위치 스타일**/
		.right{
			text-align: right;
		}
		.left{
			text-align: left;
		}
		.center{
			text-align: center;
		}	
		</style>
	</head>
	<body>
		<div class="layer">
			<div id="logo" >
				 <a href="../../main/index"><img id="logoImg" src="../../main/resources/include/img/logo.jpg" /></a>
			</div>
		</div>
	</body>
	<script>
	var nowNoteCnt=0;
	var logoTeam={};
	var logoIdx="${sessionScope.userIdx}";
	var logoUser="${sessionScope.userId}";
	
	$("document").ready(function(){
		logoSelect(logoIdx);
		start2(); 
	});
	
	
	function logoSelect(u_idx){
		console.log("logoSelect");
		var url="../../main/selectTeam";
		var data={};
		data.idx=u_idx;
		InterServer(url, data); 
	}
	
		 function start2(){
			console.log("start2");
			var startUrl="../../main/match/playing";
			var startData={};
			InterServer(startUrl, startData);
			setInterval(function(){
				var url="../../main/match/playing";
				var data={};
				console.log("시간");
				InterServer(url, data);
			}, 60000);	
		} 
		
		function InterServer(url, data){
			$.ajax({
				url:url,
				type:"post",
				data:data,
				dataType:"JSON",
				success:function(data){
					console.log(data);
					if(url=="../../main/match/playing"){
						console.log("현재 진행중 jsp");
						printPlaying(data.mchList);
					}else if(url=="../../main/note/countNote"){
						nowNoteCnt=data.count;
						console.log("현재 쪽지"+nowNoteCnt);
						if(nowNoteCnt!=0){
							$("#noteImg").css("display","block");
						}else{
							$("#noteImg").css("display","none");
						}
					}else if(url=="../../main/selectTeam"){
						logoTeam=data.userTeam;
					}
				},
				error:function(error){
					console.log(error);
				}
			});
		}
		
		
	 	function printPlaying(list){
			var i=0;
			if(list.length>0){
				console.log(i);
				if(i>=list.length){
					i=0;
				}
				playingList(list, i);
				i++;	
			}else{
				emptyList();
			}
			if(logoUser!=""){
				console.log(logoUser);
				var startUrl="../../main/note/countNote";
				var startData={};
				startData.idx="";
				for(var j=0; j<logoTeam.length; j++){
					if(j>0){
						startData.idx+=" "+logoTeam[j].t_idx;	
					}else{
						startData.idx+=logoTeam[j].t_idx;	
					}
					
				} 
				console.log("인터벌 전 팀정보"+startData.idx);
				InterServer(startUrl, startData);	
			}
			setInterval(function(){
				console.log(logoUser);
				var url="../../main/note/countNote";
				var data={};
				if(list.length>0){
					console.log(i);
					if(i>=list.length){
						i=0;
					}
					playingList(list, i);
					i++;	
				}else{
					emptyList();
				}
				if(logoUser!=""){
					data.idx="";
					for(var j=0; j<logoTeam.length; j++){
						if(j>0){
							data.idx+=" "+logoTeam[j].t_idx;	
						}else{
							data.idx+=logoTeam[j].t_idx;	
						}
						
					}
					console.log("팀정보"+data.idx);
					InterServer(url, data);	
				}
			}, 10000);
		}
		 
		function playingList(list, num){
			console.log("경기 진행중인 시합"+num);
			var content="";
			content+="<tr>"
			+"<td>"+list[num].mch_ground+"<td>"
			+"</tr><tr>"
			+"<td>"+list[num].mch_name+" VS "+list[num].mch_state+"</td>"
			+"</tr><tr>"
			+"<td>"+list[num].mch_date+" "+list[num].mch_time+"</td>"
			+"</tr>";
			$("#nowGame").empty();
			$("#nowGame").append(content);
		}
		
		function emptyList(){
			var content="";
			content+="<tr>"
			+"<td><b>"+"현재 진행중인 경기가 없습니다."+"</b></td>";
			+"</tr>";
			$("#nowGame").empty();
			$("#nowGame").append(content);
		}
	</script>
</html>