import 'dart:convert';
import 'dart:developer';
import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pawndr/Utils/utils.dart';
import '../Component/custom_toast.dart';
import '../Component/custom_text.dart';
import '../Utils/app_config.dart';
import '../Utils/color_config.dart';
import '../Utils/navigation_service.dart';
import '../Utils/locator.dart';

class BaseService {
  late String baseURL = "https://pawander-api.thewebtestlink.xyz/api/";
  // late String baseURL = "https://22f5-2400-adc1-125-f500-9407-8bcc-4c70-2154.ngrok.io/api";
  String? token;

  static NavigationService _navigationService = locator<NavigationService>();

  static Alice alice = Alice(
      showNotification: true,
      navigatorKey: Get.rootController.key,
      darkTheme: true);

  Future baseGetAPI(url,
      {successMsg, loading, status,utfDecoded,bool return404=false,bool errorToast=true,bool direct=false}) async {
    final connect =await Utils.checkInternetConnection();
    if(connect==false){
      return true;
    }

    else if (loading == true && loading != null) {
      EasyLoading.instance.userInteractions=false;
      EasyLoading.show(status: 'Please wait...',dismissOnTap: false,);
    }

    String bearerAuth =
        'Bearer ${token}';

    http.Response response;
    try {
      response = await http.get(
        Uri.parse(baseURL + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerAuth
        },
      );
      _logRequestOnAlice(response);

      if(loading==true){
        EasyLoading.dismiss();
      }
      if(direct==true){
        return response.body;
      }

      if (status != null) {
        return response.statusCode;
      }

      var jsonData;
      if (response.statusCode == 200) {
        if(utfDecoded==true)
          {
            jsonData = json.decode(utf8.decode(response.bodyBytes));

            return jsonData;
          }
        jsonData = json.decode(response.body);
        if (successMsg != null) {
          CustomToast().showToast("",successMsg, false);
        }
        return jsonData;
      }
      else if (response.statusCode == 401) {
        jsonData = json.decode(response.body);


        return {};
      }
      else {
        jsonData = json.decode(response.body);

      }
    } catch (SocketException) {
      EasyLoading.dismiss();
      AlertDialog(
        content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 20,
                ),
                SizedBox(height: 10),
                MyText(
                  title:
                      "There seems to be your network problem or a server side issue. Please try again or report the bug to the manager.",
                  clr: ColorConfig().primaryColor,
                  size: 13,
                ),
                SizedBox(height: 20),
              ],
            )),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                // color: terColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: new MyText(
                    title: "Okay",
                    size: 13,
                    clr: Colors.red,
                  ),
                ),
                // color: secondaryColor,
                onPressed: () {
                 Get.back();
                },
              ),
            ],
          ),
        ],
      );
      return null;
    }
  }

  Future basePostAPI(url, body,
      {successMsg, loading}) async {
    final connect =await Utils.checkInternetConnection();
    if(connect==false){
      return true;
    }

    else if (loading == true && loading != null) {
      EasyLoading.instance.userInteractions=false;
      EasyLoading.show(status: 'Please wait...',dismissOnTap: false);
    }

    String bearerAuth =
        'Basic $token';

    http.Response response;

    try {
      response = await http.post(Uri.parse(baseURL + url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerAuth
          },
          body: jsonEncode(body));

      _logRequestOnAlice(response);
      if(loading==true){
        EasyLoading.dismiss();
      }

      var jsonData;
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        if (successMsg != null) {
          CustomToast().showToast("Message",successMsg, false);
        }
        return jsonData;
      } else if (response.statusCode == 400) {
        jsonData = json.decode(response.body);
        // CustomToast().showToast("Error",jsonData["message"], true);
        // return {};
        return jsonData;
      } else if (response.statusCode == 401) {
        jsonData = json.decode(response.body);

        return {};
      } else {

        throw Exception('Failed');
      }
    } catch (SocketException) {
      print(SocketException);
      EasyLoading.dismiss();
      return null;
    }
  }


  Future baseFormPostAPI(url, Map<String, String> body, files, keys, context,
      {successMsg, loading, pop = true}) async {
    final connect =await Utils.checkInternetConnection();
    if(connect==false){
      return true;
    }
    else if (loading == true && loading != null) {
      EasyLoading.instance.userInteractions=false;
      EasyLoading.show(status: 'Please wait...',dismissOnTap: false);
    }

    String bearerAuth = 'Bearer ' + "$token";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseURL + url));

      request.headers.addAll({"token": "${token!}"});

      for (int i = 0; i < files.length && files != null; i++) {
        request.files
            .add(await http.MultipartFile.fromPath(keys[i], files[i].path));
      }
      request.fields.addAll(body);

      var response = await request.send();
      if(loading==true){
        EasyLoading.dismiss();
      }

      print(response.statusCode.toString() +"check status");
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        if (successMsg != null) {
          CustomToast().showToast("Message", successMsg, false);
        }
        if (pop == true) {
          // Modular.to.pop();
        }

        var temp = await response.stream.bytesToString();
        print(temp);

        return temp;
      } else if (response.statusCode == 400) {
        var temp = await response.stream.bytesToString();
        return temp;
      } else if (response.statusCode == 401) {
        var temp = await response.stream.bytesToString();
        return temp;
      } else if (response.statusCode == 500) {
        var temp = await response.stream.bytesToString();
        CustomToast().showToast('Error', 'Something went wrong.', true);
        return temp;
      } else {
        throw Exception('Failed');
      }
    } catch (SocketException) {
      log(SocketException.toString());
      EasyLoading.dismiss();
      return null;
    }
  }

  static void _logRequestOnAlice(http.Response response) {
    if (isDevelopmentMode==true) {
      alice.onHttpResponse(response);
    }
  }
}
