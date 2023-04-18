import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/image_view/photo_view.dart';

class GalleryView extends StatelessWidget {
  final List<String> imageUrlList;
  final List<File> imageFileList;
  final double width;
  final double height;
  final String heroTag;
  final bool isNetworkImg;
  const GalleryView(
      {super.key,
      required this.imageUrlList,
      required this.imageFileList,
      required this.height,
      required this.width,
      this.heroTag = 'photo',
      this.isNetworkImg = true});

  static const MethodChannel _channel = MethodChannel('gallery_view');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...(imageUrlList.isNotEmpty ? imageUrlList : imageFileList)
              .map((img) {
            final int index =
                (imageUrlList.isNotEmpty ? imageUrlList : imageFileList)
                    .indexOf(img);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: AppGlobalDecoration.globalRadius,
                    boxShadow: AppGlobalDecoration.globalShadow),
                child: ClipRRect(
                  borderRadius: AppGlobalDecoration.globalRadius,
                  child: AnimatedOnTapWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) {
                                return ViewPhotos(
                                  imageIndex: index,
                                  imageUrlList: imageUrlList,
                                  imageFileList: imageFileList,
                                  heroTitle: "$heroTag$index",
                                  isNetworkImg: isNetworkImg,
                                );
                              },
                              fullscreenDialog: true));
                    },
                    child: Hero(
                      tag: "$heroTag$index",
                      child: isNetworkImg
                          ? CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: imageUrlList[index],
                              placeholder: (context, url) => const Center(
                                  child: AnimatedLoadingWidget(
                                      size: 20, color: AppColor.energy)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          // TODO:  change to image file
                          : imageUrlList.isNotEmpty
                              ? Image.asset(
                                  imageUrlList[index],
                                  fit: BoxFit.cover,
                                )
                              : Image.file(imageFileList[index],
                                  fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
