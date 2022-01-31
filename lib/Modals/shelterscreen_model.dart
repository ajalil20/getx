import 'dart:io';
class ShelterModel {
  List<Shelter>? result;

  ShelterModel({
    this.result,
  });

  ShelterModel.fromJson(Map<String, dynamic> json) {
    result = (json['result'] as List?)?.map((dynamic e) => Shelter.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['result'] = result?.map((e) => e.toJson()).toList();
    return json;
  }
}
class Shelter {
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
  String? rating;
  String? status;
  int? satisfiedClients;
  String? areaCapacity;
  String? createdAt;
  int? v;
  List<ShelterGallery>? shelterGallery;

  Shelter({
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
    this.rating,
    this.status,
    this.satisfiedClients,
    this.areaCapacity,
    this.createdAt,
    this.v,
    this.shelterGallery,
  });

  Shelter.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    volunteerId = json['volunteer_id'] as String?;
    name = (json['name'] as String?)??"N/A";
    description = (json['description'] as String?)??"N/A";
    phone = (json['phone'] as String?)??"N/A";
    zipCode = (json['zip_code'] as String?)??"N/A";
    city = (json['city'] as String?)??"";
    state = (json['state'] as String?)??"";
    country = (json['country'] as String?)??"";
    latitude = (json['latitude'] as String?)??"0";
    rating = (json['rating'] as String?)??"0.0";
    // rating = json['rating']==null? 0.0:json['rating'];

    // (json['rating'] as double?)??0.0;
    satisfiedClients = (json['satisfied_clients'] as int?)??0;
    longitude = (json['longitude'] as String?)??"0";
    areaCapacity = (json['area_capacity'] as String?)??"N/A";
    status = json['status'] as String?;
    createdAt = json['created_at'] as String?;
    v = json['__v'] as int?;
    shelterGallery = (json['shelterGallery'] as List?)?.map((dynamic e) => ShelterGallery.fromJson(e as Map<String,dynamic>)).toList();
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
    json['rating'] = rating;
    json['status'] = status;
    json['area_capacity'] = areaCapacity;
    json['created_at'] = createdAt;
    json['__v'] = v;
    json['shelterGallery'] = shelterGallery?.map((e) => e.toJson()).toList();
    return json;
  }
}
class ShelterGallery {
  String? id;
  String? path;
  String? shelterId;
  File? thumbnail;
  int? v;

  ShelterGallery({
    this.id,
    this.path,
    this.shelterId,
    this.v,
    this.thumbnail
  });

  ShelterGallery.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    path = json['path'] as String;
    thumbnail=null;
    shelterId = json['shelter_id'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['path'] = path;
    json['shelter_id'] = shelterId;
    json['__v'] = v;
    return json;
  }
}
