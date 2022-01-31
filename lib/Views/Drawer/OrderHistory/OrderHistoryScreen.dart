
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/orderhistory_controller.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  OrderHistoryController controller = Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showAppBar: true,
      screenNamee: "Order History",
      titleClr: colors.blackColor,
      showCircle1: true,
      showCircle2: false,
      showBottomBar: true,
      titleFontSize: responsive.setTextScale(20),
      child: Obx(()=> Column(
          children: [
            controller.resp.value.result != null? controller.resp.value.result!.isNotEmpty?
            Expanded(
              child: ListView.builder(
                itemCount: controller.resp.value.result!.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index){
                return OrderTile(
                    onTap: false,
                    index: index,
                    pet: controller.resp.value.result![index].products![0],
                order: controller
                    .resp
                    .value
                    .obs,
                );
                ;
              }),
            ):
            Expanded(child: Center(child: MyText(
              title: 'No Orders',
              size: responsive.setTextScale(18),
              clr: colors.gray,
            ),),):
            Expanded(child: Center(child: MyText(
              title: 'No Orders',
              size: responsive.setTextScale(18),
              clr: colors.gray,
            ),),),


            Container(height:  responsive.setHeight(1))
          ],
        ),
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  OrderHistoryController controller = Get.put(OrderHistoryController());
  bool onTap;
  int index;
  RxBool favourite = false.obs;
  var pet;
  Rx<OrderHistoryModel>order = OrderHistoryModel().obs;

  OrderTile(
      {required this.index,
        required this.pet,
        this.onTap=true,
        required this.order
      });
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Padding(
      padding: EdgeInsets.only(top: responsive.setHeight(2)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: responsive.setHeight(1.2)),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(responsive.setWidth(2)),
                width: responsive.setWidth(100),
                decoration: BoxDecoration(
                    color: colors.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          width: responsive.setWidth(28),
                        ),
                        Expanded(
                          child: Column(

                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      MyText(
                                        title: '${pet.name}',
                                        clr: colors.primaryColor,
                                        weight: 'Semi Bold',
                                        size: responsive.setTextScale(20),
                                      ),
                                      pet.characteristics == null? MyText(
                                        title: "N/A",
                                        clr: colors.blackColor,
                                        // size: responsive.setTextScale(13),

                                      ):
                                      SizedBox(
                                        width: responsive.setWidth(70),
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              pet.characteristics!.length,
                                                  (index) => MyText(
                                                title:
                                                " ${pet.characteristics![index].name} ",
                                                clr: colors.primaryColor,
                                                // size: responsive.setTextScale(13),
                                              )),
                                        ),
                                      ),


                                      // MyText(
                                      //   title: 'Golden Retriver',
                                      //   size: responsive.setTextScale(13),
                                      // ),
                                    ],
                                  ),

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: PopupMenuButton(

                                        child:  Icon(
                                          Icons.more_horiz,
                                          color: colors.gray,
                                        ),
                                      // padding: EdgeInsets.all(5),
                                      color: colors.secondaryColor,
                                        elevation: 20,

                                        onSelected: (val) {
                                      if (val == 'Delete') {
                                        controller.deleteOrder(order.value.result![index].id);
                                      }
                                      else if (val == 'Archive') {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
                                      }
                                    },
                                        itemBuilder: (context) {
                                          return ['Delete', 'Archive'].map((choice) {
                                            return PopupMenuItem(
                                                value: choice,
                                                child:  MyText(title: choice,size: 12,clr: colors.whiteColor),
                                            );
                                          }).toList();
                                        }
                                    ),
                                  )

                                ],
                              ),
                              SizedBox(height: responsive.setHeight(1),),
                              Row(

                                children: [
                                  MyText(
                                    title: 'Age',
                                    clr: colors.hintColor,
                                  ),
                                  MyText(
                                    title: '         :   ',
                                    clr: colors.blackColor,
                                  ),
                                  Container(
                                    width: responsive.setWidth(16.5),
                                    child: MyText(
                                      title: '${pet.age} years',
                                      clr: colors.primaryColor,
                                      toverflow: TextOverflow.ellipsis,
                                      line: 1,
                                      // size: responsive.setTextScale(13),
                                    ),
                                  ),
                                  SizedBox(width: responsive.setWidth(1)),
                                  MyText(
                                    title: 'Breed',
                                    clr: colors.hintColor,
                                  ),
                                  MyText(
                                    title: '   :   ',
                                    clr: colors.blackColor,
                                  ),
                                  pet.breed == null? MyText(
                                    title: "N/A",
                                    clr: colors.primaryColor,
                                    // size: responsive.setTextScale(13),

                                  ):
                                  SizedBox(
                                    width: responsive.setWidth(70),
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                          pet.breed!.length,
                                              (index) => MyText(
                                            title:
                                            " ${pet.breed![index].name} ",
                                            clr: colors.primaryColor,
                                            // size: responsive.setTextScale(13),
                                          )),
                                    ),
                                  ),



                                ],
                              ),
                              SizedBox(height: responsive.setHeight(1),),
                              Row(
                                children: [
                                  MyText(
                                    title: 'Weight',
                                    clr: colors.hintColor,
                                  ),
                                  MyText(
                                    title: '  :   ',
                                    clr: colors.blackColor,
                                  ),
                                  Container(
                                    width: responsive.setWidth(12),
                                    child: MyText(
                                      title: '${pet.weight} Kg',
                                      clr: colors.primaryColor,
                                      toverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: responsive.setWidth(5.6)),
                                  MyText(
                                    title: 'Color',
                                    clr: colors.hintColor,
                                  ),
                                  MyText(
                                    title: '    :   ',
                                    clr: colors.blackColor,
                                  ),
                                  Container(
                                    child: MyText(
                                      title: '${pet.color}' ,
                                      clr: colors.primaryColor,
                                      toverflow: TextOverflow.ellipsis,
                                      line: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: responsive.setHeight(1),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyButton(
                                    textColor: colors.whiteColor,
                                    bgColor:colors.secondaryColor,
                                    title: "Contact Client",
                                    radius: 20,
                                    fontSize: 12,
                                    height: responsive.setHeight(4),
                                    onTap: (){

                                    },
                                  ),
                                 SizedBox(width: responsive.setWidth(5),),
                                  Expanded(child:
                                  MyText(title: pet.createdAt == null?"N/A": DateFormat('kk:mm a, dd MMM').format(DateTime.parse(pet.createdAt)),clr: colors.gray,size: 13,toverflow: TextOverflow.ellipsis,line: 1,),

                                    // MyText(title: "${pet.createdAt}",clr: colors.gray,size: 16,toverflow: TextOverflow.ellipsis,line: 1,)
                                  )
                                ],)
                            ],
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Container(
                height: responsive.setHeight(22),
                width: responsive.setWidth(25),
                decoration: BoxDecoration(
                    color: ( pet.productGallery != null && pet.productGallery.isNotEmpty)?colors.whiteColor:Colors.transparent
                ),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:( pet.productGallery != null && pet.productGallery.isNotEmpty)?
                  // pet[index].productGallery!.last.thumbnail != null?
                  pet.productGallery!.last.path.contains("mp4") == null?
                  FadeInImage(
                    fit: BoxFit.cover,
                    width: responsive.setWidth(100),
                    image: FileImage(
                      pet.productGallery!.last.thumbnail!,
                    ),
                    placeholder:
                    AssetImage(ImagePath.loaderGifImage),
                  ) :
                  FadeInImage(
                    fit: BoxFit.cover,
                    width: responsive.setWidth(100),
                    image: NetworkImage(APIEndpoints.baseURL + pet.productGallery!.last.path!),
                    placeholder:
                    AssetImage(ImagePath.loaderGifImage),
                  ):
                  Image.asset(ImagePath.noImageFound,fit: BoxFit.contain,),
                )
            ),
          ),
        ],
      ),
    );
  }
}
