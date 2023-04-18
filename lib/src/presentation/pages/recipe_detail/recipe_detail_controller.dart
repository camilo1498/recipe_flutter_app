import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_comment_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_model.dart';
import 'package:receipt_app/src/data/source/http/data_get_service.dart';
import 'package:receipt_app/src/data/source/http/data_post_service.dart';
import 'package:receipt_app/src/data/source/http/data_put_service.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/home_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/saved_recipes/saved_recipes_controller.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/sheets/create_comment_sheet.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeDetailController extends GetxController {
  /// instances
  final DataGetService _dataGetService = DataGetService();
  final DataPutService _dataPutService = DataPutService();
  final DataPostService _dataPostService = DataPostService();
  final ImagePicker _imagePicker = ImagePicker();

  /// variables
  int maxPage = 1;
  int totalPage = 0;
  int currentPage = 0;
  int currentCommentIndex = 1;
  String recipeId = '';
  bool loading = true;
  bool cameFromHome = true;
  bool loadingComment = true;
  bool loadingFavIcon = false;
  bool creatingComment = false;
  bool validatedFields = false;
  bool loadingCommentPag = false;
  RecipeModel? recipeData;
  List<CommentModel> commentList = [];
  List<XFile> selectedImg = [];

  /// controllers
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  final TextEditingController commentTxtController =
      TextEditingController(text: '');
  YoutubePlayerController videoController =
      YoutubePlayerController(initialVideoId: '');

  /// initialize variables
  @override
  void onInit() async {
    /// get prev page args
    if (Get.arguments != null) {
      recipeId = Get.arguments['recipe_id'];
      cameFromHome = Get.arguments['come_from_home'] ?? false;
    }

    /// listen page changed
    pageController.addListener(() {
      currentPage = (pageController.page ?? 0).toInt();
      update(['page_index']);
    });

    /// fetch init data
    /// fetch next comment page
    scrollController.addListener(() async {
      double max = scrollController.positions.last.maxScrollExtent - 50;
      if (max < scrollController.positions.last.pixels && !loadingCommentPag) {
        currentCommentIndex++;
        if (currentCommentIndex <= maxPage) {
          loadingCommentPag = true;
          update(['recipe_comments']);
          await _getComments(page: currentCommentIndex);
        }
      }
    });
    await _getRecipeById();
    await _getComments();

    super.onInit();
  }

  /// close controllers
  @override
  void onClose() {
    pageController.dispose();
    videoController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  ///*  Backend  Queries *///

  /// fetch recipe data
  _getRecipeById() async {
    await _dataGetService.getRecipeById(id: recipeId).then((res) {
      if (res['success'] == true) {
        recipeData = res['data'];
        videoController = YoutubePlayerController(
          initialVideoId:
              YoutubePlayer.convertUrlToId(recipeData!.videoUri) ?? '',
          flags: const YoutubePlayerFlags(
              mute: false,
              forceHD: true,
              disableDragSeek: true,
              autoPlay: false),
        );
      }
    }).whenComplete(() {
      loading = false;
      update(['recipe_detail_page']);
    });
  }

  /// favourite - un-favourite recipe backend query
  favouriteRecipe() async {
    loadingFavIcon = true;
    update(['loading_fav_icon']);
    await _dataPutService.saveRecipe(recipeId: recipeId).then((res) async {
      if (res['success'] == true) {
        if (cameFromHome) {
          await _dataGetService.getUserProfile();
          await HomeController.inst.getRecipes();
        } else {
          await SavedRecipesController.inst.getProfile();
        }
        loadingFavIcon = false;
        update(['loading_fav_icon']);
        AppUtils.snackBar(title: 'Guardar', menssage: res['message']);
      } else {
        loadingFavIcon = false;
        update(['loading_fav_icon']);
        AppUtils.snackBar(
            title: 'Guardar',
            menssage: 'Error al guardar la '
                'receta');
      }
    });
  }

  /// fetch comments
  _getComments({int page = 1, bool reload = false}) async {
    await _dataGetService
        .getRecipeComments(id: recipeId, page: page)
        .then((res) {
      if (res['success'] == true) {
        CommentResponseModel localRes = res['data'];
        maxPage = localRes.nextPage;
        if (reload) {
          commentList.clear();
        }
        commentList.addAll(localRes.data);
        commentList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    }).whenComplete(() {
      loadingComment = false;
      loadingCommentPag = false;
      update(['recipe_comments']);
    });
  }

  /// send new comment data to backend
  createCommentQuery() async {
    FocusManager.instance.primaryFocus?.unfocus();
    creatingComment = true;
    update(['create_comment']);
    await _dataPostService
        .createRecipeComment(
            photo: selectedImg,
            recipeId: recipeId,
            comment: commentTxtController.text.trim())
        .then((res) async {
      if (res['success'] == true) {
        currentCommentIndex = 1;
        maxPage = 1;
        await _getComments(reload: true);
        Get.back();
        AppUtils.snackBar(title: 'Comentario', menssage: res['message']);
      } else {
        AppUtils.snackBar(title: 'Comentario', menssage: res['message']);
      }
    }).whenComplete(() {
      creatingComment = false;
      update(['create_comment']);
    });
  }

  ///* On Tap Methods *///

  /// open comment sheet
  openCreateComment() {
    return Get.bottomSheet(const CreateCommentSheet(),
            enableDrag: !creatingComment, isDismissible: !creatingComment)
        .whenComplete(() {
      selectedImg.clear();
      creatingComment = false;
      commentTxtController.clear();
      update(['create_comment']);
    });
  }

  /// open gallery
  openGalleryPicker() async {
    selectedImg = await _imagePicker.pickMultiImage(
        imageQuality: 100, requestFullMetadata: true);
    update(['create_comment']);
  }

  ///* Validation Methods *///

  /// clear selected img
  deleteSelectedImg() {
    selectedImg.clear();
    update(['create_comment']);
  }

  /// validate text field
  onChangedText(String text) {
    if (text.trim().isNotEmpty) {
      validatedFields = true;
      update(['create_comment']);
    } else {
      validatedFields = false;
      update(['create_comment']);
    }
  }
}
