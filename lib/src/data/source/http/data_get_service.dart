import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_comment_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_difficulty_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_type_model.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';
import 'package:receipt_app/src/data/source/http/http_service.dart';
import 'package:receipt_app/src/data/source/local_storage/hive_service.dart';

class DataGetService {
  /// instances
  final HiveService _hiveService = GlobalController.inst.hiveServices;

  /// fetch user
  Future<Map<String, dynamic>> getLoginToken(
      {required String email, required String password}) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// fetch
      final Response res = await HttpService()
          .dio
          .get('api/user/login?email=$email&password=$password');
      Map<String, dynamic> decodeResp = res.data;

      /// validate response
      if (decodeResp['success'] == true) {
        _hiveService.token = decodeResp['token'];
        _hiveService.refreshToken = decodeResp['refresh_token'];

        return {
          'success': true,
          'message': decodeResp['message'],
          'token': _hiveService.token,
          'refresh_token': _hiveService.refreshToken
        };
      } else {
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

  /// fetch user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// fetch
      final Response res = await HttpService().dio.get('api/user/profile');
      Map<String, dynamic> decodeResp = res.data;

      /// validate response
      if (decodeResp['success'] == true) {
        /// save profile into local storage

        _hiveService.profile = null;
        _hiveService.profile = UserResponseModel.fromJson(decodeResp).data;

        /// return user profile
        return {
          'success': true,
          'message': decodeResp['message'],
          'data': _hiveService.profile
        };
      } else {
        debugPrint(decodeResp.toString());
        return {'success': false, 'message': decodeResp['message'], 'data': {}};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Error al obtener el perfil',
        'data': {}
      };
    }
  }

  /// fetch all recipes
  Future<Map<String, dynamic>> getAllRecipes(
      {String name = "", String? type}) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      String data = 'name=$name';

      if (type != null) {
        data = 'name=$name&type=$type';
      }

      /// fetch
      final Response res = await HttpService().dio.get(
            'api/recipe/getAll?$data',
          );
      Map<String, dynamic> decodeResp = res.data;
      print(decodeResp);

      /// validate response
      if (decodeResp['success'] == true) {
        return {
          'success': true,
          'message': decodeResp['message'],
          'data': RecipeResponseModel.fromJson(decodeResp).data
        };
      } else {
        debugPrint(decodeResp.toString());
        return {'success': false, 'message': decodeResp['message'], 'data': []};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Error al obtener las recetas',
        'data': []
      };
    }
  }

  /// fetch all recipe type
  Future<Map<String, dynamic>> getRecipeTypes() async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// fetch
      final Response res =
          await HttpService().dio.get('api/recipe/getAllTypes');
      Map<String, dynamic> decodeResp = res.data;

      /// validate response
      if (decodeResp['success'] == true) {
        return {
          'success': true,
          'message': decodeResp['message'],
          'data': RecipeTypeResponseModel.fromJson(decodeResp).data
        };
      } else {
        debugPrint(decodeResp.toString());
        return {'success': false, 'message': decodeResp['message'], 'data': {}};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Error al obtener las recetas',
        'data': {}
      };
    }
  }

  /// fetch recipe recipe by id
  Future<Map<String, dynamic>> getRecipeById({required String id}) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// fetch
      final Response res =
          await HttpService().dio.get('api/recipe/getById?id=$id');
      Map<String, dynamic> decodeResp = res.data;
      if (decodeResp['success'] == true) {
        return {
          'success': true,
          'message': decodeResp['message'],
          'data': RecipeModel.fromJson(decodeResp['data'])
        };
      } else {
        return {'success': false, 'message': decodeResp['message'], 'data': {}};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Error al obtener la receta',
        'data': {}
      };
    }
  }

  Future<Map<String, dynamic>> getRecipeComments(
      {required String id, int page = 1}) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// fetch
      final Response res = await HttpService()
          .dio
          .get('api/recipe/getAllCommentsById?recipe_id=$id&page=$page');
      Map<String, dynamic> decodeResp = res.data;

      if (decodeResp['success'] == true) {
        return {
          'success': true,
          'message': decodeResp['message'],
          'data': CommentResponseModel.fromJson(decodeResp)
        };
      } else {
        return {'success': false, 'message': decodeResp['message'], 'data': []};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Error al obtener la receta',
        'data': []
      };
    }
  }

  /// fetch all recipe type
  Future<Map<String, dynamic>> getRecipeDifficulty() async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// fetch
      final Response res =
          await HttpService().dio.get('api/recipe/getAllDifficulty');
      Map<String, dynamic> decodeResp = res.data;

      /// validate response
      if (decodeResp['success'] == true) {
        return {
          'success': true,
          'message': decodeResp['message'],
          'data': RecipeDifficultyResponseModel.fromJson(decodeResp).data
        };
      } else {
        debugPrint(decodeResp.toString());
        return {'success': false, 'message': decodeResp['message'], 'data': {}};
      }
    } catch (e) {
      if (e.toString() != 'internet') {
        debugPrint(e.toString());
      }
      return {
        'success': false,
        'message': 'Error al obtener la dificultad',
        'data': {}
      };
    }
  }
}
