import 'package:dio/dio.dart';
import 'package:ojos_app/core/constants.dart';
import 'package:ojos_app/features/home/data/models/gategory_respone.dart';

Dio dio = Dio();

class HomeApi {

  Future<List<Result>>? feachCategories() async {
    List<Result> results = [];
    Response response = await dio.get(GET_CATEGORIES);
    if (response.statusCode == 200) {
      print('shaimaaa333333333333333333333333333 ${response.statusCode}');
      results.add(Result.fromJson(response.data));
      return results;
    } else {
      return [];
    }
  }
}
