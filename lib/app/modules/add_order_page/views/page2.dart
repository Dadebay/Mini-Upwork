import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maksat_app/app/constants/error_widgets/empty_widgets.dart';
import 'package:maksat_app/app/modules/home/controllers/home_controller.dart';

import '../../../constants/constants.dart';
import '../../../constants/textFields/custom_text_field.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/category_services.dart';

class Page2 extends StatefulWidget {
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late final Future<List<GetCategorySpec>> future;
  final HomeController homeController = Get.put(HomeController());
  final List<TextEditingController> _controllersList = [];
  final List<FocusNode> _focusNodeList = [];
  final List<bool> _checboxList = [];
  final List<List<String>> _namesList = [];
  final List<int> _selectedIndexList = [];

  @override
  void initState() {
    super.initState();
    _namesList.clear();
    future = CategoryServices().getCateSpecById(id: homeController.selectedCategoryID.value);
  }

  Widget widgets(AsyncSnapshot<List<GetCategorySpec>> streamSnapshot, int index) {
    if (_controllersList.length < streamSnapshot.data!.length) {
      _controllersList.add(TextEditingController());
      _checboxList.add(false);
      _focusNodeList.add(FocusNode());
      _namesList.add([]);
      _selectedIndexList.add(-1);
      if (streamSnapshot.data![index].type.toString() == '3') {
        streamSnapshot.data![index].values!.forEach(
          (element) {
            _namesList[index].add(element.name!);
          },
        );
      }
    }
    return streamSnapshot.data![index].type.toString() == '1'
        ? type1(streamSnapshot, index)
        : streamSnapshot.data![index].type.toString() == '2'
            ? type2(streamSnapshot, index)
            : type3(streamSnapshot, index);
  }

  List<String> valuessss = [];
  Widget type3(AsyncSnapshot<List<GetCategorySpec>> streamSnapshot, int index) {
    List<String> values = [];
    List<int> ids = [];
    streamSnapshot.data![index].values!.forEach(
      (element) {
        values.add(element.name!);
        ids.add(element.id!);
      },
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  streamSnapshot.data![index].name!,
                  style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                ),
                Text(
                  streamSnapshot.data![index].isRequired == true ? '*' : '',
                  style: TextStyle(color: Colors.red, fontFamily: gilroyMedium, fontSize: 18),
                ),
              ],
            ),
          ),
          streamSnapshot.data![index].isMultiple!
              ? ChipsChoice<String>.multiple(
                  value: valuessss,
                  onChanged: (val) => setState(() {
                    List idsForAdd = [];
                    for (int i = 0; i < val.length; i++) {
                      streamSnapshot.data![index].values!.forEach((element) {
                        if (val[i] == element.name) {
                          idsForAdd.add(element.id);
                        }
                      });
                    }
                    valuessss = val;
                    _namesList[index] = val;
                    homeController.selectedList.forEach((element) {
                      if (element['id'] == streamSnapshot.data![index].id) {
                        element['values'] = idsForAdd;
                      }
                    });
                  }),
                  choiceItems: C2Choice.listFrom<String, String>(
                    source: values,
                    value: (i, v) => v,
                    label: (i, v) => v,
                  ),
                  choiceBuilder: (item, i) {
                    return CustomChip(
                      label: item.label,
                      selected: item.selected,
                      onSelect: item.select!,
                    );
                  },
                  choiceCheckmark: true,
                  scrollPhysics: BouncingScrollPhysics(),
                )
              : ChipsChoice<int>.single(
                  value: _selectedIndexList[index],
                  onChanged: (val) => setState(() {
                    _selectedIndexList[index] = val;
                    homeController.selectedList.forEach((element) {
                      if (element['id'] == streamSnapshot.data![index].id) {
                        element['values'] = [ids[int.parse(val.toString())]];
                      }
                    });
                  }),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: values,
                    value: (i, v) => i,
                    label: (i, v) => v,
                    tooltip: (i, v) => v,
                  ),
                  choiceBuilder: (item, i) {
                    return CustomChip(
                      label: item.label,
                      selected: item.selected,
                      onSelect: item.select!,
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget type2(AsyncSnapshot<List<GetCategorySpec>> streamSnapshot, int index) {
    return CheckboxListTile(
        contentPadding: EdgeInsets.only(bottom: 30),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              streamSnapshot.data![index].name!,
              style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
            ),
            Text(
              streamSnapshot.data![index].isRequired == true ? '*' : '',
              style: TextStyle(color: Colors.red, fontFamily: gilroyMedium, fontSize: 18),
            ),
          ],
        ),
        value: _checboxList[index],
        focusNode: _focusNodeList[index],
        onChanged: (bool? value) {
          setState(() {
            _checboxList[index] = value!;
          });
        });
  }

  Widget type1(AsyncSnapshot<List<GetCategorySpec>> streamSnapshot, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                streamSnapshot.data![index].name!,
                style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
              ),
              Text(
                streamSnapshot.data![index].isRequired == true ? '*' : '',
                style: TextStyle(color: Colors.red, fontFamily: gilroyMedium, fontSize: 18),
              ),
            ],
          ),
          CustomTextField(
              validate: streamSnapshot.data![index].isRequired,
              labelName: '',
              borderRadius: true,
              controller: _controllersList[index],
              focusNode: _focusNodeList[index],
              requestfocusNode: _focusNodeList[index + 1],
              isNumber: streamSnapshot.data![index].onlyNumber!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetCategorySpec>>(
        future: future,
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: spinKit());
          } else if (streamSnapshot.hasError) {
            return errorPage();
          } else if (streamSnapshot.data!.isEmpty) {
            return emptyPage();
          }
          fillSelectedListWithData(streamSnapshot);
          print(homeController.selectedList);

          return ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: streamSnapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return widgets(streamSnapshot, index);
                },
              ),
              Obx(() => GestureDetector(
                    onTap: () {
                      for (int i = 0; i < streamSnapshot.data!.length; i++) {
                        homeController.selectedList[i]['value'] = streamSnapshot.data![i].type.toString() == '1' ? _controllersList[i].text : _checboxList[i];
                        if (homeController.selectedList[i]['value'].toString() == '') homeController.selectedList[i]['value'] = false;
                      }
                      print(homeController.selectedList);

                      List notfilled = [];
                      bool value = false;
                      homeController.selectedList.forEach((element) {
                        if (element['is_required'] == true && element['value'] == '' || element['is_required'] == true && element['values'].toString() == '[]' && element['value'] == false) {
                          value = true;
                          streamSnapshot.data!.forEach((element2) {
                            if (element['id'] == element2.id) {
                              notfilled.add(element2.name);
                            }
                          });
                        }
                      });

                      if (!value) {
                        homeController.incrementPageIndex();
                      } else {
                        print(notfilled);
                        showSnackBar('noConnection3', 'fillEmpty'.tr + '\n${notfilled.toString().substring(1, notfilled.toString().length - 1)}', Colors.red);
                      }
                    },
                    child: AnimatedContainer(
                      decoration: const BoxDecoration(
                        borderRadius: borderRadius20,
                        color: kPrimaryColor,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      width: Get.size.width,
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        homeController.selectedList.isNotEmpty ? 'agree'.tr : 'agree'.tr,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 20),
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  void fillSelectedListWithData(AsyncSnapshot<List<GetCategorySpec>> streamSnapshot) {
    if (_focusNodeList.length < streamSnapshot.data!.length) {
      _focusNodeList.add(FocusNode());
      if (homeController.selectedList.isEmpty) {
        for (int i = 0; i < streamSnapshot.data!.length; i++) {
          homeController.selectedList.add({
            'id': streamSnapshot.data![i].id,
            'type': streamSnapshot.data![i].type,
            'is_multiple': streamSnapshot.data![i].isMultiple,
            'is_required': streamSnapshot.data![i].isRequired,
            'only_number': streamSnapshot.data![i].onlyNumber,
            'value': "",
            "values": []
          });
        }
      }
    }
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 8),
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
        color: selected ? kPrimaryColor : theme.unselectedWidgetColor.withOpacity(.12),
        borderRadius: borderRadius10,
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        onTap: () => onSelect(!selected),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: selected ? gilroyBold : gilroyRegular,
            fontSize: selected ? 16 : 16,
            color: selected ? Colors.white : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
