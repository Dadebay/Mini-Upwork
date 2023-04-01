import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/error_widgets/empty_widgets.dart';
import '../../../constants/widgets.dart';
import '../../../data/services/history_orders_service.dart';

class HistoryOrders extends StatelessWidget {
  const HistoryOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          scrolledUnderElevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'homePage4'.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: gilroyMedium,
              fontSize: 22,
            ),
          ),
        ),
        body: customWidget(
            child: FutureBuilder(
                future: HistoryOrdersService().getHistoryOrders(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.connectionState == ConnectionState.waiting) {
                    return spinKit();
                  } else if (streamSnapshot.hasError) {
                    return errorPage();
                  } else if (streamSnapshot.data == null) {
                    return emptyPage();
                  }
                  print(streamSnapshot.data);
                  return Container(
                      width: Get.size.width,
                      height: Get.size.height,
                      child: ListView.builder(
                        itemCount: streamSnapshot.data!.length,
                        physics: BouncingScrollPhysics(),
                        itemExtent: 150,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius30, boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3, spreadRadius: 3)]),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: borderRadius20),
                                    child: Center(
                                      child: Text(
                                        '#' + streamSnapshot.data![index].id!.toString(),
                                        style: TextStyle(fontFamily: gilroyBold, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        textPart('name', streamSnapshot.data![index].categoryName!),
                                        textPart('createdAt', streamSnapshot.data![index].createdAt!),
                                        textPart('phoneNumber', streamSnapshot.data![index].phone!),
                                        textPart('status', streamSnapshot.data![index].status == 1 ? 'waiting' : 'accepted'),
                                      ],
                                    )),
                              ],
                            ),
                          );
                        },
                      ));
                })));
  }

  Row textPart(String name1, String name2) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Text(
          name1.tr + ' : ',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontFamily: gilroySemiBold,
          ),
        )),
        Expanded(
            child: Text(
          name2.tr,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontFamily: gilroyMedium,
          ),
        ))
      ],
    );
  }
}
