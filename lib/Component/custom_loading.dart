
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// class Loading extends StatelessWidget {
//   String mystring;
//   double size;
//   Loading({this.mystring,this.size=250.0});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
//             child: theme==1 || theme==null?Lottie.asset('asset/loading_cart.json',width: size,height: size):theme==2?Lottie.asset('asset/loading_theme_2.json',width: 250,height: 250):theme==3?Lottie.asset('asset/loading_theme_3.json',width: 250,height: 250):Lottie.asset('asset/loading_theme_4.json',width: 250,height: 250)),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: MyText(
//             center: true,
//             title: mystring??"",
//             size: 14,
//           ),
//         )
//       ],
//     );
//   }
// }
