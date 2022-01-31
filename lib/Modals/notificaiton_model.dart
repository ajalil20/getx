class NotificationModel {
  List<Result>? result;

  NotificationModel({
    this.result,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? body;
  List<Payload>? payload;
  String? userId;
  String? image;
  bool? viewStatus;
  String? createdDate;
  int? v;

  Result({
    this.id,
    this.title,
    this.body,
    this.payload,
    this.userId,
    this.image,
    this.viewStatus,
    this.createdDate,
    this.v,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    title = json['title'] as String?;
    body = json['body'] as String?;
    payload = (json['payload'] as List?)?.map((dynamic e) => Payload.fromJson(e as Map<String,dynamic>)).toList();
    userId = json['user_id'] as String?;
    image = json['image'] as String?;
    viewStatus = json['viewStatus'] as bool?;
    createdDate = json['createdDate'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['title'] = title;
    json['body'] = body;
    json['payload'] = payload?.map((e) => e.toJson()).toList();
    json['user_id'] = userId;
    json['image'] = image;
    json['viewStatus'] = viewStatus;
    json['createdDate'] = createdDate;
    json['__v'] = v;
    return json;
  }
}

class Payload {
  String? activity;

  Payload({
    this.activity,
  });

  Payload.fromJson(Map<String, dynamic> json) {
    activity = json['activity'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['activity'] = activity;
    return json;
  }
}