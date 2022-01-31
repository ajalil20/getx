
class AddRecentProducts {
  Result? result;

  AddRecentProducts({
    this.result,
  });

  AddRecentProducts.fromJson(Map<String, dynamic> json) {
    result = (json['result'] as Map<String,dynamic>?) != null ? Result.fromJson(json['result'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['result'] = result?.toJson();
    return json;
  }
}

class Result {
  String? productId;
  String? userId;
  String? id;
  String? createdAt;
  int? v;

  Result({
    this.productId,
    this.userId,
    this.id,
    this.createdAt,
    this.v,
  });

  Result.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] as String?;
    userId = json['user_id'] as String?;
    id = json['_id'] as String?;
    createdAt = json['created_at'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['product_id'] = productId;
    json['user_id'] = userId;
    json['_id'] = id;
    json['created_at'] = createdAt;
    json['__v'] = v;
    return json;
  }
}