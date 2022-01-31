import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_button.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Controller/ShelterPicVideoController.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:pawndr/Views/BaseScreens/BaseViewScreen.dart';
import 'package:pawndr/Views/widgets/image_upload.dart';

class ShelterPetsPicture extends StatelessWidget {
  Responsive responsive = Responsive();
  ColorConfig colors = ColorConfig();
  ShelterPicAndVideoController shelterPicAndVideoController =
      Get.put(ShelterPicAndVideoController());
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return BaseView(
      showCircle3: true,
      showCircle4: true,
      showBottomBar: true,
      showAppBar: false,
      showCircle1: false,
      showCircle2: false,
      child:Obx(()=> Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          ImagePath.bgImage,
                        ))),
                height: responsive.setHeight(30),
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    ImagePath.pawss,
                  ),
                )),
                height: responsive.setHeight(30),
              ),
              Positioned(
                top: responsive.setHeight(2),
                left: responsive.setWidth(4),
                child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: colors.darkYellow,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(responsive.setHeight(1)),
                    child: Icon(
                      Icons.arrow_back,
                      color: colors.whiteColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: responsive.setWidth(4),
                top: responsive.setHeight(4),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      height: responsive.setHeight(5),
                      width: responsive.setHeight(5),
                      decoration: BoxDecoration(
                          color: colors.whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(responsive.setHeight(1)),
                      child: Icon(
                        Icons.phone,
                        color: colors.darkYellow,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: responsive.setHeight(5),
                      width: responsive.setHeight(5),
                      decoration: BoxDecoration(
                          color: colors.whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(responsive.setHeight(1)),
                      child: FaIcon(FontAwesomeIcons.comment,
                          color: colors.darkYellow),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: responsive.setHeight(4),
                            bottom: responsive.setHeight(1)),
                        height: responsive.setWidth(22),
                        width: responsive.setWidth(22),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: colors.whiteColor),
                        padding: EdgeInsets.all(responsive.setWidth(0.5)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: AssetImage('assets/users/userImage.png'),
                            ),
                          ),
                        ),
                      ),
                      MyText(
                        title: "Persian Breed Shelter ",
                        size: 15,
                        weight: "Bold",
                        clr: colors.whiteColor,
                        center: true,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: colors.whiteColor,
                          ),
                          MyText(
                            title: "1255 23rd ST. NW, Suite 450 Suite",
                            clr: colors.whiteColor,
                            toverflow: TextOverflow.ellipsis,
                            center: true,
                          )
                        ],
                      ),
                      RatingBarIndicator(
                        rating: 4,
                        itemCount: 5,
                        itemSize: responsive.setWidth(8),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        Row(
                children: [
                  Expanded(
                      child: MyButton(
                    title: "Pictures",
                    onTap: (){
                        shelterPicAndVideoController.showPicAndVideo.value="pictures";
                    },
                    bgColor:
                        shelterPicAndVideoController.showPicAndVideo.value ==
                                "pictures"
                            ? colors.primaryColor
                            : colors.whiteColor,
                    fontSize: 16,
                    textColor:
                        shelterPicAndVideoController.showPicAndVideo.value ==
                                "pictures"
                            ? colors.whiteColor
                            : colors.gray,
                    radius: 1,
                    borderColor: shelterPicAndVideoController.showPicAndVideo.value ==
                                "pictures"
                            ? colors.primaryColor:colors.gray,
                    elevation:
                        shelterPicAndVideoController.showPicAndVideo.value ==
                                "pictures"
                            ? 7
                            : 0,
                  )),
                  Expanded(
                      child: MyButton(
                    title: "Videos",
                    onTap: (){
                        shelterPicAndVideoController.showPicAndVideo.value="videos";
                    },
                    bgColor:
                        shelterPicAndVideoController.showPicAndVideo.value ==
                                "videos"
                            ? colors.primaryColor
                            : colors.whiteColor,
                    fontSize: 16,
                    textColor:
                        shelterPicAndVideoController.showPicAndVideo.value ==
                                "videos"
                            ? colors.whiteColor
                            : colors.gray,
                    radius: 1,
                    borderColor:shelterPicAndVideoController.showPicAndVideo.value ==
                                "videos"
                            ? colors.primaryColor:colors.gray,
                    elevation:
                        shelterPicAndVideoController.showPicAndVideo.value ==
                                "videos"
                            ? 7
                            : 0,
                  ))
                ],
              ),
         Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child:shelterPicAndVideoController.showPicAndVideo.value=="pictures"?GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (Context,index){
                    return index==0?InkWell(
                      onTap: (){
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return UploadPhoto(screenName: "shelter",);
                            });
                      },
                      child: Container(
                         margin: EdgeInsets.only(left: responsive.setWidth(2),bottom: responsive.setWidth(2)),
                        height: responsive.setWidth(15),
                        width: responsive.setWidth(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: colors.pickerContainerController),
                      child: Icon(Icons.add,color: colors.primaryColor,),
                      ),
                    ):Container(  height: responsive.setWidth(15),
                      width: responsive.setWidth(15),
                      margin: EdgeInsets.only(left: responsive.setWidth(2),bottom: responsive.setWidth(2)),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(shelterPicAndVideoController.filePaths[index-1],),fit: BoxFit.cover),
                       ),
                      child:InkWell(
                        onTap: (){shelterPicAndVideoController.filePaths.removeAt(index-1);},
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.cancel,color:colors.secondaryColor,)
                        ),
                      ),
                   );
                },
                itemCount: shelterPicAndVideoController.filePaths.length+1,
              ):GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (Context,index){
                    return index==0?InkWell(
                      onTap: (){
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return UploadPhoto(screenName: "shelter",);
                            });
                      },
                      child: Container(
                         margin: EdgeInsets.only(left: responsive.setWidth(2),bottom: responsive.setWidth(2)),
                        height: responsive.setWidth(15),
                        width: responsive.setWidth(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: colors.pickerContainerController),
                      child: Icon(Icons.add,color: colors.primaryColor,),
                      ),
                    ):Container(  height: responsive.setWidth(15),
                      width: responsive.setWidth(15),
                      margin: EdgeInsets.only(left: responsive.setWidth(2),bottom: responsive.setWidth(2)),
                      padding: EdgeInsets.only(top: responsive.setWidth(1),right: responsive.setWidth(1)),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(shelterPicAndVideoController.videoPath[index-1],),fit: BoxFit.cover),
                       ),
                      child: InkWell(
                        onTap: (){shelterPicAndVideoController.videoPath.removeAt(index-1);},
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.cancel,color:colors.secondaryColor,)
                        ),
                      ),
                   );
                },
                itemCount: shelterPicAndVideoController.videoPath.length+1,
              ),
          ),
         ],
      )),
    );
  }
  // void selectImageMode(context){
  //   showDialog(context: context,
  //   builder: (BuildContext context){
  //     return AlertDialog(
  //
  //       contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
  //       content:MyText(title: "Select Image/Video Mode",center: true,clr: colors.primaryColor,weight: "Semi Bold",size: 18,),
  //       actionsAlignment: MainAxisAlignment.center,
  //        actions: <Widget>[
  //             new TextButton(
  //               child:MyText(title: "Gallery",center: true,clr: colors.gray,size: 15,),
  //                style: ButtonStyle(
  //                 backgroundColor: MaterialStateColor.resolveWith((states) => colors.primaryColor),
  //                 elevation: MaterialStateProperty.all(5)
  //               ),
  //               onPressed: () {
  //                 if(shelterPicAndVideoController.showPicAndVideo=="pictures"){
  //                    shelterPicAndVideoController.imgFromGallery();
  //                 }else{
  //                   shelterPicAndVideoController.videoFromGallery();
  //                 }
  //
  //                 Get.back();
  //               },
  //             ) ,
  //             new TextButton(
  //               child:MyText(title: "Camera",center: true,clr: colors.gray,size: 15,),
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateColor.resolveWith((states) => colors.primaryColor),
  //                 elevation: MaterialStateProperty.all(5)
  //               ),
  //               onPressed: () {
  //                  if(shelterPicAndVideoController.showPicAndVideo=="pictures"){
  //                    shelterPicAndVideoController.imgFromCamera();
  //                 }else{
  //                   shelterPicAndVideoController.videoFromCamera();
  //                 }
  //
  //                 Get.back();
  //               },
  //             )
  //           ],
  //         );
  //   });
  // }
}
