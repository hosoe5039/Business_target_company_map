package Business_target_company_map;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;
import com.google.maps.model.LatLng;

@WebServlet("/map222")

public class Geocoder2 extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{

		//文字コード設定
		request.setCharacterEncoding("UTF-8");

		String marker_info = marker_info();

		//マーカ情報をJSPに転送
		request.setAttribute("marker_info", marker_info);
		request.getRequestDispatcher("/map.jsp").forward(request, response);

	}

	private String marker_info() {
		Connection conn = Sql_conn.getDbConnection();
		PreparedStatement company_adress_state =  null;
		ResultSet company_adress = null;

		String sql = "select * from company;";

		try {
			company_adress_state = conn.prepareStatement(sql);
			company_adress = company_adress_state.executeQuery();

		} catch (SQLException e1) {
			e1.printStackTrace();
		}



		GeoApiContext context = new GeoApiContext.Builder()
				.apiKey("AIzaSyCbfxc6tVLzjs8YmrdB59CMT5Iy3ZEXm0E")
				.build();

		//マーカー情報をリストで保存すらためのリスト
		List<String> marker_list = new ArrayList<>();

		try {
			while (company_adress.next()) {

				String company = "";
				String adress = "";

				//DBから会社名と住所の取得
				company =company_adress.getString("company");
				adress = company_adress.getString("adress");

				//テスト1:会社名と住所が正しいかどうか
				System.out.println("テスト1:会社名と住所が正しいかどうか");
				System.out.println("会社名:" + company);
				System.out.println("住所:" + adress);


				//APIを使用して位置情報の取得
				GeocodingResult[] results = GeocodingApi.geocode(context, adress).await();
				LatLng latLng = results[0].geometry.location;

				//テスト2：位置情報が取得できたか
				System.out.println("テスト2：位置情報が取得できたか");
				System.out.println(company + "の緯度 : " + latLng.lat);
				System.out.println(company +"の経度 : " + latLng.lng);

				//緯度経度を文字列の変数に代入
				String lat = String.valueOf(latLng.lat);
				String lng = String.valueOf(latLng.lng);

				//mapにマーカーピンを打つための情報を纏めるmap.jspにてjavaScriptコードで使用します
				String company_name = "name:" + "'" + company + "'";
				String lat_info = "lat:" + lat ;
				String lng_info = "lng:" + lng ;
				String location_info = "{" + String.join(",",company_name,lat_info,lng_info) + "}";

				//マーカー情報をリストに保存
				marker_list.add(location_info);

				//テスト3：javaScriptの形式で纏めたマーカーピ情報が正しいか
				System.out.println("テスト3：javaScriptの形式で纏めたマーカーピ情報が正しいか");
				System.out.println(company_name);
				System.out.println(lat_info);
				System.out.println(lng_info);
				System.out.println(location_info);
			}
		} catch (SQLException | ApiException | InterruptedException | IOException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

		//マーカ情報の一覧を一つの文字列に纏める
		String marker_info = String.join(",", marker_list);

		//テスト4:マーカ情報の一覧が正しいことの確認
		System.out.println(marker_info);
		return marker_info;
	}
}