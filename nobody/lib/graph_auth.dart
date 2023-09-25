import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nobody/references.dart';

// const APP_SECRET = "QKr8Q~ZvViURbcgL60Tqd3MsyMXKqBPACX4K4dAt";
const APP_ID = "376877d4-f7ea-4c45-bdc8-1c592ac38a9d";
const TENANT_ID = "bad285a0-eef3-4865-9a2c-7893068e70b0";
// const scope = "api://376877d4-f7ea-4c45-bdc8-1c592ac38a9d/aims";
// const scope = "https://graph.microsoft.com/.default";
const scopes = [
  'Mail.ReadWrite',
  'Mail.Send',
];

const authorization_endpoint =
    'https://login.microsoftonline.com/bad285a0-eef3-4865-9a2c-7893068e70b0/oauth2/v2.0/authorize';
const auth_token_endpoint =
    'https://login.microsoftonline.com/bad285a0-eef3-4865-9a2c-7893068e70b0/oauth2/v2.0/token';
const redirect_url = 'http://localhost:8000/redirect';

// const scope_root = "https://graph.microsoft.com/";

// String get scope => scope_root + scopes.join(",");
String get scope => 'https://graph.microsoft.com/Mail.ReadWrite';

Future<GraphServiceClient> build_graph(String username) async {
  var _token = await get_token(username);
  if (_token == null) {
    throw Exception('no token');
  }
  var _client = build_client(_token);
  return GraphServiceClient(_token, _client);
}

Dio build_client(String token) {
  final client = Dio();
  client.options.headers['Authorization'] = 'Bearer $token'; // Added 'Bearer'
  return client;
}

Future<void> launch(String url) async {
  Show.action("OPENING", "BROWSER", "FOR", "AUTHENTICATION");
  if (Platform.isWindows) {
    await Process.run("start", [url], runInShell: true);
  } else if (Platform.isMacOS) {
    await Process.run('open', [url]);
  } else if (Platform.isLinux) {
    await Process.run('xdg-open', [url]);
  }
}

Future<String?> get_token(String username, {retry_count = 0}) async {
  // use authorization code flow (native app) to get token
  //try to get token from database
  if (retry_count > 3) {
    throw Exception('too many retries');
  }
  var token_from_store = await tokenStore.get("token_$username");
  var token_validity = await dateStore.get("token_validity_$username");
  if (token_from_store != null &&
      token_validity != null &&
      DateTime.now().isBefore(token_validity)) {
    Show.success("USING TOKEN", "FROM STORE");
    return token_from_store;
  }
  try {
    var url =
        '$authorization_endpoint?client_id=$APP_ID^&scope=$scope^&response_type=code^&redirect_uri=$redirect_url';
    print(url);
    await launch(url);
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8000);
    var request = await server.first;
    var code = request.uri.queryParameters['code'];
    request.response
      ..statusCode = 200
      ..headers.set('content-type', 'text/html')
      ..write('<html><h1>Authentication successful</h1></html>');
    if (code == null) {
      throw Exception('no code');
    }
    Show.success("RECEIVED", "AUTHORIZATION", "CODE");
    //store code in database
    await tokenStore.set("auth_$username", code);
    var client = HttpClient();
    var request2 = await client.postUrl(Uri.parse(auth_token_endpoint));
    request2.headers.set('content-type', 'application/x-www-form-urlencoded');
    request2.write('client_id=$APP_ID');
    request2.write('&scope=$scope');
    request2.write('&code=$code');
    request2.write('&redirect_uri=$redirect_url');
    request2.write('&grant_type=authorization_code');
    // request2.write('&client_secret=$APP_SECRET');
    var response = await request2.close();
    var body = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(body);
    var token = json['access_token'];
    if (token == null) {
      throw Exception('no token');
    }
    Show.success("RECEIVED", "ACCESS TOKEN");
    await tokenStore.set("token_$username", token);
    return token;
  } catch (e) {
    return get_token(username, retry_count: retry_count + 1);
  }
}
