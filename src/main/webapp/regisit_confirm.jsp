<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page
import= "java.util.HashMap"
import= "java.util.Map"
%>
<%
Map<String,String> place = (HashMap<String,String>)request.getAttribute("place");
String company = place.get("company");
String adress = place.get("adress");
String lat = place.get("lat");
String lng = place.get("lng");
%>
<!DOCTYPE html">
<html>
<head>
<style>
#maps {
	height: 300px;
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
				{lat:<%=lat %>,lng:<%=lng %>}
			];

			function initMap() {
				// 地図の作成
				map = new google.maps.Map(document.getElementById('maps'), { // #sampleに地図を埋め込む
					center : new google.maps.LatLng(
							{lat:<%=lat %>,lng:<%=lng %>}
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
    <h1>この位置で登録をしても良いですか？</h1>

  <form action="./map222lo" Method="post">
      <input type="hidden"  name="company"value="<%=company%>">
      <input type="hidden"  name="adress"value="<%=adress%>">
      <input type="hidden"  name="lat"value="<%=lat%>">
      <input type="hidden"  name="lng"value="<%=lng%>">
      <input type="submit" value="はい">
  </form>

  <form action="./company_registration.jsp">
      <input type="submit" value="いいえ">
  </form>

</body>

</html>

