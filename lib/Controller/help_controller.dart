import 'package:get/get.dart';
import 'package:pawndr/Modals/petscreen_model.dart';
import 'package:pawndr/Service/api_endpoints.dart';
import 'package:pawndr/Service/base_services.dart';

class HelpController extends GetxController{
  RxInt selectedIndex = 0.obs;
  RxBool isAccepted = true.obs;
  Rx<HelpModel> res = HelpModel().obs;
  BaseService baseService =BaseService();


  // List<HelpModel> items=[
  //   HelpModel('How does this app protect my privacy?', '''It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.'''),
  //   HelpModel('Am I able to delete my account?', 'NAN'),
  //   HelpModel('What happens to my data if I delete my account', 'NAN'),
  //   HelpModel('Does this app track my location?', 'NAN'),
  //   HelpModel('Is my account safe?', 'NAN'),
  //   HelpModel('Am I able to delete my account?', 'NAN'),
  // ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  Future<void> getData() async{
    res.value =await HelpModel.fromJson(await baseService.baseGetAPI(APIEndpoints.getFaqList, loading: true,));
  }

}

class HelpModel {
  List<Result>? result;

  HelpModel({
    this.result,
  });

  HelpModel.fromJson(Map<String, dynamic> json) {
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
  String? question;
  String? answer;
  String? createdAt;
  int? v;

  Result({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.v,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    question = json['question'] as String?;
    answer = json['answer'] as String?;
    createdAt = json['created_at'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['question'] = question;
    json['answer'] = answer;
    json['created_at'] = createdAt;
    json['__v'] = v;
    return json;
  }
}