class UpdateProfileModel {
  Result? result;

  UpdateProfileModel({
    this.result,
  });

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['result'] = result?.toJson();
    return json;
  }
}

class Result {
  String? name;
  String? profileImage;
  List? identityImgPath;
  String? locationName;
  String? latitude;
  String? longitude;
  String? dateofbirth;
  String? zipcode;
  String? identityType;
  String? about;
  String? stringValue;
  String? valueType;
  String? kind;
  String? value;
  String? path;
  Reason? reason;
  String? message;

  Result({
    this.name,
    this.profileImage,
    this.locationName,
    this.latitude,
    this.longitude,
    this.dateofbirth,
    this.zipcode,
    this.identityImgPath,
    this.identityType,
    this.about,
    this.stringValue,
    this.valueType,
    this.kind,
    this.value,
    this.path,
    this.reason,
    this.message,
  });

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    profileImage = json['profile_image'] as String?;
    locationName = json['location_name'] as String?;
    latitude = json['latitude'] as String?;
    longitude = json['longitude'] as String?;
    dateofbirth = json['dateofbirth'] as String?;
    zipcode = json['zipcode'] as String?;
    identityType = json['identity_type'] as String?;
    identityImgPath = json['identity_img_path']!=null?json['identity_img_path'] as List<dynamic>?:[];
    about = json['about'] as String?;
    stringValue = json['stringValue'] as String?;
    valueType = json['valueType'] as String?;
    kind = json['kind'] as String?;
    value = json['value'] as String?;
    path = json['path'] as String?;
    reason = (json['reason'] as Map<String,dynamic>?) != null ? Reason.fromJson(json['reason'] as Map<String,dynamic>) : null;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['profile_image'] = profileImage;
    json['location_name'] = locationName;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    json['dateofbirth'] = dateofbirth;
    json['identity_img_path'] = identityImgPath;
    json['zipcode'] = zipcode;
    json['identity_type'] = identityType;
    json['about'] = about;
    json['stringValue'] = stringValue;
    json['valueType'] = valueType;
    json['kind'] = kind;
    json['value'] = value;
    json['path'] = path;
    json['reason'] = reason?.toJson();
    json['message'] = message;
    return json;
  }
}

class Reason {
  bool? generatedMessage;
  String? code;
  bool? actual;
  bool? expected;
  String? operator;

  Reason({
    this.generatedMessage,
    this.code,
    this.actual,
    this.expected,
    this.operator,
  });

  Reason.fromJson(Map<String, dynamic> json) {
    generatedMessage = json['generatedMessage'] as bool?;
    code = json['code'] as String?;
    actual = json['actual'] as bool?;
    expected = json['expected'] as bool?;
    operator = json['operator'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['generatedMessage'] = generatedMessage;
    json['code'] = code;
    json['actual'] = actual;
    json['expected'] = expected;
    json['operator'] = operator;
    return json;
  }
}