// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:pawndr/Controller/ShelterPicVideoController.dart';
import 'package:pawndr/Views/AuthenticationScreens/ForgotPassword.dart';
import 'package:pawndr/Views/AuthenticationScreens/LoginScreen.dart';
import 'package:pawndr/Views/AuthenticationScreens/SignUpScreen.dart';
import 'package:pawndr/Views/AuthenticationScreens/changePassword.dart';
import 'package:pawndr/Views/AuthenticationScreens/otpScreen.dart';
import 'package:pawndr/Views/Drawer/Chat/ChatInboxScreen.dart';
import 'package:pawndr/Views/Drawer/Chat/ChatingScreen.dart';
import 'package:pawndr/Views/Drawer/Favorites/FavoritesPetsScreen.dart';
import 'package:pawndr/Views/Drawer/Help&Terms/HelpScreen.dart';
import 'package:pawndr/Views/Drawer/Help&Terms/TermsScreen.dart';
import 'package:pawndr/Views/Drawer/Notification/NotificationScreen.dart';
import 'package:pawndr/Views/Drawer/OrderHistory/OrderHistoryScreen.dart';
import 'package:pawndr/Views/Drawer/Setting/ProfileScreen.dart';
import 'package:pawndr/Views/Drawer/Setting/ProfileSetting.dart';
import 'package:pawndr/Views/Drawer/Setting/SettingScreen.dart';
import 'package:pawndr/Views/PaymentScreen/ConfirmPaymentScreen.dart';
import 'package:pawndr/Views/PaymentScreen/paymentScreen.dart';
import 'package:pawndr/Views/Pets/PetsScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/FinderHomeScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/PetProfileScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/SetUpMeeting/MeetingDate.dart';
import 'package:pawndr/Views/ProcessScreens/Finder/SetUpMeeting/MeetingTime.dart';
import 'package:pawndr/Views/ProcessScreens/GetStartScreen.dart';
import 'package:pawndr/Views/IntroScreens/IntroScreen.dart';
import 'package:pawndr/Views/ProcessScreens/SelectPreferenceScreen.dart';
import 'package:pawndr/Views/ProcessScreens/Shelter/ShelterHomeScreen.dart';
import 'package:pawndr/Views/SplashScreen/SplachScreen1.dart';
import 'package:pawndr/Views/SplashScreen/SplashScreen.dart';
import 'package:pawndr/Views/VolunteerScreen/AddPet.dart';
import 'package:pawndr/Views/VolunteerScreen/ShalterPetsScreen.dart';
import 'package:pawndr/Views/VolunteerScreen/VolunteerHome.dart';
import 'package:pawndr/Views/VolunteerScreen/VolunteerInformation.dart';
import 'package:pawndr/Views/VolunteerScreen/ShelterDetailScreen.dart';
import 'package:pawndr/Views/location_picker.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/intro', page: () => IntroScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/forgotPassword', page: () => ForgotPassword()),
    GetPage(name: '/OTPScreen', page: () => OTPScreen()),
    GetPage(name: '/ChangePassword', page: () => ChangePassword()),
    GetPage(name: '/getStart', page: () => GettingStartScreen()),
    GetPage(name: '/selectionPreference', page: () => SelectPreferenceScreen()),
    GetPage(name: '/volunteerSelectionPreference', page: () => SplashScreen1()),

    //  Finder Screens
    GetPage(name: '/finderHome', page: () => FinderHomeScreen()),
    GetPage(name: '/petProfile', page: () => PetProfileScreen()),
    GetPage(name: '/setupMeeting', page: () => SetUpMeetingScreen()),
    GetPage(name: '/meetingTime', page: () => MeetingTimeScreen()),
    GetPage(name: '/setting', page: () => SettingScreen()),
    GetPage(name: '/profileSetting', page: () => ProfileSetting()),
    GetPage(name: '/userProfile', page: () => ProfileScreen()),
    //  Finder Scrrens End

    //Volunteer & Shelter Screens
    GetPage(name: '/shelter', page: () => ShelterHomeScreen()),
    GetPage(name: '/volunteerInformation', page: () => VolunteerInformation()),
    GetPage(name: '/volunteerHome', page: () => VolunteerHome()),
    GetPage(name: '/shelterDetail', page: () => ShelterDetailScreen()),
    GetPage(name: '/shelterHome', page: () => ShelterHomeScreen()),
    GetPage(name: '/shelterPetPictureUpload', page: () => ShelterPetsPicture()),

    //Volunteer & Shelter Screen End

    //  Drawer
    GetPage(name: '/notification', page: () => NotificationScreen()),
    GetPage(name: '/chat', page: () => ChatInboxScreen()),
    GetPage(name: '/chatingScreen', page: () => ChatingScreen()),
    GetPage(name: '/help', page: () => HelpScreen()),
    GetPage(name: '/terms', page: () => TermsScreen()),
    GetPage(name: '/favorite', page: () => FavoritePetsScreen()),
    GetPage(name: '/orderHistory', page: () => OrderHistoryScreen()),
    GetPage(name: '/payment', page: () => PaymentScreen()),
    GetPage(name: '/confirmPayment', page: () => ConfirmPaymentScreen()),
    GetPage(name: '/LocationPicker', page: () => LocationPicker()),



    //  End Drawer

  //  BottomBar Screens
    GetPage(name: '/pets', page: () => PetsScreen()),
    GetPage(name: '/petInformation', page: () => AddPet())
  //  BottomBar Screens End
  ];
}
