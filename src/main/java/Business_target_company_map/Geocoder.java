package Business_target_company_map;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

public class Geocoder extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{

	GeoApiContext context = new GeoApiContext.Builder()
            .apiKey("AIzaSyCbfxc6tVLzjs8YmrdB59CMT5Iy3ZEXm0E") // さっき取得したAPIキー
            .build();

	Connection conn = Sql_conn.getDbConnection();
	PreparedStatement channel_state =  null;
	ResultSet channel_resultSet = null;



	try {
		GeocodingResult[] results = GeocodingApi.geocode(context, "愛知県名古屋市西区牛島町６−１ 名古屋ルーセントタワー２５階").await();
		if (results != null && results.length > 0) {
            LatLng latLng = results[0].geometry.location; // とりあえず一番上のデータを使う
            System.out.println("緯度 : " + latLng.lat);
            System.out.println("経度 : " + latLng.lng);
		}
	} catch (ApiException | InterruptedException | IOException e) {
		// TODO 自動生成された catch ブロック
		e.printStackTrace();
	}

	 getServletContext().getRequestDispatcher("/saku.jsp").include(request, response);
	}
}
