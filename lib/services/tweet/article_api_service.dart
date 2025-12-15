import 'package:dio/dio.dart';

import 'package:prac/models/others/article_model.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/provider/tweet/comment_control_provider.dart';

class ArticleApiService {
  //디오 프로바이더 DI
  final Dio dio;

  ArticleApiService({required this.dio});

  //GET
  Future<List<ArticleModel>> fetchArticles() async {
    final response = await dio.get(
      "/api/home",
      data: {
        "page": 0,
        "size": 1,
        "sort": ["string"],
      },
    );
    //1. dio.get으로 받는 reponse는 json파일의 리스트이다
    //2. 어쩃든 파싱을 해야함 각각의 json파일을 articlemodel 객체로
    //3. 그래서 articlemodel들을 모아놓은 리스트를 하나 만들었음 = datalist
    //4. 각각의 json파일을 순회하면서 파싱하는 작업은 map()사용
    final List<dynamic> datalist = response.data;

    final List<ArticleModel> articles = datalist.map((json) {
      return ArticleModel.fromJson(json);
    }).toList();

    return articles;
  }

  Future<void> postArticle(String content, CommentControl commentState) async {
    try {
      final request = await dio.post(
        "article_model",
        data: {
          "article_string": content,
          "comment_Control": commentState.toString(),
        },
      );
      if (request.statusCode != 201) {
        throw Exception(
          '게시글 post 실패 : ${request.statusCode} : ${request.data}',
        );
      }
    } catch (e) {
      throw Exception("오류 발생 : $e");
    }
  }
}




// class ArticleApiService {
//   final Dio dio;

//   ArticleApiService({required this.dio});

//   // final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8080"'));

//   //FETCH
//   Future<List<ArticleModel>> fetchArticles() async {
//     final response = await dio.post(
//       "/api/home",
//       data: {
//         "page": 0,
//         "size": 1,
//         "sort": ["String"],
//       },
//     );

//     // response.data = List<dynamic>
//     final List<dynamic> dataList = response.data;

//     // JSON List -> List<ArticleModel>
//     final articles = dataList
//         .map((json) => ArticleModel.fromJson(json))
//         .toList();

//     return articles;
//   }


// }

// //POST
//  Future<void> postArticle(String content, CommentControl commentState) async {
//     try {
//       final request = await dio.post(
//         "article_model",
//         data: {
//           "article_string": content,
//           "comment_Control": commentState.toString(),
//         },
//       );
//       if (request.statusCode != 201) {
//         throw Exception(
//           '게시글 post 실패 : ${request.statusCode} : ${request.data}',
//         );
//       }
//     } catch (e) {
//       throw Exception("오류 발생 : $e");
//     }
//   }

