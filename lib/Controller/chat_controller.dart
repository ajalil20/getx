import 'dart:convert';
import 'dart:developer';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawndr/Component/custom_toast.dart';
import 'package:pawndr/Controller/user_controller.dart';
import 'package:pawndr/Modals/chat/ChatMessagesModel.dart';
import 'package:pawndr/Modals/chat/souserschat_model.dart';
import 'package:pawndr/Utils/local_db_keys.dart';

class ChatController extends GetxController {
  UserController controller = Get.find();

  Rx<TextEditingController> messageController = TextEditingController().obs;
  RxBool voiceMessage = true.obs;
  RxBool messagesFetched = false.obs;
  RxBool usersFetched = false.obs;
  RxString userOnline = "OFFLINE".obs;
  RxBool search = false.obs;
  SocketIOManager manager = SocketIOManager();
  late SocketIO socket;
  late String receiverID, senderID = controller.user.value.result!.id!;
  final ScrollController scrollController = ScrollController();
  RxList<ChatMessages> messagesList = List<ChatMessages>.empty().obs;
  RxList<SOUsersChatWithModel> messages =
      List<SOUsersChatWithModel>.empty().obs;
  Rx<SOUsersChatWithModel> currentUser = SOUsersChatWithModel().obs;
  RxList<SOUsersChatWithModel> temp =List<SOUsersChatWithModel>.empty().obs;


  // RxList<User> findFriends=List<User>.empty().obs;
  var findFriends;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 0), () {
      initSocket();
    });
  }

  Future<void> initSocket() async {
    log("initial");
    senderID = await controller.user.value.result!.id!;
    socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
      // "http://10.20.2.36:5403",
      "http://pawander-api.thewebtestlink.xyz:5403",
      namespace: '/',
      enableLogging: true,
      transports: [
        Transports.webSocket,
        // Transports.polling,
      ], //Enable required transport
    ));
    socket.onConnect.listen((data) {
      log('connected...');
      log(data.toString());
      chatList();
      getChatList();
      chatEventsListening();
      errorEvent();
      registerUser();
      friendEvent();
    });
    socket.onConnectError.listen(pPrint);
    socket.onConnectTimeout.listen(pPrint);
    socket.onError.listen(pPrint);
    socket.onDisconnect.listen(pPrint);
    await socket.connect();
  }

  void registerUser() {
    log("registerUser");
    socket.emit("register", [
      {"_id": senderID}
    ]);
    socket.emit("online", [
      {"_id": senderID}
    ]);
  }

  Future<void> chatList() async {
    log("chatList");
    var userId = senderID;
    print("user id is " + userId);
    socket.emit("chatList", [
      {"_id": userId}
    ]);
  }

  void getChatList() {
    log("getChatList");
    log("friend h bhai");

    socket.on('chatList').listen((data) {
      log("agaya");
      log(data.toString());
      usersFetched(false);
      messages.clear();
      List user = data;
      // Map <String, dynamic> newUser = user[0];
      log('arso data here 0');
      log(user.toString());
      log('arso data here 0');
      user[0].forEach((element) {
        Map<String, dynamic> t = {};
        element.forEach((key, value) {
          t[key] = value;
        });
        log(t.toString());
        log(t.runtimeType.toString());
        messages.add(SOUsersChatWithModel.fromJson(t));
        messages.refresh();
        log('arso data here');
        log(messages[0].user!.name.toString());
      });
      usersFetched(true);
    });
  }

  void friendEvent() {
    socket.on('friend').listen((data) {
      findFriends.clear();
      log("friend h bhai");
      log(data.toString());
      data[0].forEach((element) {
        ///Jalil
        // findFriends.add(User.fromJson(element));
      });
    });
  }

  void searchUser(String key) async {
    var jsonData = {"fullName": key};
    try {
      await socket.emit("findFriends", [jsonData]);
    } catch (onError) {
      log("error h");
      log(onError.toString());
    }
  }

  void chatEventsListening() {
    socket.on('chatMessages').listen((data) {
      log("messages here");
      log(data.runtimeType.toString());
      log(data.toString());
      log("messages end here");

      messagesList.clear();
      List msg = data[0];
      for (var element in msg) {
        Map<String, dynamic> t = {};
        element.forEach((key, value) {
          t[key] = value;
        });
        log(t.toString());
        var temp = ChatMessages.fromJson(t);
        log(temp.toString());
        // if(temp.message!.contains(".mp4") || temp.message!.contains(".mov") || temp.message!.contains(".webm") || temp.message!.contains(".avi")){
        // temp.thumbnail=await Utils.generateThumbnail(temp.message);
        // }
        messagesList.add(temp);
        messagesList.refresh();
        log(messagesList.first.message.toString());
      }
      ;
      messagesFetched(true);
      Future.delayed(Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    });

    socket.on('message').listen((data) async {
      log(data.runtimeType.toString());
      log("msg gya");
      log(data.toString());
      log("from msg");
      Map<String, dynamic> t = {};
      data[0].forEach((key, value) {
        t[key] = value;
      });
      log(t.toString());

      ///Jalil
      var temp = ChatMessages.fromJson(t);
      log(temp.toString());
      // if(temp.message!.contains(".mp4") || temp.message!.contains(".mov") || temp.message!.contains(".webm") || temp.message!.contains(".avi")){
      //   temp.thumbnail=await Utils.generateThumbnail(temp.message);
      // }
      messagesList.add(temp);
      messagesList.refresh();
      Future.delayed(Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    });

    // socket.on('user_status').listen((data){
    //   log("user_statu");
    //   log(receiverID);
    //   log(data.toString());
    //   log(data.runtimeType.toString());
    //   log(data[0].toString());
    //   if(data[0]["_id"]==receiverID){
    //     userOnline(data[0]["online_status"]);
    //   }
    // });
    //
    // socket.on('online').listen((data){
    //   log("online");
    //   log(data.toString());
    //   if(data[0]["_id"]==receiverID){
    //     userOnline(data[0]["online_status"]);
    //   }
    // });
    //
    // socket.on('offline').listen((data){
    //   log("offline");
    //   log(data.toString());
    //   if(data[0]["_id"]==receiverID){
    //     userOnline(data[0]["offline_status"]);
    //   }
    // });
  }

  Future<void> chatWithAUser(receiver) async {
    log('arso chat with user');
    log("receiver=$receiver");
    receiverID = receiver;
    messagesList.clear();
    String? senderId = senderID;
    log("sender=$senderId");
    try {
      socket.emit("chatMessages", [
        {"senderId": senderId, "receiverId": receiver}
      ]);
    } catch (onError) {
      log("error h");
      log(onError.toString());
    }
  }

  void sendChatMessage(String receiver) async {
    log("Message krrha hn");
    var jsonData = {
      "senderId": senderID,
      "receiverId": receiver,
      "type": "text",
      "message": "${messageController.value.text}"
    };
    try {
      // log(jsonData.toString());
      await socket.emit("message", [jsonData]);
      messageController.value.text = "";
      chatEventsListening();
    } catch (onError) {
      log("error h");
      log(onError.toString());
    }
    // scrollController.animateTo(
    //   scrollController.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 600),
    //   curve: Curves.ease,
    // );
  }

  void errorEvent() {
    socket.on('err').listen((data) {
      log("error h bhai");
      log(data.toString());
      CustomToast().showToast("Error", data.toString(), true);
    });
  }

  Future<void> disconnect() async {
    await manager.clearInstance(socket);
  }

  Future<void> offline() async {
    socket.emit("offline", [
      {"_id": senderID}
    ]);
  }

  void pPrint(data) {
    if (data is Map) {
      data = json.encode(data);
    }
    log(data.toString());

    // Future.delayed(const Duration(milliseconds: 250), () {
    //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    // });
  }
  void buildSearchList(String userSearchTerm) {
    temp.clear();
    for (int i = 0; i < messages.length; i++) {
      String name = messages[i].user != null?"${messages[i].user!.name}":'';
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        temp.add(messages[i]);
      }
    }
  }


}
