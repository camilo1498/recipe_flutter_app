import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';
import 'package:receipt_app/src/data/source/local_storage/hive_service.dart';

class GlobalController extends GetxController {
  static GlobalController get inst => Get.find();

  /// instances
  final HiveService hiveServices = HiveService();

  /// streams
  StreamSubscription? _internetStream;

  /// variables
  bool get isOnline => _isOnline.value;

  /// getters
  bool get isMobileData => _isMobileData.value;
  UserModel? get profile => hiveServices.profile;
  final RxBool _isOnline = true.obs, _isMobileData = false.obs;

  @override
  void onReady() async {
    _onListenInternet();
    debugPrint('.- PROFILE: ${hiveServices.profile?.toJson()}');
    super.onReady();
  }

  @override
  void onClose() {
    _internetStream?.cancel();
    super.onClose();
  }

  /// listen internet
  _onListenInternet() {
    _internetStream = AppUtils.listenInternet((value) async {
      _isOnline.value = await AppUtils.isInternet(showSnackbar: true);

      switch (value) {
        case ConnectivityResult.mobile:
          debugPrint(".- Hay internet: ${_isOnline.value} / Conexion: $value");
          _isOnline.value
              ? _isMobileData.value = true
              : _isMobileData.value = false;
          break;
        case ConnectivityResult.wifi:
          debugPrint(".- Hay internet: ${_isOnline.value} / Conexion: $value");
          _isMobileData.value = false;
          break;
        case ConnectivityResult.none:
          debugPrint(".- Hay internet: ${_isOnline.value} / Conexion: $value");
          _isOnline.value = false;
          _isMobileData.value = false;
          break;
        default:
      }
    });
  }
}
