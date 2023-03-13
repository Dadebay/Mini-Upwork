import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maksat_app/app/constants/custom_app_bar.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';

class BannerProfileView extends GetView {
  final String description;
  final String pageName;
  final String image;

  const BannerProfileView(this.pageName, this.image, this.description);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: pageName),
      body: ListView(
        children: [
          CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => Center(child: spinKit()),
            errorWidget: (context, url, error) => noBannerImage(),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              description,
              style: const TextStyle(fontSize: 20, fontFamily: gilroyRegular),
            ),
          )
        ],
      ),
    );
  }
}
