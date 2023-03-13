// ignore_for_file: deprecated_member_use, file_names, depend_on_referenced_packages, avoid_void_async, always_declare_return_types, type_annotate_public_apis, unnecessary_statements, unrelated_type_equality_checks

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

import '../../../constants/buttons/agree_button.dart';
import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';

class Page3 extends StatefulWidget {
  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final HomeController homeController = Get.put(HomeController());

  final List<XFile> _imageFileList = [];
  final ImagePicker _picker = ImagePicker();

  void selectImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage(imageQuality: 25);
    if (selectedImages.length <= 15) {
      setState(() {
        final int a = selectedImages.length;
        final int b = _imageFileList.length;
        if (a + b <= 15) {
          if (b <= 15) {
            for (int i = 0; i < a; i++) {
              if (((File(selectedImages[i].path).readAsBytesSync().length / 1024) / 1024) < 1) {
                _imageFileList.add(selectedImages[i]);
              } else {
                showSnackBar("mbErrorTitle", "mbErrorSubtitle", kPrimaryColor);
                Vibration.vibrate();
              }
            }
          } else {
            showSnackBar("selectMoreImageTitle", "selectMoreImageSubtitle", kPrimaryColor);
            Vibration.vibrate();
          }
        } else {
          showSnackBar("selectMoreImageTitle", "selectMoreImageSubtitle", kPrimaryColor);
          Vibration.vibrate();
        }
      });
    } else {
      showSnackBar("selectMoreImageTitle", "selectMoreImageSubtitle", kPrimaryColor);
      Vibration.vibrate();
    }
  }

  bool addRealEstateValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          width: Get.size.width,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "selectImages".tr,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
            ),
            Text(
              "selectImagesCount".tr,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey[400], fontFamily: gilroyMedium, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _imageFileList.isEmpty ? 1 : _imageFileList.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () async {
                          await Permission.camera.request();
                          await Permission.photos.request();
                          selectImages();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            padding: const EdgeInsets.all(6),
                            strokeWidth: 2,
                            color: kPrimaryColor,
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: kPrimaryColor,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(borderRadius: borderRadius20),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            top: 10,
                            bottom: 5,
                            left: 5,
                            right: 10,
                            child: Material(
                              elevation: 2,
                              borderRadius: borderRadius20,
                              child: ClipRRect(
                                borderRadius: borderRadius20,
                                child: Image.file(File(_imageFileList[index - 1].path), fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            // agreeButton2()
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AgreeButton(
                onTap: () {
                  homeController.incrementPageIndex();
                },
              ),
            )
          ])),
    );
  }
}
