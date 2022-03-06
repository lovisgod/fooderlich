import 'package:chopper/chopper.dart';

import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';
part 'recipe_service.chopper.dart';


const String apiKey = '41c9217830070ac340f7cb96a4148d4b';
const String apiId = 'a24502dd';
const String apiUrl = 'https://api.edamam.com';


// class RecipeService {
//   // 1
//   Future getData(String url) async {
//     // 2
//     print('Calling url: $url');
//     // 3
//     final response = await get(Uri.parse(url));
//     // 4
//     if (response.statusCode == 200) {
//       // 5
//       return response.body;
//     } else {
//       // 6
//       print(response.statusCode);
//     }
//   }
// // Add getRecipes
//
// // 1
//   Future<dynamic> getRecipes(String query, int from, int to) async {
//     // 2
//     final recipeData = await getData(
//         '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
//     // 3
//     return recipeData;
//   }
//
// }


// 1
@ChopperApi()
// 2
abstract class RecipeService extends ChopperService {
  // 3
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      // 5
      @Query('q') String query, @Query('from') int from, @Query('to') int to);
// Add create()
  static RecipeService create() {
    // 1
    final client = ChopperClient(
      // 2
      baseUrl: apiUrl,
      // 3
      interceptors: [_interceptor, HttpLoggingInterceptor()],
      // 4
      converter: ModelConverter(),
      // 5
      errorConverter: const JsonConverter(),
      // 6
      services: [
        _$RecipeService(),
      ],
    );
    // 7
    return _$RecipeService(client);
  }

}
// TODO: Add _addQuery()
Request _interceptor(Request req) {
  // 1
  final params = Map<String, dynamic>.from(req.parameters);
  // 2
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  // 3
  return req.copyWith(parameters: params);
}

