class ChatMessages {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? type;
  String? createdDate;
  int? v;

  ChatMessages({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.type,
    this.createdDate,
    this.v,
  });

  ChatMessages.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    senderId = json['senderId'] as String?;
    receiverId = json['receiverId'] as String?;
    message = json['message'] as String?;
    type = json['type'] as String?;
    createdDate = (json['createdDate'] as String?)??"N/A";
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['senderId'] = senderId;
    json['receiverId'] = receiverId;
    json['message'] = message;
    json['type'] = type;
    json['createdDate'] = createdDate;
    json['__v'] = v;
    return json;
  }
}