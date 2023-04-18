import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';
import 'package:receipt_app/src/data/source/http/data_get_service.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';

class SavedRecipesController extends GetxController {
  static SavedRecipesController get inst => Get.find<SavedRecipesController>();

  /// instances
  final DataGetService _dataGetService = DataGetService();

  /// variables
  List<Favourite> favouriteList = [];
  bool loading = true;

  @override
  void onInit() async {
    await getProfile();
    super.onInit();
  }

  getProfile() async {
    await _dataGetService.getUserProfile().whenComplete(() {
      favouriteList = GlobalController.inst.profile!.favourites;
      loading = false;
      update(['favourite_page']);
    });
  }

  goToDetailPage({required String recipeId}) =>
      Get.toNamed(AppRoutes.recipeDetailController,
          arguments: {'recipe_id': recipeId, 'come_from_home': false});
}
