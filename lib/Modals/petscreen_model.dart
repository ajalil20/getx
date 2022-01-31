import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pawndr/Modals/pet_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
class PetScreenModel {
  final Result? result;

  PetScreenModel({
    this.result,
  });

  PetScreenModel.fromJson(Map<String, dynamic> json)
      : result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'result' : result?.toJson()
  };
}
class Result {
  final List<Pet>? topBreeds;
  final List<Pet>? cat;
  final List<Pet>? dog;

  Result({
    this.topBreeds,
    this.cat,
    this.dog,
  });

  Result.fromJson(Map<String, dynamic> json)
      : topBreeds = (json['topBreeds'] as List?)?.map((dynamic e) => Pet.fromJson(e as Map<String,dynamic>)).toList(),
        cat = (json['cats'] as List?)?.map((dynamic e) => Pet.fromJson(e as Map<String,dynamic>)).toList(),
        dog = (json['dogs'] as List?)?.map((dynamic e) => Pet.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'topBreeds' : topBreeds?.map((e) => e.toJson()).toList(),
    'cats' : cat?.map((e) => e.toJson()).toList(),
    'dogs' : dog?.map((e) => e.toJson()).toList()
  };
}