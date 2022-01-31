import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/map_controller.dart';
import 'package:pawndr/Modals/shelterscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';


class ShelterTile extends StatelessWidget {
  int index;
  Rx<Shelter> shelter = Shelter().obs;
  ShelterTile({required this.index, required this.shelter});

  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  MapControler mapControler = Get.put(MapControler());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return GestureDetector(
      onTap: () async {
        mapControler.currentPinInfo!.value = shelter.value;
        // mapControler.currentPinInfo!.value.id = shelter.value.id;
        // mapControler.currentPinInfo!.value.name = shelter.value.name;
        // mapControler.currentPinInfo!.value.description = shelter.value.description;
        // mapControler.currentPinInfo!.value.city = shelter.value.city;
        // mapControler.currentPinInfo!.value.state = shelter.value.state;
        // mapControler.currentPinInfo!.value.country = shelter.value.country;
        // mapControler.currentPinInfo!.value.phone = shelter.value.phone;
        // mapControler.currentPinInfo!.value.shelterGallery = shelter.value.shelterGallery;
        mapControler.getShelterPets();
        mapControler.currentPinInfo!.refresh();
        Get.toNamed("/shelterDetail");
      },
      child: Container(
        width: responsive.setWidth(42),
        padding: EdgeInsets.symmetric(vertical: responsive.setHeight(1),horizontal: responsive.setWidth(2)),
        child: Column(
          children: [
            Container(
                height: responsive.setHeight(12),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: (shelter.value.shelterGallery != null &&
                            shelter.value.shelterGallery!.isNotEmpty)
                        ? shelter.value.shelterGallery!.last.thumbnail != null
                            ? FadeInImage(
                              fit: BoxFit.cover,
                              width: responsive.setWidth(100),
                              image: FileImage(
                                shelter.value.shelterGallery!.last.thumbnail!,
                              ),
                              placeholder:
                                  AssetImage(ImagePath.loaderGifImage),
                            )
                            : FadeInImage(
                              fit: BoxFit.cover,
                              width: responsive.setWidth(100),
                              image: NetworkImage(APIEndpoints.baseURL +
                                  shelter.value.shelterGallery!.last.path!),
                              placeholder:
                                  AssetImage(ImagePath.loaderGifImage),
                            )
                            : Image.asset(
                            ImagePath.noImageFound,
                            fit: BoxFit.contain,
                          ))),
            // Container(
            //   height: responsive.setHeight(12),
            //
            //   decoration: (
            //       BoxDecoration(
            //           image:
            //           (shelter.shelterGallery != null && shelter.shelterGallery.isNotEmpty) ? shelter.shelterGallery!.last.thumbnail != null ? DecorationImage(image: FileImage(shelter.shelterGallery!.last.thumbnail!), fit: BoxFit.cover) : DecorationImage(image: NetworkImage(APIEndpoints.baseURL + shelter.shelterGallery!.last.path!), fit: BoxFit.cover) : DecorationImage(image: AssetImage('assets/pets/shelterPet3.png'), fit: BoxFit.cover),
            //           color: colors.primaryColor,
            //       borderRadius: BorderRadius.circular(10))),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: shelter.value.name!,
                  size: responsive.setTextScale(10),
                ),
                Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: double.parse(shelter.value.rating.toString()),
                              itemCount: 5,
                              itemSize: 10.0,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(
                              width: responsive.setWidth(1),
                            ),
                            MyText(
                              title: '4.3',
                              size: responsive.setTextScale(10),
                            ),
                          ],
                        ),
                        Expanded(
                          child: MyText(
                            title: '  ${shelter.value.city} , ${shelter.value.country} ',
                            size: responsive.setTextScale(9),
                            toverflow: TextOverflow.ellipsis,
                            line: 1,
                          ),
                        )
                      ],
                    ),
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
