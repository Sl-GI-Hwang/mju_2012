<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>위치 정보</title>
<script type="text/javascript">
 
 window.onload=function(){
  //위치정보를 확인할 수 있는 브라우저인지 확인
  if(navigator.geolocation == undefined){
   alert("위치 정보 기능을 지원하지 않습니다!")
   return;
  }
 }
 //현재 위치 정보 알아보는 메소드
 function showData(){
  //현재 위치 정보를 조사하고 성공 실패 했을시 호출되는 함수 설정
  navigator.geolocation.getCurrentPosition( success, fail );
 }
 //성공시
 function success(position){
  log("위치정보 확인 성공!");
  //반복문 돌면서 출력
  for(var property in position.coords){
   log("Key 값:"+property+" 정보:"+position.coords[property]);
  }
  var lat=position.coords["latitude"];
  var lon=position.coords["longitude"];
 //var uri="http://maps.google.co.kr/?q="+lat+","+lon;
  var url="http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lon+"&sensor=false";
 // http://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&sensor=true_or_false
 //http://maps.google.com/maps/api/geocode/xml?latlng=37.5,127.961452&sensor=false
  //페이지 이동하기
  location.href = url;

 }
 //실패시
 function fail(err){
  
 }
 
 function log(msg){
  var console = document.getElementById("console");
  console.innerHTML += msg+"<br/>";
 }
 
</script>
</head>
<body>
 <button onclick="showData()">현재 위치 확인</button>
 <!-- 테스트 로그를 출력하기 위해 -->
<div id="console" style="width:500px; border:5px; font-size:20px"></div>
</body>
</html>