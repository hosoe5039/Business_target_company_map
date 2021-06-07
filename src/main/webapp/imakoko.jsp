<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>getCurrentPosition Sample</title>
</head>
<body>
  <script type="text/javascript">
	// 位置情報取得成功時
	function onSuccess(pos) {
	        var location2 = "<input type='hidden' name='lat' value = '" + pos.coords.latitude + "'>";
	        location2 += "<input type='hidden' name='lng' value = '" + pos.coords.longitude + "'>";
	        console.log(location2);

			var innerHTMLtxt = document.getElementById("innerHTMLtxt")
	        innerHTMLtxt.innerHTML= location2;
	        //document.getElementById("location2").innerHTML = location2;
	}

	// 位置情報取得失敗時
	function onError(error) {
		var message = "";

		switch (error.code) {
		   // 位置情報取得できない場合
		   case error.POSITION_UNAVAILABLE:
		       message = "位置情報の取得ができませんでした。";
		       break;
		  // Geolocation使用許可されない場合
		  case error.PERMISSION_DENIED:// 位置情報取得失敗時
		      message = "位置情報取得の使用許可がされませんでした。";
		      break;
		  // タイムアウトした場合
		  case error.PERMISSION_DENIED_TIMEOUT:
		      message = "位置情報取得中にタイムアウトしました。";
		      break;
		}
		window.alert(message);
	}

    if (navigator.geolocation) {
        // 現在の位置情報取得を実施
        navigator.geolocation.getCurrentPosition(onSuccess, onError);
	} else {
		window.alert("本ブラウザではGeolocationが使えません");
	}
</script>

  <div class="page">
    <header>

      <h1>マイ Geo アプリケーション</h1>

    </header>

    <form action="./map2525" method="POST">
      <div id="innerHTMLtxt"></div>
      <input type="submit" value="作成">
    </form>

    <footer> </footer>
  </div>
</body>
</html>