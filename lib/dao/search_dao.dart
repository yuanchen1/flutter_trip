import 'dart:async';
import 'dart:convert';
import 'package:flutter_trips/model/search_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL  = 'http://www.devio.org/io/flutter_app/json/home_page.json';

//搜索接口
class SearchDao {
  static Future<SearchModel> fetch(String url) async {
    final response  = await http.get(url);
    if(response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //fix中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return SearchModel.fromJson(result);
    }else {
      throw Exception('请求失败了~\r\n请联系管理员\r\n管理员电话:17600636164');
    }
  }
}