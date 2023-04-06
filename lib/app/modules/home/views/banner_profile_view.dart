import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:maksat_app/app/constants/custom_app_bar.dart';

import '../../../constants/constants.dart';
import '../../../constants/error_widgets/empty_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/banner_model.dart';
import '../../../data/services/banner_service.dart';

class BannerProfileView extends StatefulWidget {
  final int ID;

  BannerProfileView(this.ID);

  @override
  State<BannerProfileView> createState() => _BannerProfileViewState();
}

class _BannerProfileViewState extends State<BannerProfileView> {
  String name = "";

  changeName(String name1) {
    name = name1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: name),
      body: FutureBuilder<BannerModel>(
          future: BannerService().getBannersByID(widget.ID).then((value) {
            changeName(value.title!);
            return value;
          }),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return spinKit();
            } else if (streamSnapshot.hasError) {
              return errorPage();
            } else if (streamSnapshot.data == null) {
              return emptyPage();
            }
            return ListView(
              children: [
                CachedNetworkImage(
                  fadeInCurve: Curves.ease,
                  imageUrl: '$serverURL/${streamSnapshot.data!.destination!}-mini.webp',
                  imageBuilder: (context, imageProvider) => Container(
                    width: size.width,
                    height: 250,
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
                    streamSnapshot.data!.description!,
                    style: const TextStyle(fontSize: 20, fontFamily: gilroyRegular),
                  ),
                )
              ],
            );
          }),
    );
  }
}
