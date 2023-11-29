//  Row(
//                                             children: [
//                                               Expanded(
//                                                 child: RadioListTile(
//                                                     activeColor: buttonsColor,
//                                                     title: Text("دولار"),
//                                                     value: "USD",
//                                                     groupValue: currency,
//                                                     onChanged: (value) {
//                                                       currency =
//                                                           value.toString();
//                                                       print(currency);
//                                                       AppCubit.get(context)
//                                                           .changeRadio();
//                                                     }),
//                                               ),
//                                               Expanded(
//                                                 child: RadioListTile(
//                                                     activeColor: buttonsColor,
//                                                     title: Text("ريال"),
//                                                     value: "SAR",
//                                                     groupValue: currency,
//                                                     onChanged: (value) {
//                                                       currency =
//                                                           value.toString();
//                                                       print(currency);
//                                                       AppCubit.get(context)
//                                                           .changeRadio();
//                                                     }),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 15,
//                                           ),
                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //         child: Card(
                                          //       child: Column(
                                          //         children: [
                                          //           Text("نسخة تسجيل المركبة"),
                                          //           IconButton(
                                          //             icon: Icon(AppCubit.get(
                                          //                             context)
                                          //                         .profileImage ==
                                          //                     null
                                          //                 ? Icons.upload
                                          //                 : Icons.check),
                                          //             onPressed: () {
                                          //               AppCubit.get(context)
                                          //                   .getProfileImage();
                                          //             },
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     )),
                                          //     Expanded(
                                          //         child: Card(
                                          //       child: Column(
                                          //         children: [
                                          //           Text("صورة جواز السفر"),
                                          //           IconButton(
                                          //             icon: Icon(AppCubit.get(
                                          //                             context)
                                          //                         .licenceImage ==
                                          //                     null
                                          //                 ? Icons.upload
                                          //                 : Icons.check),
                                          //             onPressed: () {
                                          //               AppCubit.get(context)
                                          //                   .getLicenceImage();
                                          //             },
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     )),
                                          //     Expanded(
                                          //         child: Card(
                                          //       child: Column(
                                          //         children: [
                                          //           Text("صورة الهوية المحلية"),
                                          //           IconButton(
                                          //             icon: Icon(AppCubit.get(
                                          //                             context)
                                          //                         .passportImage ==
                                          //                     null
                                          //                 ? Icons.upload
                                          //                 : Icons.check),
                                          //             onPressed: () {
                                          //               AppCubit.get(context)
                                          //                   .getPassportImage();
                                          //             },
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     )),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 15,
                                          // ),
                                        