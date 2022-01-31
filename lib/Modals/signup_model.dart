class SignUpModel {
  Result? result;
  String? message;

  SignUpModel({
    this.result,
    this.message,
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['result'] = result?.toJson();
    json['message'] = message;
    return json;
  }
}

class Result {
  String? id;
  String? userType;
  String? name;
  int? code;
  int? phone;
  String? email;
  String? profileImage;
  List<PetPreferences>? petPreference;
  String? password;
  String? status;
  String? onlineStatus;
  List<dynamic>? chatFriends;
  String? createdAt;
  int? v;
  String? token;
  String? about;
  String? dateofbirth;
  String? identityType;
  String? zipcode;
  List? identityImgPath;
  String? latitude;
  String? locationName;
  String? longitude;
  String? termsCondition;

  Result({
    this.id,
    this.userType,
    this.name,
    this.phone,
    this.email,
    this.profileImage,
    this.petPreference,
    this.password,
    this.status,
    this.onlineStatus,
    this.chatFriends,
    this.createdAt,
    this.v,
    this.code,
    this.token,
    this.about,
    this.dateofbirth,
    this.identityType,
    this.zipcode,
    this.identityImgPath,
    this.latitude,
    this.locationName,
    this.longitude,
    this.termsCondition,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    userType = json['user_type'] as String?;
    name = (json['name'] as String?)??"N/A";
    phone = (json['phone'] as int?)??0;
    email = (json['email'] as String?)??"N/A";
    code = (json['code'] as int?)??0;
    password = (json['password'] as String?)??"N/A";
    profileImage = (json['profile_image'] as String?);
    petPreference = (json['pet_preferences'] as List?)?.map((dynamic e) => PetPreferences.fromJson(e as Map<String,dynamic>)).toList();
    status = (json['status'] as String?)??"N/A";
    onlineStatus = (json['onlineStatus'] as String?)??"N/A";
    chatFriends = json['chatFriends'] as List?;
    createdAt = json['created_at'] as String?;
    v = json['__v'] as int?;
    token = json['token'] as String?;
    about = (json['about'])??"N/A";
    dateofbirth = json['dateofbirth'] as String?;
    identityType = (json['identity_type'] as String?)??"N/A";
    zipcode = (json['zipcode'] as String?)??"N/A";
    identityImgPath = json['identity_img_path']!=null?json['identity_img_path'] as List<dynamic>?:[];
    latitude = (json['latitude'] as String?)??"0";
    locationName = (json['location_name'] as String?)??"N/A";
    longitude = (json['longitude'] as String?)??"0";
    termsCondition = (json['terms_condition'] as String?)??"N/A";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['user_type'] = userType;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    json['profile_image'] = profileImage;
    json['password'] = password;
    json['status'] = status;
    json['onlineStatus'] = onlineStatus;
    json['chatFriends'] = chatFriends;
    json['created_at'] = createdAt;
    json['__v'] = v;
    json['token'] = token;
    json['about'] = about;
    json['dateofbirth'] = dateofbirth;
    json['pet_preferences'] = petPreference?.map((e) => e.toJson()).toList();
    json['identity_type'] = identityType;
    json['zipcode'] = zipcode;
    json['identity_img_path'] = identityImgPath;
    json['latitude'] = latitude;
    json['code'] = code;
    json['location_name'] = locationName;
    json['longitude'] = longitude;
    json['terms_condition'] = termsCondition;
    return json;
  }
}

class PetPreferences {
  String? age;
  String? color;
  String? breed;

  PetPreferences({
    this.age,
    this.color,
    this.breed,
  });

  PetPreferences.fromJson(Map<String, dynamic> json) {
    age = (json['age'] as String?)??"N/A";
    color = (json['color'] as String?)??"N/A";
    breed = (json['breed'] as String?)??"N/A";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['age'] = age;
    json['color'] = color;
    json['breed'] = breed;
    return json;
  }
}