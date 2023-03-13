import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/data/services/banner_service.dart';

import '../constants.dart';
import '../widgets.dart';
import '../../modules/home/views/banner_profile_view.dart';

class BannerCard extends StatelessWidget {
  final String image;
  final int id;

  const BannerCard({
    required this.image,
    required this.id,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        BannerService().getBannersByID(id).then((value) {
          Get.to(() => BannerProfileView(value.title!, image, value.description!));
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: size.width,
        child: ClipRRect(
          borderRadius: borderRadius30,
          child: CachedNetworkImage(
            fadeInCurve: Curves.ease,
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: borderRadius30,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(child: spinKit()),
            errorWidget: (context, url, error) => Center(
              child: noBannerImage(),
            ),
          ),
        ),
      ),
    );
  }
}
