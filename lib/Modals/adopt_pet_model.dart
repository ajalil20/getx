class AdoptPet {
  final Result? result;

  AdoptPet({
    this.result,
  });

  AdoptPet.fromJson(Map<String, dynamic> json)
      : result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'result' : result?.toJson()
  };
}

class Result {
  final String? productId;
  final String? shelterId;
  final String? userId;
  final String? orderDate;
  final String? orderTime;
  final String? orderStatus;
  final String? status;
  final String? id;
  final String? createdAt;
  final int? v;
  final Errors? errors;
  final String? message;
  final String? name;

  Result({
    this.productId,
    this.shelterId,
    this.userId,
    this.orderDate,
    this.orderTime,
    this.orderStatus,
    this.status,
    this.id,
    this.createdAt,
    this.v,
    this.errors,
    this.message,
    this.name,
  });

  Result.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        shelterId = json['shelter_id'] as String?,
        userId = json['user_id'] as String?,
        orderDate = json['order_date'] as String?,
        orderTime = json['order_time'] as String?,
        orderStatus = json['order_status'] as String?,
        status = json['status'] as String?,
        id = json['_id'] as String?,
        createdAt = json['created_at'] as String?,
        v = json['__v'] as int?,
        errors = (json['errors'] as Map<String,dynamic>?) != null ? Errors.fromJson(json['errors'] as Map<String,dynamic>) : null,
        message = json['_message'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'product_id' : productId,
    'shelter_id' : shelterId,
    'user_id' : userId,
    'order_date' : orderDate,
    'order_time' : orderTime,
    'order_status' : orderStatus,
    'status' : status,
    '_id' : id,
    'created_at' : createdAt,
    '__v' : v,
    'errors' : errors?.toJson(),
    '_message' : message,
    'name' : name
  };
}

class Errors {
  final UserId? userId;

  Errors({
    this.userId,
  });

  Errors.fromJson(Map<String, dynamic> json)
      : userId = (json['user_id'] as Map<String,dynamic>?) != null ? UserId.fromJson(json['user_id'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'user_id' : userId?.toJson()
  };
}

class UserId {
  final String? stringValue;
  final String? valueType;
  final String? kind;
  final String? value;
  final String? path;
  final String? name;

  UserId({
    this.stringValue,
    this.valueType,
    this.kind,
    this.value,
    this.path,
    this.name,
  });

  UserId.fromJson(Map<String, dynamic> json)
      : stringValue = json['stringValue'] as String?,
        valueType = json['valueType'] as String?,
        kind = json['kind'] as String?,
        value = json['value'] as String?,
        path = json['path'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'stringValue' : stringValue,
    'valueType' : valueType,
    'kind' : kind,
    'value' : value,
    'path' : path,
    'name' : name
  };
}