// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/petscreen_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';

class PetProfileScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  PetScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Obx(()=> SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: colors.primaryColor,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/pawsss.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colors.primaryColor.withOpacity(0.25),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: colors.whiteColor,
                          )),
                      GestureDetector(
                        onTap: (){
                          controller.currentPetInfo!.value.favorite = ! controller.currentPetInfo!.value.favorite!;
                          controller.Favourite(controller.currentPetInfo!.value.id!, controller.currentPetInfo!.value.favorite!);
                        },
                        child: Image.asset(
                          'assets/images/fav.png',
                          color: controller.currentPetInfo!.value.favorite == true?
                               colors.secondaryColor
                              : colors.whiteColor,
                          height: responsive.setHeight(5),
                          width: responsive.setWidth(10),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: (){
                      Get.bottomSheet(
                        ImagePreview(
                          thumbnail: controller.currentPetInfo!.value.productGallery![0].thumbnail,
                          network: APIEndpoints.baseURL +controller.currentPetInfo!.value.productGallery![0].path!,
                          // asset: (mapControler.currentPinInfo!.value.gallery == null&& mapControler.currentPinInfo!.value.gallery!.isEmpty)?ImagePath.noImageFound: null,
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: Container(
                      height: responsive.setHeight(35),
                      width: responsive.setWidth(50),
                      child: (controller.currentPetInfo!.value.productGallery!=null&&controller.currentPetInfo!.value.productGallery!.length!=0)?controller.currentPetInfo!.value.productGallery![0].thumbnail != null?FadeInImage(
                        fit: BoxFit.cover,
                        width: responsive.setWidth(100),
                        image: FileImage(controller.currentPetInfo!.value.productGallery![0].thumbnail!,), placeholder: AssetImage(ImagePath.loaderGifImage),
                      ) :FadeInImage(
                        fit: BoxFit.cover,
                        width: responsive.setWidth(100),
                        image: NetworkImage(APIEndpoints.baseURL +controller.currentPetInfo!.value.productGallery![0].path!,), placeholder: AssetImage(ImagePath.loaderGifImage),
                      ):FadeInImage(
                        fit: BoxFit.contain,
                        width: responsive.setWidth(100),
                        image: AssetImage(ImagePath.noImageFound,), placeholder: AssetImage(ImagePath.loaderGifImage),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: responsive.setHeight(30),
                  child: GlassmorphicContainer(
                     height: responsive.setHeight(70),
                    width: responsive.setWidth(100),
                    borderRadius: 30,
                    blur: 20,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.1),
                          Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.0),
                        Color((0xFFFFFFFF)).withOpacity(0.0),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: responsive.setHeight(2)),
                          child: MyText(
                            title: controller.currentPetInfo!.value.name!,
                            size: responsive.setTextScale(30),
                            weight: 'Bold',
                            clr: colors.whiteColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                child: Container(

                                  width: responsive.setWidth(26),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: responsive.setHeight(1.5),
                                      ),
                                      Image.asset('assets/icons/arrowTop.png'),
                                      SizedBox(
                                        height: responsive.setHeight(0.5),
                                      ),
                                      MyText(
                                        title: '${controller.currentPetInfo!.value.age!} Years',
                                        weight: 'Bold',
                                        size: 16,
                                      ),
                                      MyText(
                                        title: 'Age',
                                        clr: colors.hintColor,
                                      ),
                                      SizedBox(
                                        height: responsive.setHeight(1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(

                                  width: responsive.setWidth(26),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: responsive.setHeight(1.5),
                                      ),
                                      Image.asset('assets/icons/arrowWeight.png'),
                                      SizedBox(
                                        height: responsive.setHeight(0.5),
                                      ),
                                      MyText(
                                        title: '${controller.currentPetInfo!.value.weight!} Kg',
                                        weight: 'Bold',
                                        size: 16,
                                      ),
                                      MyText(
                                        title: 'Weight',
                                        clr: colors.hintColor,
                                      ),
                                      SizedBox(
                                        height: responsive.setHeight(1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(

                                  width: responsive.setWidth(26),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: responsive.setHeight(1.5),
                                      ),
                                      Image.asset('assets/icons/gender.png'),
                                      SizedBox(
                                        height: responsive.setHeight(0.5),
                                      ),
                                      MyText(
                                        // title: controller.currentPetInfo!.value.gender !=null?'${controller.currentPetInfo!.value.gender}':"-",
                                        title: ''
                                            '${controller.currentPetInfo!.value.gender}',
                                        weight: 'Bold',
                                        size: 16,
                                      ),
                                      MyText(
                                        title: 'Sex',
                                        clr: colors.hintColor,
                                      ),
                                      SizedBox(
                                        height: responsive.setHeight(1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive.setHeight(5),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Card(
                                            elevation: 5,
                                            child: Container(
                                                height: responsive.setHeight(9),
                                                width: responsive.setHeight(9),
                                                decoration: BoxDecoration(
                                                    color: colors.primaryColor),
                                                child: Image.asset(
                                                  'assets/icons/colors.png',
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                title: 'Color',
                                                size: 15,
                                                clr: colors.whiteColor,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  MyText(
                                                    title: '${controller.currentPetInfo!.value.color!}',
                                                    clr: colors.whiteColor,
                                                    size: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  // Container(
                                                  //   height:
                                                  //       responsive.setHeight(1.2),
                                                  //   width:
                                                  //       responsive.setHeight(1.2),
                                                  //   decoration: BoxDecoration(
                                                  //       color: colors.whiteColor,
                                                  //       borderRadius:
                                                  //           BorderRadius.circular(
                                                  //               50)),
                                                  // )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              // Row(
                                              //   children: [
                                              //     MyText(
                                              //       title: 'Brown',
                                              //       clr: colors.whiteColor,
                                              //       size: 10,
                                              //     ),
                                              //     SizedBox(
                                              //       width: 5,
                                              //     ),
                                              //     Container(
                                              //       height:
                                              //           responsive.setHeight(1.2),
                                              //       width:
                                              //           responsive.setHeight(1.2),
                                              //       decoration: BoxDecoration(
                                              //           color: Colors.brown,
                                              //           borderRadius:
                                              //               BorderRadius.circular(
                                              //                   50)),
                                              //     )
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(3),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Card(
                                            elevation: 5,
                                            child: Container(
                                                height: responsive.setHeight(9),
                                                width: responsive.setHeight(9),
                                                decoration: BoxDecoration(
                                                    color: colors.primaryColor),
                                                child: Image.asset(
                                                  'assets/icons/breed.png',
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                title: 'Breed',
                                                size: 15,
                                                clr: colors.whiteColor,
                                              ),
                                              controller.currentPetInfo!.value.breed== null? MyText(
                                                title:
                                                "N/A",
                                                size: 10,
                                                clr: colors.whiteColor,
                                                line: 5,
                                              ):
                                              SizedBox(
                                                child: Wrap(
                                                  alignment: WrapAlignment.start,
                                                  direction: Axis.horizontal,
                                                  children: List.generate(
                                                      controller.currentPetInfo!.value.breed!.length,
                                                          (index) => MyText(
                                                        title:
                                                        "${controller.currentPetInfo!.value.breed![index].name} ",
                                                        size: 10,
                                                        clr: colors.whiteColor,
                                                        line: 5,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Card(
                                            elevation: 5,
                                            child: Container(
                                                height: responsive.setHeight(9),
                                                width: responsive.setHeight(9),
                                                decoration: BoxDecoration(
                                                    color: colors.primaryColor),
                                                child: Image.asset(
                                                  'assets/icons/traits.png',
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                title: 'Characterstics',
                                                size: 15,
                                                clr: colors.whiteColor,
                                              ),
                                              controller.currentPetInfo!.value
                                                  .characteristics == null? MyText(
                                                title:
                                                "N/A",
                                                size: 10,
                                                clr: colors.whiteColor,
                                                line: 5,
                                              ):
                                              SizedBox(
                                                child: Wrap(
                                                  alignment: WrapAlignment.start,
                                                  direction: Axis.horizontal,
                                                  children: List.generate(
                                                      controller.currentPetInfo!.value
                                                          .characteristics!.length,
                                                          (index) => MyText(
                                                        title:
                                                        "${controller.currentPetInfo!.value.characteristics![index].name} ",
                                                        size: 10,
                                                        clr: colors.whiteColor,
                                                        line: 5,
                                                      )),
                                                ),
                                              ),


                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: responsive.setHeight(3),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Card(
                                            elevation: 5,
                                            child: Container(
                                                height: responsive.setHeight(9),
                                                width: responsive.setHeight(9),
                                                decoration: BoxDecoration(
                                                    color: colors.primaryColor),
                                                child: Image.asset(
                                                  'assets/icons/about.png',
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                title: 'About Pet',
                                                size: 15,
                                                clr: colors.whiteColor,
                                              ),
                                              MyText(
                                                title:
                                                '${controller.currentPetInfo!.value.description}',
                                                size: 10,
                                                clr: colors.whiteColor,
                                                line: 5,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive.setHeight(5),
                        ),
                        MyElevatedButton(
                          onTap: () {
                            // controller.adoptPet();
                            Get.toNamed('/setupMeeting');
                          },
                          width: responsive.setWidth(55),
                          title: 'Adopt Now',
                          isImage: true,
                          textColor: colors.primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
