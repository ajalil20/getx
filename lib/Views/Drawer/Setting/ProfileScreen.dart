import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_image_circle.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/BottomBarController.dart';
import 'package:pawndr/Controller/finderhome_controller.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:intl/intl.dart';
import 'package:pawndr/Views/widgets/favorite_tile.dart';
import 'package:pawndr/Views/widgets/image_preview.dart';
import 'package:pawndr/Views/widgets/location_sheet.dart';
import 'package:pawndr/Views/widgets/profile_image.dart';

class ProfileScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  UserController controller = Get.find();
  BottomBarController bottomBarController = Get.put(BottomBarController());
  FinderHomeController finderHomeController = Get.put(FinderHomeController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: BaseView(
        showCircle2: false,
        showBackButton: false,
        titleClr: colors.blackColor,
        screenNamee: 'Profile',
        titleWeight: 'Semi Bold',
        titleFontSize: responsive.setTextScale(30),
        child: Obx(()=> SingleChildScrollView(
            child:
            controller.user.value.result ==null? Container()
            :
            Stack(children: [
              Column(
              children: [
                SizedBox(
                  height: responsive.setHeight(1),
                ),
                Center(
                  child:ProfileImage(size: 8,)
                ),
                SizedBox(
                  height: responsive.setHeight(3),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:responsive.setWidth(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: responsive.setWidth(20),),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: colors.hintColor,size: responsive.setTextScale(10),),
                          Container(width: responsive.setWidth(45),
                              child: MyText(title: '${controller.user.value.result!.locationName}',clr: colors.hintColor,size: responsive.setTextScale(10),toverflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed("/profileSetting");
                        },
                        child: Image.asset(
                          'assets/icons/edit.png',
                          width: responsive.setWidth(6),
                          color: colors.gray,
                        ),
                      )
                    ],
                  ),
                ),
                // MyText(title: 'Veterinary Pet Assistant',clr: colors.hintColor,size: responsive.setTextScale(12),),
                Divider(thickness: 1,color: colors.gray,endIndent: responsive.setWidth(4),indent: responsive.setWidth(4)
                ,),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: responsive.setWidth(90),
                    padding: EdgeInsets.all(responsive.setHeight(2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText(title: "About me",size: 16),
                      MyText(title: controller.user.value.result!.about!,size: 12,),
                      SizedBox(height: responsive.setHeight(1),),
                      MyText(title: "Name",size: 16),
                      MyText(title: controller.user.value.result!.name!,clr: colors.gray,toverflow: TextOverflow.ellipsis,),
                        SizedBox(height: responsive.setHeight(1),),
                         MyText(title: "Location",size: 16),
                      MyText(title: controller.user.value.result!.locationName!,clr: colors.gray,toverflow: TextOverflow.ellipsis,),
                        SizedBox(height: responsive.setHeight(1),),
                         MyText(title: "Date of Birth",size: 16),
                       Obx(()=> MyText(title: controller.user.value.result!.dateofbirth == null?"N/A": DateFormat('MMMM dd, yyyy').format(DateTime.parse(controller.user.value.result!.dateofbirth!)),clr: colors.gray,)),
                        SizedBox(height: responsive.setHeight(1),),
                           MyText(title: "Zip Code",size: 16),
                      MyText(title: controller.user.value.result!.zipcode!,clr: colors.gray,),
                        SizedBox(height: responsive.setHeight(1),),
                  ],),),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(left:responsive.setWidth(4)),
                    child: MyText(title: "Favorites Pet from sheltered",size: 18,),
                  )),
                   Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(left:responsive.setWidth(4)),
                    child: MyText(title: "These pets are about to deliver to clients from there shelters",size: 14,clr: colors.gray,),
                  )),
                 Obx(()=>
                 finderHomeController.favorite.value.result==null?Container(
                   height: responsive.setHeight(10),
                   child: Center(
                     child: MyText(
                       title: 'No Favorites',
                       size: responsive.setTextScale(18),
                       clr: colors.gray,
                     ),
                   ),
                 ):
                 finderHomeController.favorite.value.result!.isEmpty
                     ? Container(
                   height: responsive.setHeight(10),
                   child: Center(
                     child: MyText(
                       title: 'No Favorites',
                       size: responsive.setTextScale(18),
                       clr: colors.gray,
                     ),
                   ),
                 )
                     :
                 ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: finderHomeController.favorite.value.result!.length,
                     itemBuilder: (context,index){
                       return  FavoriteTile(index: index,pet: finderHomeController.favorite.value.result![index].obs,);
                     }),),
                SizedBox(
                  height: responsive.setHeight(3),
                )
              ],
            ),
              Positioned(
                      top: responsive.setHeight(1),
                      child: Image.asset('assets/icons/dohleftside.png',width: responsive.setWidth(35),)),
            ],),
          ),
        )
      ),
    );
  }
  Future<bool> onWillPop() {
    bottomBarController.currentIndex.value=0;
    if(controller.user.value.result!.userType=="petfinder") {
      Get.toNamed('/finderHome');
    }
    else if (controller.user.value.result!.userType=="volunteershelter") {
      Get.toNamed('/volunteerHome');
    }
       return Future.value(true);

  }
}
