import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';
import 'package:receipt_app/src/data/source/http/http_service.dart';
import 'package:receipt_app/src/data/source/local_storage/hive_service.dart';

class DataPutService {
  /// instances
  final HiveService _hiveService = GlobalController.inst.hiveServices;

  Future<Map<String, dynamic>> updateUserData({
    required String name,
    required String lastname,
    required String email,
  }) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      /// Http query
      final Response res =
          await HttpService().dio.put('api/user/update_profile', data: {
        "name": name,
        "lastname": lastname,
        "email": email,
      });
      Map<String, dynamic> decodeResp = res.data;

      if (decodeResp['success'] == true) {
        /// success response
        /// save profile into local storage
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

  Future<Map<String, dynamic>> saveRecipe({required String recipeId}) async {
    try {
      /// validate if device has internet connection
      if (!await AppUtils.isInternet()) throw 'internet';

      final Response res =
          await HttpService().dio.put('api/user/favourite_recipe?id=$recipeId');
      Map<String, dynamic> decodeResp = res.data;
      return {
        'success': decodeResp['success'],
        'message': decodeResp['message'],
        'data': decodeResp['data']['favourite']
      };
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
}
