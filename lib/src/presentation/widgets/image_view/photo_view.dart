import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';

class ViewPhotos extends StatefulWidget {
  final String heroTitle;
  final int imageIndex;
  final List<String> imageUrlList;
  final List<File> imageFileList;
  final bool isNetworkImg;
  const ViewPhotos(
      {super.key,
      required this.imageIndex,
      required this.imageUrlList,
      required this.imageFileList,
      this.heroTitle = "img",
      this.isNetworkImg = true});

  @override
  ViewPhotosState createState() => ViewPhotosState();
}

class ViewPhotosState extends State<ViewPhotos> {
  late PageController pageController;
  late int currentIndex;
  @override
  void initState() {
    currentIndex = widget.imageIndex;
    pageController = PageController(initialPage: widget.imageIndex);
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.imageUrlList.isNotEmpty
              ? "${currentIndex + 1} de ${widget.imageUrlList.length}"
              : "${currentIndex + 1} de ${widget.imageFileList.length}",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: pageController,
            builder: (BuildContext context, int index) {
              if (widget.isNetworkImg && widget.imageUrlList.isNotEmpty) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.imageUrlList[index]),
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: widget.heroTitle),
                );
              } else {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(widget.imageFileList[index]),
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: widget.heroTitle),
                );
              }
            },
            onPageChanged: onPageChanged,
            itemCount: widget.imageUrlList.isNotEmpty
                ? widget.imageUrlList.length
                : widget.imageFileList.length,
            loadingBuilder: (context, progress) => const Center(
                child: AnimatedLoadingWidget(size: 25, color: AppColor.energy)),
          ),
        ],
      ),
    );
  }
}
