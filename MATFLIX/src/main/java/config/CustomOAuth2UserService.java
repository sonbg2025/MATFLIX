package config;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		String accessToken = userRequest.getAccessToken().getTokenValue();
		Map<String, Object> attributes = new HashMap<>();

		try {
			URL url = new URL("https://kapi.kakao.com/v2/user/me");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine, result = "";
			while ((inputLine = in.readLine()) != null) {
				result += inputLine;
			}

			JsonElement element = JsonParser.parseString(result);
			JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			JsonObject profile = kakaoAccount.getAsJsonObject().get("profile").getAsJsonObject();

			String id = element.getAsJsonObject().get("id").getAsString();
			String email = kakaoAccount.get("email").getAsString();
			String nickname = profile.get("nickname").getAsString();

			attributes.put("id", id);
			attributes.put("email", email);
			attributes.put("nickname", nickname);

		} catch (Exception e) {
			throw new OAuth2AuthenticationException("카카오 사용자 정보 요청 실패", e);
		}

		return new DefaultOAuth2User(Collections.singleton(() -> "ROLE_USER"), attributes, "id");
	}
}
