import 'package:http/http.dart' as http;
class SingletonRestApi{
  static Future<http.Response> post({String url ,String body, Map<String,String> headers = const {}}) async{
    return await http.post(Uri.parse(url),headers: headers, body: body);
  }
  static Future<http.Response> get({String url,Map<String,String> headers =const {}})async{
    return await http.get(Uri.parse(url), headers: headers);
  }
  static Future<http.Response> put({String body , String url, Map<String,String> headers = const {}}) async{
    return await http.put(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:body);
  }
  static Future<http.Response> delete({String url,Map<String,String> headers =const {}}) async{
    return await http.delete(Uri.parse(url), headers: headers);
  }
}