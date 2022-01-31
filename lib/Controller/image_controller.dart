import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  Rx<File> imageProfile = File("").obs;

  Future imgFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    imageProfile.value = File(pickedFile!.path);
  }

  Future imgFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    imageProfile.value = File(pickedFile!.path);
  }

}
