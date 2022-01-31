// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_elevated_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_multitext.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/petscreen_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';

class PetDetailscreen extends StatelessWidget {

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  UserController controller = Get.put(UserController());
  PetScreenController petController = Get.put(PetScreenController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      // height: responsive.setHeight(82),
      decoration: BoxDecoration(
        color: petController.currentPetInfo!.value.productGallery != null ? petController.currentPetInfo!.value.productGallery!.isNotEmpty?Colors.transparent:colors.whiteColor:
        colors.whiteColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: (controller.user.value.result == null )?Center(
        child: MyText(
          title: 'Nothing to Display',
          size: responsive.setTextScale(18),
          clr: colors.gray,
        ),
      ): Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: responsive.setWidth(100),
            height: responsive.setHeight(30),
            child: (petController.currentPetInfo!.value.productGallery != null &&
                    petController.currentPetInfo!.value.productGallery!.length != 0)
                ? PageView.builder(
                itemCount: petController.currentPetInfo!.value.productGallery!.length == 0 ? 1 : petController.currentPetInfo!.value.productGallery!.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      log(APIEndpoints.baseURL + petController.currentPetInfo!.value.productGallery![index].path!);
                      Get.bottomSheet(
                        ImagePreview(
                          thumbnail: petController.currentPetInfo!.value.productGallery![index].thumbnail,
                          network: APIEndpoints.baseURL + petController.currentPetInfo!.value.productGallery![index].path!,
                          // asset: (mapControler.currentPinInfo!.value.gallery == null&& mapControler.currentPinInfo!.value.gallery!.isEmpty)?ImagePath.noImageFound: null,
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: ClipRRect(
                        borderRadius:BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        child: ( petController.currentPetInfo!.value.productGallery != null && petController.currentPetInfo!.value.productGallery!.isNotEmpty)?
                        petController.currentPetInfo!.value.productGallery![index].thumbnail != null?
                        // pet!.value.productGallery!.last.path!.contains("mp4")?
                        FadeInImage(
                          fit: BoxFit.cover,
                          width: responsive.setWidth(100),
                          image: FileImage(
                            petController.currentPetInfo!.value.productGallery![index].thumbnail!,
                          ),
                          placeholder:
                          AssetImage(ImagePath.loaderGifImage),
                        ) :
                        petController.currentPetInfo!.value.productGallery![index].path!.contains("mp4")?
                        FadeInImage(
                          fit: BoxFit.cover,
                          width: responsive.setWidth(100),
                          image: AssetImage(ImagePath.loaderGifImage),
                          placeholder: AssetImage(ImagePath.loaderGifImage),
                        ):
                        FadeInImage(
                          fit: BoxFit.cover,
                          width: responsive.setWidth(100),
                          image: NetworkImage(APIEndpoints.baseURL + petController.currentPetInfo!.value.productGallery![index].path!),
                          placeholder:
                          AssetImage(ImagePath.loaderGifImage),
                        ):
                        Image.asset(ImagePath.noImageFound,fit: BoxFit.contain,),

                    ),
                  );
                })
                : FadeInImage(
                    fit: BoxFit.contain,
                    width: responsive.setWidth(100),
                    image: AssetImage(
                      ImagePath.noImageFound,
                    ),
                    placeholder: AssetImage(ImagePath.loaderGifImage),
                  ),
          ),
         Container(
           color: colors.whiteColor,
           padding: EdgeInsets.only(left: responsive.setWidth(2)),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(
                 height: responsive.setHeight(1),
               ),
               Row(
                 children: [
                   ProfileImage(),
                   SizedBox(
                     width: responsive.setWidth(3),
                   ),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       MyText(
                         title: controller.user.value.result!.name!,
                         size: 17,
                         weight: 'Semi Bold',
                       ),
                       Row(
                         children: [
                           Icon(
                             Icons.location_on_outlined,
                             color: colors.hintColor,
                             size: responsive.setTextScale(10),
                           ),
                           Container(
                             width: responsive.setWidth(70),
                             child: MyText(
                               title: controller
                                   .user.value.result!.locationName!,
                               clr: colors.hintColor,
                               size: responsive.setTextScale(10),
                               line: 1,
                               toverflow: TextOverflow.ellipsis,
                             ),
                           ),
                         ],
                       ),
                     ],
                   )
                 ],
               ),
               SizedBox(
                 height: responsive.setHeight(2),
               ),
               MyMultiText(
                 tiltle1: 'Name',
                 title2: petController.currentPetInfo!.value.name!,
                 clr1: colors.blackColor,
                 weight2: "Semi Bold",
                 clr2: colors.hintColor,
                 size1: responsive.setTextScale(15),
                 size2: responsive.setTextScale(15),

               ),
               SizedBox(
                 height: responsive.setHeight(1),
               ),
               MyMultiText(
                 tiltle1: 'Age',
                 title2:
                 '${petController.currentPetInfo!.value.age!} Years',
                 clr1: colors.blackColor,
                 clr2: colors.hintColor,
                 size1: responsive.setTextScale(15),
                 size2: responsive.setTextScale(15),
               ),
               SizedBox(
                 height: responsive.setHeight(1),
               ),
               MyMultiText(
                 tiltle1: 'Color',
                 title2: '${petController.currentPetInfo!.value.color!}',
                 clr1: colors.blackColor,
                 clr2: colors.hintColor,
                 size1: responsive.setTextScale(15),
                 size2: responsive.setTextScale(15),

               ),
               SizedBox(
                 height: responsive.setHeight(1),
               ),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   MyText(title: "Breed : "),
                   petController.currentPetInfo!.value
                       .breed == null? MyText(
                     title: "N/A",
                     clr: colors.hintColor,
                     size: responsive.setTextScale(15),

                   ):
                   SizedBox(
                     width: responsive.setWidth(70),
                     child: Wrap(
                       alignment: WrapAlignment.start,
                       direction: Axis.horizontal,
                       children: List.generate(
                           petController.currentPetInfo!.value
                               .breed!.length,
                               (index) => MyText(
                             title:
                             " ${petController.currentPetInfo!.value.breed![index].name} ",
                             clr: colors.hintColor,
                                 size: responsive.setTextScale(15),
                               )),
                     ),
                   ),
                 ],
               ),
               SizedBox(
                 height: responsive.setHeight(1),
               ),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   MyText(title: "Characteristic : "),
                   petController.currentPetInfo!.value
                       .characteristics == null?  MyText(
                     title: "N/A",
                     clr: colors.hintColor,
                     size: responsive.setTextScale(15),

                   ):
                   SizedBox(
                     width: responsive.setWidth(70),
                     child: Wrap(
                       alignment: WrapAlignment.start,
                       direction: Axis.horizontal,
                       children: List.generate(
                           petController.currentPetInfo!.value
                               .characteristics!.length,
                               (index) => MyText(
                             title:
                             " ${petController.currentPetInfo!.value.characteristics![index].name} ",
                             clr: colors.hintColor,
                                 size: responsive.setTextScale(15),

                               )),
                     ),
                   ),
                 ],
               ),
               SizedBox(
                 height: responsive.setHeight(1),
               ),
               MyMultiText(
                 tiltle1: 'About ${petController.currentPetInfo!.value.name!}',
                 title2: ' ${petController.currentPetInfo!.value.description!}',
                 clr1: colors.blackColor,
                 clr2: colors.hintColor,
                 size1: responsive.setTextScale(15),
                 size2: responsive.setTextScale(15),
               ),
               SizedBox(
                 height: responsive.setHeight(5),
               ),
               SizedBox(
                 width: responsive.setWidth(96),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     MyElevatedButton(
                       height: responsive.setHeight(6),
                       width: responsive.setWidth(45),
                       title: 'Adopt',
                       bgColor: colors.primaryColor,
                       isImage: true,
                       imageColor: colors.blackColor.withOpacity(0.3),
                       onTap: () {
                         // petController.adoptPet();
                         Get.toNamed('/setupMeeting');
                       },
                     ),
                     MyElevatedButton(
                       height: responsive.setHeight(6),
                       width: responsive.setWidth(45),
                       title: 'Pet Features',
                       bgColor: colors.secondaryColor,
                       isImage: true,
                       imageColor: colors.blackColor.withOpacity(0.3),
                       onTap: () {
                         Get.toNamed('/petProfile');
                       },
                     )
                   ],
                 ),
               ),
               SizedBox(
                 height: responsive.setHeight(1),
               ),
             ],
           ),
         )
        ],
      ),
    );
  }
}
