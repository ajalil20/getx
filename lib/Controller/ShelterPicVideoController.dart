
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
class ShelterPicAndVideoController extends GetxController{
  RxList<dynamic> filePaths=[].obs;
  RxList<dynamic> videoPath=[].obs;



  RxString showPicAndVideo="pictures".obs;
   Rx<File> imagePick = File("").obs;
  Rx<File> videoPick = File("").obs;

  //Pictures
  Future imgFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

     if(pickedFile!=""){
         imagePick.value = File(pickedFile!.path);
          filePaths.add(imagePick.value);
    }else{
     CustomToast().showToast("Not Selected", "Image Not Selected", false);
    }
  }
  Future imgFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

     if(pickedFile!=""){
         imagePick.value = File(pickedFile!.path);
          filePaths.add(imagePick.value);
    }else{
     CustomToast().showToast("Not Selected", "Image Not Selected", false);
    }
  }

  //Videos
  Future videoFromCamera() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.camera);

     if(pickedFile!=""){
        videoPick.value = File(pickedFile!.path);
        final fileName = await VideoThumbnail.thumbnailFile(
           video: videoPick.value.path,
            thumbnailPath: (await getTemporaryDirectory()).path,
           imageFormat: ImageFormat.PNG,
             quality: 100,
);
         videoPath.add(fileName);
    }else{
     CustomToast().showToast("Not Selected", "Video Not Selected", false);
    }
  }
   Future videoFromGallery() async {
    final pickedFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);

    if(pickedFile!=""){
        videoPick.value = File(pickedFile!.path);
        final fileName = await VideoThumbnail.thumbnailFile(
           video: videoPick.value.path,
            thumbnailPath: (await getTemporaryDirectory()).path,
           imageFormat: ImageFormat.PNG,
             quality: 100,);
         videoPath.add(File(fileName!));
    }else{
     CustomToast().showToast("Not Selected", "Video Not Selected", false);
    }
   }
}