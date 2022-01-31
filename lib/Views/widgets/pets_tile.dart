import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/VolunteerPetController.dart';
import 'package:pawndr/Controller/add_recent_pets.dart';
import 'package:pawndr/Controller/finderhome_controller.dart';
import 'package:pawndr/Controller/petscreen_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/Pets/PetsScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/PetDetailScreen.dart';

class PetTile extends StatelessWidget {
  bool onTap;
  int index;
  // RxBool favourite = false.obs;
  Rx<Pet>? pet = Pet().obs;
  int width, height;
  FinderHomeController finderHomeController = Get.find();
  VolunteerPetController volunteerPetController = Get.put(VolunteerPetController());

  PetTile(
      {required this.index,
      required this.pet,
      this.width = 35,
        this.onTap=true,
      this.height = 14});

  PetScreenController controller = Get.put(PetScreenController());
  AddRecentPetsController addRecentPetsController = Get.put(AddRecentPetsController());

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap:
              (){

            finderHomeController.f1.value.unfocus();
            controller.currentPetInfo!.value=pet!.value;
            addRecentPetsController.addRecentProduct();
            Future.delayed(Duration(milliseconds: 20), () { Get.bottomSheet(
                  PetDetailscreen(),
                  isScrollControlled: true,
                );});
          },
          child: Column(
            children: [
              // controller.myList.where((item) => item.contains("US"))
              Material(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: colors.textColor,
                child: Container(
                    height: responsive.setHeight(height),
                    width: responsive.setWidth(width),
                    decoration: BoxDecoration(
                      color: //( pet[index].productGallery != null && pet[index].productGallery.isNotEmpty)?colors.whiteColor:
                      Colors.transparent
                    ),
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:( pet!.value.productGallery != null && pet!.value.productGallery!.isNotEmpty)?
                      pet!.value.productGallery!.last.thumbnail != null?
                      // pet!.value.productGallery!.last.path!.contains("mp4")?
                      FadeInImage(
                        fit: BoxFit.cover,
                        width: responsive.setWidth(100),
                        image: FileImage(
                          pet!.value.productGallery!.last.thumbnail!,
                        ),
                        placeholder:
                        AssetImage(ImagePath.loaderGifImage),
                      ) :
                      pet!.value.productGallery!.last.path!.contains("mp4")?
                      FadeInImage(
                        fit: BoxFit.cover,
                        width: responsive.setWidth(100),
                        image: AssetImage(ImagePath.loaderGifImage),
                        placeholder: AssetImage(ImagePath.loaderGifImage),
                      ):
                      FadeInImage(
                        fit: BoxFit.cover,
                        width: responsive.setWidth(100),
                        image: NetworkImage(APIEndpoints.baseURL + pet!.value.productGallery!.last.path!),
                        placeholder:
                        AssetImage(ImagePath.loaderGifImage),
                      ):
                      Image.asset(ImagePath.noImageFound,fit: BoxFit.contain,),
                    )
                ),
              ),
              onTap!=false?  Obx(()=>Container(
                margin: EdgeInsets.only(top: responsive.setHeight(0.5)),
                width: responsive.setWidth(33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: '${pet!.value.name}',
                          size: responsive.setTextScale(8),
                          toverflow: TextOverflow.ellipsis,
                          line: 1,

                        ),
                        MyText(
                          title: '${pet!.value.gender}-sex',
                          size: responsive.setTextScale(8),
                          clr: colors.hintColor,
                          toverflow: TextOverflow.ellipsis,
                          line: 1,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print('arso');
                        pet!.value.favorite = ! pet!.value.favorite!;
                        controller.Favourite(pet!.value.id!, pet!.value.favorite!);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/fav.png',
                            color: pet!.value.favorite==true
                                ? colors.secondaryColor
                                : colors.primaryColor,
                            height: responsive.setWidth(5),
                            width: responsive.setWidth(5),
                          ),
                          SizedBox(
                            width: responsive.setWidth(2),
                          ),
                          Column(
                            children: [
                              MyText(
                                title: '${pet!.value.age}-Year',
                                size: responsive.setTextScale(8),
                                toverflow: TextOverflow.ellipsis,
                                line: 1,
                              ),
                              MyText(
                                title: '${pet!.value.weight}-kg',
                                size: responsive.setTextScale(8),
                                toverflow: TextOverflow.ellipsis,
                                line: 1,
                                clr: colors.hintColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )):Container()
            ],
          ),
        ));
  }
}
