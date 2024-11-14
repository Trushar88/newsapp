// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:newsapp/app/config/api_const.dart';
import 'package:newsapp/app/service/generic_convert.dart';
import 'package:newsapp/base/base_repository.dart';
import 'package:newsapp/base/base_response.dart';
import 'package:newsapp/model/dio_exception.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/app/global.dart' as global;

class HomeRepo extends BaseRepository {
  Future<BaseResponse?> fetchNews(int page, int pageSize, String query, String category) async {
    try {
      final queries = category.isNotEmpty
          ? {
              'category': category, // Search query
              'page': page,
              'pageSize': pageSize,
              'sortBy': "publishedAt",
              'apiKey': global.newsAPIKey,
            }
          : {
              'q': query.isNotEmpty ? query : "all", // Search query
              'page': page,
              'pageSize': pageSize,
              'sortBy': "publishedAt",
              'apiKey': global.newsAPIKey,
            };

      var response = await super.get(category.isNotEmpty ? APICONST.topHeadLines : APICONST.everything, queryParameters: queries, options: Options(headers: await super.getApiHeaders(false)));
      if (response != null && response.statusCode == 200) {
        var responseData = [];
        if (response.data != null && response.data["articles"] != null && response.data["articles"].isNotEmpty) {
          responseData = Generics(response.data["articles"]).getAsList<NewsArticle>((p0) => NewsArticle.fromJson(p0));
        }
        return returnApiResult(response.data, responseData);
      } else {
        return returnApiResult(response!.data, null);
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e).toString();
      if (e.response != null && e.response!.data != null && e.response!.data != null) {
        return returnApiResult(e.response!.data, null);
      } else {
        return null;
      }
    }
  }
}
