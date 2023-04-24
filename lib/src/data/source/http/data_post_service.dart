import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';
import 'package:receipt_app/src/data/source/http/http_service.dart';
import 'package:receipt_app/src/data/source/local_storage/hive_service.dart';

class DataPostService {
  /// instances
  final HiveService _hiveService = GlobalController.inst.hiveServices;

  /// create user
  Future<Map<String, dynamic>> registerUser(
      {required String name,
      required String lastname,
      required String email,
      required String password}) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// Http query
      final Response res = await HttpService().dio.post('api/user/register',
          data: {
            "name": name,
            "lastname": lastname,
            "email": email,
            "password": password
          });
      Map<String, dynamic> decodeResp = res.data;

      if (decodeResp['success'] == true) {
        /// success response
        /// save profile into local storage
        _hiveService.token = decodeResp['token'];
        _hiveService.refreshToken = decodeResp['refresh_token'];
        _hiveService.profile = UserModel.fromJson(decodeResp['data']);

        return {
          'success': true,
          'message': decodeResp['message'],
          'data': _hiveService.profile
        };
      } else {
        /// error response
        return {'success': false, 'message': decodeResp['message'], 'data': {}};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Estamos teniendo algunos problemas',
        'data': {}
      };
    }
  }

  /// create comment
  Future<Map<String, dynamic>> createRecipeComment(
      {required String recipeId,
      required List<XFile> photo,
      String comment = ''}) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet(showSnackbar: false)) throw 'internet';

      List<MultipartFile> files = photo
          .map((path) => MultipartFile.fromFileSync(path.path,
              filename: path.name,
              contentType: MediaType('image', path.name.split('.')[1])))
          .toList();

      FormData formData = FormData.fromMap({
        'recipe': recipeId,
        'message': comment,
        'image': files,
        'date': DateTime.now()
      });

      final Response res = await HttpService().dio.post(
            'api/recipe/create_comment',
            data: formData,
          );
      final Map<String, dynamic> decodeRes = res.data;
      if (decodeRes['success'] == true) {
        return {'success': true, 'message': 'Comentario creado'};
      } else {
        return {'success': false, 'message': decodeRes['message']};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {'success': false, 'message': 'Ocurrio un error al comentar'};
    }
  }

  /// create recipe
  Future<Map<String, dynamic>> createRecipe({
    required String name,
    required String difficulty,
    required String portions,
    required String preparationTime,
    required List<XFile> image,
    required String videoUri,
    required String type,
    required List<String> ingredients,
    required List<Map<String, dynamic>> steps,
    required List<String> tagListId,
  }) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet(showSnackbar: false)) throw 'internet';

      List<MultipartFile> img = image
          .map((path) => MultipartFile.fromFileSync(path.path,
              filename: path.name,
              contentType: MediaType('image', path.name.split('.')[1])))
          .toList();

      FormData formData = FormData.fromMap({
        'name': name,
        'difficulty': difficulty,
        'portions': portions,
        'preparationTime': preparationTime,
        'image': img,
        'videoUri': videoUri,
        'type': type,
        'ingredients': ingredients,
        'steps': steps,
        'tags': tagListId
      });

      final Response res =
          await HttpService().dio.post('api/recipe/create', data: formData);
      final Map<String, dynamic> decodeRes = res.data;

      if (decodeRes['success'] == true) {
        return {'success': true, 'message': decodeRes['message']};
      } else {
        return {'success': false, 'message': decodeRes['message']};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Ocurrio un error al crear la '
            'receta'
      };
    }
  }
}
