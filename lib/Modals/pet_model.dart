import 'dart:io';

import 'package:get/get.dart';
import 'package:pawndr/Controller/finderhome_controller.dart';
import 'package:pawndr/Modals/shelterscreen_model.dart';
import 'package:pawndr/Modals/signup_model.dart';
File? thumbnail=File("");
FinderHomeController finderHomeController =Get.find();
class PetModel {
  List<Pet>? result;

  PetModel({
    this.result,
  });

  PetModel.fromJson(Map<String, dynamic> json) {
    result = (json['result'] as List?)?.map((dynamic e) => Pet.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['result'] = result?.map((e) => e.toJson()).toList();
    return json;
  }
}
class Pet {
  String? id;
  String? breedId;
  String? petCategoryId;
  String? characteristicsId;
  String? shelterId;
  String? volunteerId;
  String? name;
  String? description;
  String? age;
  String? time;
  String? gender;
  String? color;
  String? weight;
  String? height;
  String? createdAt;
  int? v;
  bool? favorite;
  String? status;
  List<Characteristics>? breed;
  List<ProductGallery>? productGallery;
  List<Characteristics>? characteristics;
  List<Shelters>? shelters;
  List<Petcategories>? petcategories;
  List<SignUpModel>? volunteer;

  Pet({
    this.id,
    this.breedId,
    this.petCategoryId,
    this.characteristicsId,
    this.shelterId,
    this.volunteerId,
    this.name,
    this.description,
    this.time,
    this.age,
    this.gender,
    this.color,
    this.weight,
    this.height,
    this.createdAt,
    this.v,
    this.favorite,
    this.status,
    this.breed,
    this.productGallery,
    this.characteristics,
    this.shelters,
    this.petcategories,
    this.volunteer,
  });

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    breedId = json['breed_id'] as String?;
    petCategoryId = json['pet_category_id'] as String?;
    characteristicsId = json['characteristics_id'] as String?;
    shelterId = json['shelter_id'] as String?;
    volunteerId = json['volunteer_id'] as String?;
    name = (json['name'] as String?)??"N/A";
    description = (json['description'] as String?)??"N/A";
    gender = (json['gender'] as String?)??"N/A";
    time = (json['time'] as String?)??"N/A";
    age = (json['age'] as String?)??"N/A";
    color = (json['color'] as String?)??"N/A";
    weight = (json['weight'] as String?)??"N/A";
    height = (json['height'] as String?)??"N/A";
    createdAt = json['created_at'] as String?;
    v = json['__v'] as int?;
    favorite = json['favourite']!=null? json['favourite']==0?false:true:false;
    status = (json['status'] as String?)??"N/A";
    breed = (json['breed'] as List?)?.map((dynamic e) => Characteristics.fromJson(e as Map<String,dynamic>)).toList();
    productGallery = (json['productGallery'] as List?)?.map((dynamic e) {
      return ProductGallery.fromJson(e as Map<String, dynamic>);
    }).toList();
    characteristics = (json['characteristics'] as List?)?.map((dynamic e) => Characteristics.fromJson(e as Map<String,dynamic>)).toList();
    shelters = (json['shelters'] as List?)?.map((dynamic e) => Shelters.fromJson(e as Map<String,dynamic>)).toList();
    petcategories = (json['petcategories'] as List?)?.map((dynamic e) => Petcategories.fromJson(e as Map<String,dynamic>)).toList();
    volunteer = (json['volunteer'] as List?)?.map((dynamic e) => SignUpModel.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['breed_id'] = breedId;
    json['pet_category_id'] = petCategoryId;
    json['characteristics_id'] = characteristicsId;
    json['shelter_id'] = shelterId;
    json['volunteer_id'] = volunteerId;
    json['name'] = name;
    json['description'] = description;
    json['gender'] = gender;
    json['time'] = time;
    json['age'] = age;
    json['color'] = color;
    json['weight'] = weight;
    json['height'] = height;
    json['created_at'] = createdAt;
    json['__v'] = v;
    json['favourite'] = favorite;
    json['status'] = status;
    // json['productGallery'] = productGallery?.map((e)async => await e.toJson()).toList();
    json['breed'] = characteristics?.map((e) => e.toJson()).toList();
    json['characteristics'] = characteristics?.map((e) => e.toJson()).toList();
    json['shelters'] = shelters?.map((e) => e.toJson()).toList();
    json['petcategories'] = petcategories?.map((e) => e.toJson()).toList();
    json['volunteer'] = volunteer?.map((e) => e.toJson()).toList();
    return json;
  }
}
class ProductGallery {
  String? id;
  String? path;
  String? productId;
  File? thumbnail;
  int? v;

  ProductGallery({
    this.id,
    this.path,
    this.productId,
    this.v,
    this.thumbnail
  });

  ProductGallery.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    path = json['path'] as String;
    thumbnail=null;
    productId = json['product_id'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['path'] = path;
    json['product_id'] = productId;
    json['__v'] = v;
    return json;
  }
}
class Characteristics {
  String? id;
  String? name;
  int? v;

  Characteristics({
    this.id,
    this.name,
    this.v,
  });

  Characteristics.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    name = (json['name'] as String?)??"N/A";
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['name'] = name;
    json['__v'] = v;
    return json;
  }
}
class Shelters {
  String? id;
  String? volunteerId;
  String? name;
  String? description;
  String? phone;
  String? zipCode;
  String? city;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? status;
  String? createdAt;
  int? v;

  Shelters({
    this.id,
    this.volunteerId,
    this.name,
    this.description,
    this.phone,
    this.zipCode,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.v,
  });

  Shelters.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    volunteerId = json['volunteer_id'] as String?;
    name = (json['name'] as String?)??"N/A";
    description = (json['description'] as String?)??"N/A";
    phone = (json['phone'] as String?)??"N/A";
    zipCode = (json['zip_code'] as String?)??"N/A";
    city = (json['city'] as String?)??"N/A";
    state = (json['state'] as String?)??"N/A";
    country = (json['country'] as String?)??"N/A";
    latitude = (json['latitude'] as String?)??"N/A";
    longitude = (json['longitude'] as String?)??"N/A";
    status = (json['status'] as String?)??"N/A";
    createdAt = json['created_at'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['volunteer_id'] = volunteerId;
    json['name'] = name;
    json['description'] = description;
    json['phone'] = phone;
    json['zip_code'] = zipCode;
    json['city'] = city;
    json['state'] = state;
    json['country'] = country;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    json['status'] = status;
    json['created_at'] = createdAt;
    json['__v'] = v;
    return json;
  }
}
class Petcategories {
  String? id;
  String? name;
  int? v;

  Petcategories({
    this.id,
    this.name,
    this.v,
  });

  Petcategories.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    name = (json['name'] as String?)??"N/A";
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['name'] = name;
    json['__v'] = v;
    return json;
  }
}




class OrderHistoryModel {
  List<Result>? result;

  OrderHistoryModel({
    this.result,
  });

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    result = (json['result'] as List?)?.map((dynamic e) => Result.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['result'] = result?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Result {
  String? id;
  String? productId;
  String? volunteerId;
  String? shelterId;
  String? userId;
  String? orderDate;
  String? orderTime;
  String? orderStatus;
  String? paymentId;
  String? status;
  String? createdAt;
  int? v;
  List<Shelter>? shelter;
  List<Pet>? products;
  List<ProductGallery>? productGallery;
  List<SignUpModel>? volunteer;
  List<SignUpModel>? customer;

  Result({
    this.id,
    this.productId,
    this.volunteerId,
    this.shelterId,
    this.userId,
    this.orderDate,
    this.orderTime,
    this.orderStatus,
    this.paymentId,
    this.status,
    this.createdAt,
    this.v,
    this.shelter,
    this.products,
    this.productGallery,
    this.volunteer,
    this.customer,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    productId = json['product_id'] as String?;
    volunteerId = json['volunteer_id'] as String?;
    shelterId = json['shelter_id'] as String?;
    userId = json['user_id'] as String?;
    orderDate = json['order_date'] as String?;
    orderTime = json['order_time'] as String?;
    orderStatus = json['order_status'] as String?;
    paymentId = json['payment_id'] as String?;
    status = json['status'] as String?;
    createdAt = json['created_at'] as String?;
    v = json['__v'] as int?;
    shelter = (json['shelter'] as List?)?.map((dynamic e) => Shelter.fromJson(e as Map<String,dynamic>)).toList();
    products = (json['products'] as List?)?.map((dynamic e) => Pet.fromJson(e as Map<String,dynamic>)).toList();
    productGallery = (json['productGallery'] as List?)?.map((dynamic e) => ProductGallery.fromJson(e as Map<String,dynamic>)).toList();
    volunteer = (json['volunteer'] as List?)?.map((dynamic e) => SignUpModel.fromJson(e as Map<String,dynamic>)).toList();
    customer = (json['customer'] as List?)?.map((dynamic e) => SignUpModel.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['product_id'] = productId;
    json['volunteer_id'] = volunteerId;
    json['shelter_id'] = shelterId;
    json['user_id'] = userId;
    json['order_date'] = orderDate;
    json['order_time'] = orderTime;
    json['order_status'] = orderStatus;
    json['payment_id'] = paymentId;
    json['status'] = status;
    json['created_at'] = createdAt;
    json['__v'] = v;
    json['shelter'] = shelter?.map((e) => e.toJson()).toList();
    json['products'] = products?.map((e) => e.toJson()).toList();
    json['productGallery'] = productGallery?.map((e) => e.toJson()).toList();
    json['volunteer'] = volunteer?.map((e) => e.toJson()).toList();
    json['customer'] = customer?.map((e) => e.toJson()).toList();
    return json;
  }
}

