// import 'package:flutter/material.dart';
// import 'package:pawndr/Component/custom_text.dart';
// import 'package:pawndr/Utils/color_config.dart';
// import 'package:pawndr/Utils/responsive.dart';
// class petsCard extends StatelessWidget {
//   bool? isSelected;
//   petsCard({this.isSelected});
//   Responsive responsive = Responsive();
//   ColorConfig colors = ColorConfig();
//   @override
//   Widget build(BuildContext context) {
//     responsive.setContext(context);
//     return  Stack(children: [
//       Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     child: Container(
//
//                       width: responsive.setWidth(46),
//                       padding: EdgeInsets.only(left:responsive.setWidth(1),right: responsive.setWidth(1),top: responsive.setHeight(2)),
//                       // height: responsive.setHeight(18),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color(0xffF1F1F1),
//                       ),
//                       child: Row(
//                         children: [
//                           Flexible(
//                             flex: 3,
//                             child: Container(
//                               height: responsive.setHeight(25),
//                               width: responsive.setWidth(25),
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image:
//                                       AssetImage('assets/images/welcome.png'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             flex: 3,
//                             child: Column(
//
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText(
//                                   title: 'Max',
//                                   size: responsive.setTextScale(15),
//                                   weight: 'Semi Bold',
//                                   clr: colors.primaryColor,
//                                 ),
//                                 MyText(
//                                   title: 'Golden Retriver',
//                                   clr: colors.primaryColor,
//                                   size: responsive.setTextScale(15),
//                                 ),
//                                  SizedBox(height: responsive.setHeight(1),),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                      MyText(
//                                             title: 'Weight',
//                                             size: responsive.setTextScale(12),
//                                           ),
//                                         MyText(title: ":",size:  responsive.setTextScale(12),weight: "Bold",),
//                                           MyText(
//                                             title: '10 Kg',
//                                             size: responsive.setTextScale(12),
//                                           ),                                ]),
//                                 SizedBox(height: responsive.setHeight(1),),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                      MyText(
//                                             title: 'Age',
//                                             size: responsive.setTextScale(12),
//                                           ),
//                                         Flexible(
//                                           flex: 1,
//                                           child: MyText(title: ":",size:  responsive.setTextScale(12),weight: "Bold",)),
//                                           MyText(
//                                             title: '5 Years',
//                                             size: responsive.setTextScale(12),
//                                           ),                                ]),
//                                 SizedBox(height: responsive.setHeight(1),),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                      MyText(
//                                             title: 'Breed',
//                                             size: responsive.setTextScale(12),
//                                           ),
//                                         MyText(title: " : ",size:  responsive.setTextScale(12),weight: "Bold",),
//
//                                           Flexible(
//                                            flex: 1,
//                                             child: MyText(
//                                               title: 'Labrador',
//                                               size: responsive.setTextScale(12),
//                                               toverflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),                                ]),
//                                 SizedBox(height: responsive.setHeight(1),),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                      MyText(
//                                             title: 'Color',
//                                             size: responsive.setTextScale(12),
//                                           ),
//                                         MyText(title: ":",size:  responsive.setTextScale(12),weight: "Bold",),
//                                           Flexible(
//                                             flex: 1,
//                                             child: MyText(
//                                               title: 'Brown',
//                                               size: responsive.setTextScale(12),
//                                             ),
//                                           ),                                ])
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     left: responsive.setWidth(25),
//                     child:isSelected==true? Container(
//
//                       height: 20,
//                       width: 20,
//                       decoration: BoxDecoration(color: colors.secondaryColor,borderRadius: BorderRadius.circular(50)),
//                       child: Icon(Icons.check,color: colors.whiteColor,size: 12,),
//                     ):SizedBox(),
//                   )
//     ],);
//   }
// }