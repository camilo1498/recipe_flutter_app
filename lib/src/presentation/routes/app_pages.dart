import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/create_recipe_controller.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/create_recipe_page.dart';
import 'package:receipt_app/src/presentation/pages/login/login_controller.dart';
import 'package:receipt_app/src/presentation/pages/login/login_page.dart';
import 'package:receipt_app/src/presentation/pages/main/main_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/home_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/home_page.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/saved_recipes/saved_recipes_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/saved_recipes/saved_recipes_page.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/user_profile/userProfileController.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/user_profile/user_profile_page.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_page.dart';
import 'package:receipt_app/src/presentation/pages/register/register_controller.dart';
import 'package:receipt_app/src/presentation/pages/register/register_page.dart';
import 'package:receipt_app/src/presentation/pages/splash_screen/splash_screen_contoller.dart';
import 'package:receipt_app/src/presentation/pages/splash_screen/splash_screen_page.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';

import '../pages/main/main_page.dart';

class AppPages {
  /// app pages
  static List<GetPage> get pages => [
        GetPage(
            name: AppRoutes.splashScreenPage,
            page: () => const SplashScreenPage(),
            binding: BindingsBuilder(
              () => Get.lazyPut(() => SplashScreenController()),
            )),
        GetPage(
            name: AppRoutes.loginPage,
            page: () => const LoginPage(),
            binding: BindingsBuilder(
              () => Get.lazyPut(() => LoginController()),
            )),
        GetPage(
            name: AppRoutes.registerPage,
            page: () => const RegisterPage(),
            binding: BindingsBuilder(
              () => Get.lazyPut(() => RegisterController()),
            )),
        GetPage(
            name: AppRoutes.mainPage,
            page: () => const MainPage(),
            binding: BindingsBuilder(
              () => Get.lazyPut(() => MainController()),
            )),
        GetPage(
            name: AppRoutes.recipeDetailController,
            page: () => const RecipeDetailPage(),
            binding: BindingsBuilder(
              () => Get.lazyPut(() => RecipeDetailController()),
            )),
        GetPage(
            name: AppRoutes.createRecipePage,
            page: () => const CreateRecipePage(),
            binding: BindingsBuilder(
              () => Get.lazyPut(() => CreateRecipeController()),
            )),
      ];

  /// nested pages / navigation
  static Route<dynamic> mainPages(RouteSettings route) {
    Get.routing.args = route.arguments;
    switch (route.name) {
      case AppRoutes.homePage:
        return GetPageRoute(
          routeName: AppRoutes.homePage,
          settings: route,
          page: () => const HomePage(),
          binding: BindingsBuilder(
            () => Get.lazyPut(() => HomeController()),
          ),
        );
      case AppRoutes.savedRecipes:
        return GetPageRoute(
          routeName: AppRoutes.savedRecipes,
          settings: route,
          page: () => const SavedRecipesPage(),
          binding: BindingsBuilder(
            () => Get.lazyPut(() => SavedRecipesController()),
          ),
        );
      case AppRoutes.userProfile:
        return GetPageRoute(
          routeName: AppRoutes.userProfile,
          settings: route,
          page: () => const UserProfilePage(),
          binding: BindingsBuilder(
            () => Get.lazyPut(() => UserProfileController()),
          ),
        );
      default:
        return GetPageRoute(
          routeName: AppRoutes.homePage,
          settings: route,
          page: () => const HomePage(),
          binding: BindingsBuilder(
            () => Get.lazyPut(() => HomeController()),
          ),
        );
    }
  }
}
