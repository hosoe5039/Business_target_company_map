<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%
	String marker_info = (String) request.getAttribute("marker_info");
	String Current_location = (String) request.getAttribute("Current_location");
%>
<!DOCTYPE html">
<html>
<head>
<style>
#maps {
	height: 1000px;
}
</style>
</head>
<body>
  <div id="maps"></div>
  <script src="//maps.googleapis.com/maps/api/js?key=AIzaSyCbfxc6tVLzjs8YmrdB59CMT5Iy3ZEXm0E&callback=initMap" async></script>
  <script>
			var map;
			var marker = [];
			var infoWindow = [];
			var markerData = [ // マーカーを立てる場所名・緯度・経度
		<%=marker_info%>
			];

			function initMap() {
				// 地図の作成
				map = new google.maps.Map(document.getElementById('maps'), { // #sampleに地図を埋め込む
					center : new google.maps.LatLng(
		<%=Current_location%>
			), // 地図の中心を指定
					zoom : 20
				// 地図のズームを指定
				});

				// マーカー毎の処理
				for (var i = 0; i < markerData.length; i++) {
					markerLatLng = new google.maps.LatLng({
						lat : markerData[i]['lat'],
						lng : markerData[i]['lng']
					}); // 緯度経度のデータ作成
					marker[i] = new google.maps.Marker({ // マーカーの追加
						position : markerLatLng, // マーカーを立てる位置を指定
						map : map
					// マーカーを立てる地図を指定
					});

					infoWindow[i] = new google.maps.InfoWindow({ // 吹き出しの追加
						content : '<div class="map">' + markerData[i]['name']
								+ '</div>' // 吹き出しに表示する内容
					});

					markeClickrEvent(i); // マーカーにクリックイベントを追加
				}
			}

			// マーカーにクリックイベントを追加
			function markeClickrEvent(i) {
				marker[i].addListener('click', function() { // マーカーをクリックしたとき
					infoWindow[i].open(map, marker[i]); // 吹き出しの表示
				});
			}
		</script>
</body>
</html>

