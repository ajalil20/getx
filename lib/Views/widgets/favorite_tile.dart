import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_tag_selection.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/finderhome_controller.dart';
import 'package:pawndr/Controller/petscreen_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/Pets/PetsScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/PetDetailScreen.dart';

class FavoriteTile extends StatelessWidget {
  int index;
  Rx<Pet>? pet = Pet().obs;
  int width, height;

  FavoriteTile(
      {required this.index,
      required this.pet,
      this.width = 35,
      this.height = 14});

  PetScreenController controller = Get.put(PetScreenController());

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.currentPetInfo!.value = pet!.value;
          Get.bottomSheet(
            PetDetailscreen(),
            isScrollControlled: true,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Container(
              width: responsive.setWidth(100),
              height: responsive.setHeight(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: responsive.setHeight(20),
                      width: responsive.setWidth(30),
                      decoration: BoxDecoration(
                          color: colors.textColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: responsive.setWidth(30),
                        decoration: BoxDecoration(
                          // color: colors.hintColor,
                            image: pet!.value.productGallery != null &&
                                pet!.value.productGallery!.isNotEmpty
                                ? pet!.value.productGallery!.last.thumbnail != null
                                ? DecorationImage(
                                image: FileImage(
                                    pet!.value.productGallery!.last.thumbnail!),
                                fit: BoxFit.cover)
                                : DecorationImage(
                                image: NetworkImage(APIEndpoints.baseURL +
                                    pet!.value.productGallery!.last.path!),
                                fit: BoxFit.cover)
                                : pet!.value.productGallery==null
                                ? DecorationImage(
                                image: AssetImage(ImagePath.noImageFound),
                                fit: BoxFit.contain):pet!.value.productGallery!.isEmpty
                                ? DecorationImage(

                                image: AssetImage(ImagePath.noImageFound),
                                fit: BoxFit.contain)
                                : DecorationImage(
                                image: NetworkImage(APIEndpoints.baseURL +
                                    pet!.value.productGallery!.last.path!)),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                 Expanded(
                   child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: responsive.setWidth(30),
                                    child: MyText(
                                      title: '${pet!.value.name}',
                                      clr: colors.primaryColor,
                                      weight: 'Semi Bold',
                                      size: responsive.setTextScale(19),
                                      line: 1,
                                      toverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    height: responsive.setHeight(1),
                                    // color: colors.primaryColor,

                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                            // height: responsive.setHeight(12),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                MyText(
                                                  title: 'Age',
                                                  clr: colors.hintColor,
                                                ),
                                                MyText(
                                                  title: 'Weight',
                                                  clr: colors.hintColor,
                                                ),
                                                MyText(
                                                  title: 'Breed',
                                                  clr: colors.hintColor,
                                                ),
                                                MyText(
                                                  title: 'Color',
                                                  clr: colors.hintColor,
                                                )
                                              ],
                                            ),
                                          )),
                                      Container(
                                        // height: responsive.setHeight(12),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                              title: ':  ',
                                              clr: colors.hintColor,
                                            ),
                                            MyText(
                                              title: ':  ',
                                              clr: colors.hintColor,
                                            ),
                                            MyText(
                                              title: ':  ',
                                              clr: colors.hintColor,
                                            ),
                                            MyText(
                                              title: ':  ',
                                              clr: colors.hintColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            // height: responsive.setHeight(12),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                MyText(
                                                  title: '${pet!.value.age} Years',
                                                  toverflow: TextOverflow.ellipsis,
                                                  line: 1,
                                                  clr: colors.primaryColor,
                                                ),
                                                MyText(
                                                  title: '${pet!.value.weight}',
                                                  toverflow: TextOverflow.ellipsis,
                                                  line: 1,
                                                  clr: colors.primaryColor,
                                                ),
                                                // pet!.value.breed==null?Container():
                                                SizedBox(
                                                  child: Wrap(
                                                    alignment: WrapAlignment.start,
                                                    direction: Axis.horizontal,
                                                    children: List.generate(
                                                        pet!.value.breed!.length,
                                                            (index) => MyText(
                                                          title:
                                                          " ${pet!.value.breed![index].name} ",
                                                          // size: 10,
                                                          clr: colors.primaryColor,
                                                          line: 1,
                                                        )),
                                                  ),
                                                ),
                                                // MyText(
                                                //   title: '${pet!.value.color}',sd
                                                //   toverflow: TextOverflow.ellipsis,
                                                //   line: 1,
                                                //   clr: colors.primaryColor,
                                                // ),
                                                MyText(
                                                  title: '${pet!.value.color}',
                                                  toverflow: TextOverflow.ellipsis,
                                                  line: 1,
                                                  clr: colors.primaryColor,
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      title: 'Pick up',
                                      width: responsive.setWidth(22),
                                      fontSize: responsive.setTextScale(12),
                                      height: responsive.setHeight(3.5),
                                      radius: 15,
                                      bgColor: colors.secondaryColor,
                                      weight: 'Bold',
                                    ),
                                    SizedBox(height: responsive.setHeight(2),),
                                    GestureDetector(
                                        onTap: () {
                                          pet!.value.favorite != pet!.value.favorite!;
                                          print(pet!.value.favorite);
                                          print(pet!.value.id);
                                          controller.Favourite(pet!.value.id!, pet!.value.favorite!);

                                        },
                                        child: Icon(
                                          pet!.value.favorite==true? Icons.favorite_border_outlined:Icons.favorite,
                                          color: colors.secondaryColor,size: responsive.setWidth(8),)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                 ),
                ],
              ),
            ),
          ),
        ),
        // child: Padding(
        //     padding: EdgeInsets.only(left: responsive.setWidth(4),right: responsive.setWidth(4),top: responsive.setHeight(1)),
        //     child: Stack(
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.only(top: 9.0),
        //           child: Card(
        //             elevation: 5,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //             child: Container(
        //               width: responsive.setWidth(100),
        //               decoration: BoxDecoration(
        //                   color: colors.whiteColor,
        //                   borderRadius: BorderRadius.circular(10)),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Row(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Container(
        //                         // height: responsive.setHeight(18),
        //                         width: responsive.setWidth(32),
        //                       ),
        //                       Expanded(
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.start,
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Container(
        //                               width: responsive.setWidth(30),
        //                               child: MyText(
        //                                 title: '${pet!.value.name}',
        //                                 clr: colors.primaryColor,
        //                                 weight: 'Semi Bold',
        //                                 size: responsive.setTextScale(19),
        //                                 line: 1,
        //                                 toverflow: TextOverflow.ellipsis,
        //                               ),
        //                             ),
        //                             Container(
        //                               height: responsive.setHeight(1),
        //                               // color: colors.primaryColor,
        //
        //                             ),
        //                             // Container(
        //                             //   width: responsive.setWidth(30),
        //                             //   // color: colors.primaryColor,
        //                             //   child: MyText(
        //                             //     title: 'Golden Retriver',
        //                             //     size: responsive.setTextScale(15),
        //                             //     line: 1,
        //                             //     toverflow: TextOverflow.ellipsis,
        //                             //   ),
        //                             // ),
        //                             Row(
        //                               children: [
        //                                 Expanded(
        //                                     child: Container(
        //                                       // height: responsive.setHeight(12),
        //                                       child: Column(
        //                                         mainAxisAlignment:
        //                                         MainAxisAlignment.spaceAround,
        //                                         crossAxisAlignment:
        //                                         CrossAxisAlignment.start,
        //                                         children: [
        //                                           MyText(
        //                                             title: 'Age',
        //                                             clr: colors.hintColor,
        //                                           ),
        //                                           MyText(
        //                                             title: 'Weight',
        //                                             clr: colors.hintColor,
        //                                           ),
        //                                           MyText(
        //                                             title: 'Breed',
        //                                             clr: colors.hintColor,
        //                                           ),
        //                                           MyText(
        //                                             title: 'Color',
        //                                             clr: colors.hintColor,
        //                                           )
        //                                         ],
        //                                       ),
        //                                     )),
        //                                 Container(
        //                                   // height: responsive.setHeight(12),
        //                                   child: Column(
        //                                     mainAxisAlignment:
        //                                     MainAxisAlignment.spaceAround,
        //                                     crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                     children: [
        //                                       MyText(
        //                                         title: ': ',
        //                                         clr: colors.hintColor,
        //                                       ),
        //                                       MyText(
        //                                         title: ': ',
        //                                         clr: colors.hintColor,
        //                                       ),
        //                                       MyText(
        //                                         title: ': ',
        //                                         clr: colors.hintColor,
        //                                       ),
        //                                       MyText(
        //                                         title: ': ',
        //                                         clr: colors.hintColor,
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ),
        //                                 Expanded(
        //                                     child: Container(
        //                                       // height: responsive.setHeight(12),
        //                                       child: Column(
        //                                         mainAxisAlignment:
        //                                         MainAxisAlignment.spaceAround,
        //                                         crossAxisAlignment:
        //                                         CrossAxisAlignment.start,
        //                                         children: [
        //                                           MyText(
        //                                             title: '${pet!.value.age} Years',
        //                                             toverflow: TextOverflow.ellipsis,
        //                                             line: 1,
        //                                             clr: colors.primaryColor,
        //                                           ),
        //                                           MyText(
        //                                             title: '${pet!.value.weight} Kg',
        //                                             toverflow: TextOverflow.ellipsis,
        //                                             line: 1,
        //                                             clr: colors.primaryColor,
        //                                           ),
        //                                           // pet!.value.breed==null?Container():
        //                                           SizedBox(
        //                                             child: Wrap(
        //                                               alignment: WrapAlignment.start,
        //                                               direction: Axis.horizontal,
        //                                               children: List.generate(
        //                                                   pet!.value.breed!.length,
        //                                                       (index) => MyText(
        //                                                     title:
        //                                                     " ${pet!.value.breed![index].name} ",
        //                                                     // size: 10,
        //                                                     clr: colors.primaryColor,
        //                                                     line: 1,
        //                                                   )),
        //                                             ),
        //                                           ),
        //                                           // MyText(
        //                                           //   title: '${pet!.value.color}',sd
        //                                           //   toverflow: TextOverflow.ellipsis,
        //                                           //   line: 1,
        //                                           //   clr: colors.primaryColor,
        //                                           // ),
        //                                           MyText(
        //                                             title: '${pet!.value.color}',
        //                                             toverflow: TextOverflow.ellipsis,
        //                                             line: 1,
        //                                             clr: colors.primaryColor,
        //                                           )
        //                                         ],
        //                                       ),
        //                                     )),
        //                               ],
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                       Expanded(
        //                         child: Container(
        //                           height: responsive.setHeight(18),
        //                           child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             crossAxisAlignment: CrossAxisAlignment.center,
        //                             children: [
        //                               MyButton(
        //                                 title: 'Pick up',
        //                                 width: responsive.setWidth(25),
        //                                 fontSize: responsive.setTextScale(12),
        //                                 height: responsive.setHeight(4),
        //                                 radius: 15,
        //                                 bgColor: colors.secondaryColor,
        //                                 weight: 'Bold',
        //                               ),
        //                               SizedBox(height: responsive.setHeight(2),),
        //                               GestureDetector(
        //                                   onTap: () async {
        //                                     pet!.value.favorite =! pet!.value.favorite!;
        //                                     await controller.Favourite(pet!.value.id!, pet!.value.favorite!);
        //                                   },
        //                                   child: Icon(
        //                                     pet!.value.favorite==true? Icons.favorite_border_outlined:Icons.favorite,
        //                                     color: colors.secondaryColor,size: responsive.setWidth(10),)),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //         Card(
        //           elevation: 5,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10)),
        //           child: Container(
        //             height: responsive.setHeight(20),
        //             width: responsive.setWidth(30),
        //             decoration: BoxDecoration(
        //                 // color: colors.hintColor,
        //                 image: pet!.value.productGallery != null &&
        //                     pet!.value.productGallery!.isNotEmpty
        //                     ? pet!.value.productGallery!.last.thumbnail != null
        //                     ? DecorationImage(
        //                     image: FileImage(
        //                         pet!.value.productGallery!.last.thumbnail!),
        //                     fit: BoxFit.cover)
        //                     : DecorationImage(
        //                     image: NetworkImage(APIEndpoints.baseURL +
        //                         pet!.value.productGallery!.last.path!),
        //                     fit: BoxFit.cover)
        //                     : pet!.value.productGallery==null
        //                     ? DecorationImage(
        //                     image: AssetImage(ImagePath.noImageFound),
        //                     fit: BoxFit.contain):pet!.value.productGallery!.isEmpty
        //                     ? DecorationImage(
        //
        //                     image: AssetImage(ImagePath.noImageFound),
        //                     fit: BoxFit.contain)
        //                     : DecorationImage(
        //                     image: NetworkImage(APIEndpoints.baseURL +
        //                         pet!.value.productGallery!.last.path!)),
        //                 borderRadius: BorderRadius.circular(10)),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
      ),
    );
  }
}
