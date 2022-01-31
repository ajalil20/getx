class SOUsersChatWithModel {
  User? user;
  String? chat;

  SOUsersChatWithModel({
    this.user,
    this.chat,
  });

  SOUsersChatWithModel.fromJson(Map<String, dynamic> json) {
    user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null;
    chat = json['chat'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['user'] = user?.toJson();
    json['chat'] = chat;
    return json;
  }
}

class User {
  String? id;
  String? name;
  int? phone;
  String? email, status, onlineStatus, profileImage;


  User({
    this.id,
    this.name,
    this.phone,
    this.email,this.status, this.onlineStatus, this.profileImage
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    name = (json['name'] as String?)??"N/A";
    phone = (json['phone'] as int?)??0;
    email = (json['email'] as String?)??"N/A";
    status = json['status'] as String?;
    onlineStatus = (json['onlineStatus'] as String?)??"N/A";
    profileImage = json['profile_image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    json['status'] = status;
    json['onlineStatus'] = onlineStatus;
    json['profile_image'] = profileImage;
    return json;
  }
}