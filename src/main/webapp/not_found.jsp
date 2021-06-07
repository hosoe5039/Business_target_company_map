<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%
	String Current_location = (String) request.getAttribute("Current_location");
%>

<!DOCTYPE html">
<html>
<head>
<style>
#maps {
	height: 500px;
}
</style>
</head>
<body>
  <div id="maps"></div>
  <script src="//maps.googleapis.com/maps/api/js?key=AIzaSyCbfxc6tVLzjs8YmrdB59CMT5Iy3ZEXm0E&callback=initMap" async></script>
  <script>
			var maps;

			function initMap() {
				// 地図の作成
				map = new google.maps.Map(document.getElementById('maps'), { // #sampleに地図を埋め込む
					center : new google.maps.LatLng(
		<%=Current_location%>
			), // 地図の中心を指定
					zoom : 20
				// 地図のズームを指定
				});
			}
		</script>
</body>
<footer>
  <h1>周辺を検索しましたが該当ありません</h1>
</footer>
</html>

