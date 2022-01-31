import 'dart:ui';

import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_tag_selection.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/HomeController.dart';
import 'package:pawndr/Controller/custom_slider.dart';
import 'package:pawndr/Controller/profilesetting_controller.dart';
import 'package:pawndr/Modals/tags_model.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class FilterBottomSheetContent extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());
  ProfileSettingController controller = Get.put(ProfileSettingController());
  ColorConfig colors = ColorConfig();
  Responsive respons = Responsive();

  @override
  Widget build(BuildContext context) {
    respons.setContext(context);
    return Obx(
      () => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          height: respons.setHeight(80),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.bottomSheet.withOpacity(0.9),
                    colors.bottomSheet.withOpacity(0.6),
                  ])
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: respons.setHeight(2),left: respons.setWidth(5),right: respons.setWidth(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        size: respons.setTextScale(24),
                        color: colors.textColor,
                      ),
                    ),
                    MyText(
                      title: "Filter Your Pet",
                      size: respons.setTextScale(18),
                      clr: colors.textColor,
                      weight: "Bold",
                    ),
                    InkWell(
                      onTap: () {
                        _homeController.isFilter.value = false;
                        _homeController.resetFilter();
                      },
                      child: MyText(
                        title: "Reset",
                        size: respons.setTextScale(16),
                        clr: colors.textColor,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          title: "Location",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        ),
                        SizedBox(
                          width: respons.setWidth(25),
                        ),
                        InkWell(
                          onTap: (){
                            print("tapped");
                            // Get.toNamed('/LocationPicker');
                            controller.determinePosition(context);
                          },
                          child: Row(
                              children: [
                                Container(
                                  width: respons.setWidth(35),
                                  child: MyText(
                                    title: _homeController.controller.user.value.result!.locationName!,
                                    toverflow: TextOverflow.ellipsis,
                                    clr: colors.darkYellow,
                                    size: respons.setTextScale(14),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: respons.setTextScale(15),
                                  color: colors.textColor,
                                ),
                              ],
                            ),

                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          title: "Distance",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        ),
                        MyText(
                          title: "${_homeController.distance.value.floor()} m",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        )
                      ],
                    ),
                  ),
                  CustomSlider(
                    showLabel: false,
                    maxValue: 300,
                    minValue: 1,
                    enableToolTip: true,
                    showTick: false,
                    stepSize: 1,
                    singleValue: _homeController.distance.value,
                    singleReturnValue: (val) {
                      _homeController.distance.value = val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(2), right: respons.setWidth(2), top: respons.setHeight(2)),
                    child: SmartSelect.single(
                      title: 'Pets',
                      selectedValue: _homeController.markedPet.value,
                      onChange: (selected) {
                        // return  selected?.value;
                        _homeController.markedPet.value=selected.value as String;
                        _homeController.markedBreedList=List<Tags>.empty().obs;
                        _homeController.getBreeds();
                      },
                      choiceItems: S2Choice.listFrom<String, Tags>(
                        source: _homeController.petsList.value,
                        value: (index, item) => item.id ?? '',
                        title: (index, item) => item.name ?? '',
                      ),
                      choiceType: S2ChoiceType.chips,
                      modalFilter: true,
                      modalType: S2ModalType.popupDialog,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          isTwoLine: false,
                          title: MyText(title: "Pets",size: respons.setTextScale(16),
                            clr: colors.textColor,),
                          trailing: Icon(  Icons.arrow_forward_ios_rounded,
                            size: respons.setTextScale(15),
                            color: colors.textColor,),

                          // leading: const CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     'https://source.unsplash.com/yeVtxxPxzbw/100x100',
                          //   ),
                          // ),
                        );
                      },



                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(2), right: respons.setWidth(2), top: respons.setHeight(0)),
                    child: Obx(()=> SmartSelect.multiple(
                        title: 'Breeds',
                        selectedValue: _homeController.markedBreedList.value,
                        onChange: (selected) {
                          _homeController.markedBreedList=List<Tags>.empty().obs;
                          if(selected!.value!=null)
                          {
                            for(int i=0;i<selected.value!.length;i++)
                            {
                              _homeController.markedBreedList.add(Tags(
                                  name: "${selected.title![i]}",
                                  id: "${selected.value![i]}"));
                            }
                            print(_homeController.markedBreedList);
                          }
                        },
                        choiceItems: S2Choice.listFrom<String, Tags>(
                          source: _homeController.breedList.value,
                          value: (index, item) => item.id ?? '',
                          title: (index, item) => item.name ?? '',
                        ),
                        choiceType: S2ChoiceType.chips,
                        modalFilter: true,
                        modalTitle: "",
                        modalType: S2ModalType.popupDialog,
                        tileBuilder: (context, state) {
                          return S2Tile.fromState(
                            state,
                            isTwoLine: false,
                            value: Text(""),
                            title: MyText(title: "Breeds",size: respons.setTextScale(16),
                              clr: colors.textColor,),
                            trailing: Icon(  Icons.arrow_forward_ios_rounded,
                              size: respons.setTextScale(15),
                              color: colors.textColor,),
                            body: S2TileChips(
                              chipLength: _homeController.markedBreedList.length,
                              chipLabelBuilder: (context, i) {
                                return Text(_homeController.markedBreedList[i].name!,);
                              },
                              chipOnDelete: (i) {
                                _homeController.markedBreedList.remove([i]);
                              },
                              chipDeleteIcon: Icon(Icons.check_circle_outline,size: respons.setTextScale(14),),
                              chipColor: colors.whiteColor,
                            ),
                          );
                        },

                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                  //   child: InkWell(
                  //     onTap: (){
                  //       _homeController.currentTags.value=_homeController.petsList;
                  //       print("tappped");
                  //       Get.toNamed('/FilterTags');
                  //     },
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //       MyText(
                  //             title: "Pets",
                  //             size: respons.setTextScale(16),
                  //             clr: colors.textColor,
                  //             center: false,
                  //           ),
                  //         Icon(
                  //           Icons.add,
                  //           size: respons.setTextScale(22),
                  //           color: colors.whiteColor,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(1)),
                  //   child: Obx(() {
                  //     return _homeController.petsList.isEmpty?Container(): Wrap(
                  //       alignment: WrapAlignment.start,
                  //       direction: Axis.horizontal,
                  //       children: List.generate(
                  //           // _homeController.petsList.length>6?5:
                  //           _homeController.petsList.length,
                  //           (index) => CustomTagSelect(
                  //                 event: _homeController.petsList[index],
                  //                 type: 1,
                  //               )),
                  //     );
                  //   }),
                  // ),
                  // _homeController.breedList.isEmpty?Container():  Padding(
                  //   padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                  //   child: MyText(
                  //     title: "Directed Tags",
                  //     size: respons.setTextScale(16),
                  //     clr: colors.textColor,
                  //     center: false,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(1)),
                  //   child: Obx(() {
                  //     return  _homeController.breedList.isEmpty?Container():Wrap(
                  //       alignment: WrapAlignment.start,
                  //       direction: Axis.horizontal,
                  //       children:List.generate(
                  //           // _homeController.breedList.length>6?5:
                  //           _homeController.breedList.length,
                  //           (index) => CustomTagSelect(
                  //                 event: _homeController.breedList[index],
                  //                 type: 2,
                  //               ))
                  //     );
                  //   }),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(2), right: respons.setWidth(2), top: respons.setHeight(0)),
                    child: SmartSelect.multiple(
                      title: 'Breeds',
                      // selectedValue: _homeController.petsList.value,
                      onChange: (selected) {
                        _homeController.markedCharList=List<Tags>.empty().obs;
                        if(selected!.value!=null)
                        {
                        for(int i=0;i<selected.value!.length;i++)
                        {
                          _homeController.markedCharList.add(Tags(
                              name: "${selected.title![i]}",
                              id: "${selected.value![i]}"));
                        }
                        print(_homeController.markedCharList);
                        }
                      },
                      choiceItems: S2Choice.listFrom<String, Tags>(
                        source: _homeController.charList.value,
                        value: (index, item) => item.id ?? '',
                        title: (index, item) => item.name ?? '',
                      ),
                      choiceType: S2ChoiceType.chips,
                      modalFilter: true,
                      modalTitle: "",
                      modalType: S2ModalType.popupDialog,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          isTwoLine: false,
                          value: Text(""),
                          title: MyText(title: "Characterstics",size: respons.setTextScale(16),
                            clr: colors.textColor,),
                          trailing: Icon(  Icons.arrow_forward_ios_rounded,
                            size: respons.setTextScale(15),
                            color: colors.textColor,),
                          body: S2TileChips(
                            chipLength: _homeController.markedCharList.length,
                            chipLabelBuilder: (context, i) {
                              return Text(_homeController.markedCharList[i].name!,);
                            },
                            chipOnDelete: (i) {
                              _homeController.markedCharList.remove([i]);
                            },
                            chipDeleteIcon: Icon(Icons.check_circle_outline,size: respons.setTextScale(14),),
                            chipColor: colors.whiteColor,
                          ),
                        );
                      },

                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                  //   child: MyText(
                  //     title: "Characteristics",
                  //     size: respons.setTextScale(16),
                  //     clr: colors.textColor,
                  //     center: false,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(1)),
                  //   child: Obx(() => _homeController.charList.isEmpty?Container(): Wrap(
                  //         alignment: WrapAlignment.start,
                  //         direction: Axis.horizontal,
                  //         children: List.generate(
                  //           // _homeController.charList.length>6?5:
                  //           _homeController.charList.length,
                  //           (index) => CustomTagSelect(
                  //             event: _homeController.charList[index],
                  //             type: 3,
                  //           ),
                  //         ),
                  //       )),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(2), right: respons.setWidth(2), top: respons.setHeight(0)),
                    child: SmartSelect.multiple(
                      title: 'Colors',
                      // selectedValue: _homeController.petsList.value,
                      onChange: (selected) {
                        _homeController.markedColorList=List<Tags>.empty().obs;
                        if(selected!.value!=null)
                        {
                        for(int i=0;i<selected.value!.length;i++)
                        {
                          _homeController.markedColorList.add(Tags(
                              name: "${selected.title![i]}",
                              id: "${selected.value![i]}"));
                        }
                        print(_homeController.markedColorList);
                        }
                      },
                      choiceItems: S2Choice.listFrom<String, Tags>(
                        source: _homeController.colorList.value,
                        value: (index, item) => item.id ?? '',
                        title: (index, item) => item.name ?? '',
                      ),
                      choiceType: S2ChoiceType.chips,
                      modalFilter: true,
                      modalTitle: "",
                      modalType: S2ModalType.popupDialog,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          isTwoLine: false,
                          value: Text(""),
                          title: MyText(title: "Colors",size: respons.setTextScale(16),
                            clr: colors.textColor,),
                          trailing: Icon(  Icons.arrow_forward_ios_rounded,
                            size: respons.setTextScale(15),
                            color: colors.textColor,),
                          body: S2TileChips(
                            chipLength: _homeController.markedColorList.length,
                            chipLabelBuilder: (context, i) {
                              return Text(_homeController.markedColorList[i].name!,);
                            },
                            chipOnDelete: (i) {
                              _homeController.markedColorList.remove([i]);
                            },
                            chipDeleteIcon: Icon(Icons.check_circle_outline,size: respons.setTextScale(14),),
                            chipColor: colors.whiteColor,
                          ),
                        );
                      },

                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                  //   child: MyText(
                  //     title: "Colors",
                  //     size: respons.setTextScale(16),
                  //     clr: colors.textColor,
                  //     center: false,
                  //   ),
                  // ),
                  // Padding(                  padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(1)),
                  //
                  //   child: Obx(() => _homeController.colorList.isEmpty?Container():Wrap(
                  //         alignment: WrapAlignment.start,
                  //         direction: Axis.horizontal,
                  //         children: List.generate(
                  //           // _homeController.colorList.length>6?5:
                  //           _homeController.colorList.length,
                  //           (index) => CustomTagSelect(
                  //             event: _homeController.colorList[index],
                  //             type: 4,
                  //           ),
                  //         ),
                  //       )),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          title: "Age",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        ),
                        MyText(
                          title: "${_homeController.ageRange.value.start.floor()} M - ${_homeController.ageRange.value.end.floor()} M",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        )
                      ],
                    ),
                  ),
                  CustomSlider(
                    showLabel: false,
                    maxValue: 300,
                    minValue: 1,
                    enableToolTip: true,
                    showTick: false,
                    stepSize: 1,
                    rangeSlider: true,
                    checkType: _homeController.ageRange.value,
                    returnValue: (val) {_homeController.ageRange.value = val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          title: "Height",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        ),
                        MyText(
                          title: "${_homeController.heightRange.value.start.floor()}m - ${_homeController.heightRange.value.end.floor()} m",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        )
                      ],
                    ),
                  ),
                  CustomSlider(
                    showLabel: false,
                    maxValue: 300,
                    minValue: 1,
                    enableToolTip: true,
                    showTick: false,
                    stepSize: 1,
                    rangeSlider: true,
                    checkType: _homeController.heightRange.value,
                    returnValue: (val) {
                      _homeController.heightRange.value = val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: respons.setWidth(5), right: respons.setWidth(5), top: respons.setHeight(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          title: "Weight",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        ),
                        MyText(
                          title: "${_homeController.weightRange.value.start.floor()} lb - ${_homeController.weightRange.value.end.floor()} lb",
                          size: respons.setTextScale(16),
                          clr: colors.textColor,
                        )
                      ],
                    ),
                  ),

                  CustomSlider(
                    showLabel: false,
                    maxValue: 300,
                    minValue: 1,
                    enableToolTip: true,
                    showTick: false,
                    stepSize: 1,
                    rangeSlider: true,
                    checkType: _homeController.weightRange.value,
                    returnValue: (val) {
                      _homeController.weightRange.value = val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: respons.setWidth(10),
                        right: respons.setWidth(10),
                        top: 20,
                        bottom: 20),
                    child: Center(
                      child: MyButton(
                        title: "Search a Friend",
                        bgColor: colors.primaryColor,
                        height: respons.setHeight(6),
                        fontSize: respons.setTextScale(15),
                        weight: "Bold",
                        radius: 10,
                        onTap: () {
                          _homeController.getFilterPetsData();
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
