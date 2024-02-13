// import 'package:flutter/material.dart';

// import 'types.dart';
// import 'widgets.dart';

// class Account extends StatefulWidget {
//   const Account({super.key});

//   @override
//   State<Account> createState() => _AccountState();
// }

// class _AccountState extends State<Account> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: ListView(
//         children: [
//           Text(
//             "Account",
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
//           ),
//           SizedBox(height: 10),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//             decoration: BoxDecoration(
//                 color: Pallet.inner1,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10)),
//                 // borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Pallet.shadow,
//                       offset: const Offset(1, 1),
//                       blurRadius: 5,
//                       spreadRadius: 1),
//                 ]),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ProfileIcon(
//                   size: 60,
//                   color: Colors.blue,
//                   name: "J",
//                   fontSize: 25,
//                 ),
//                 SizedBox(width: 15),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Hi, Jerin George ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 18)),
//                       SizedBox(height: 0),
//                       Text(
//                         "hey how are u doing?",
//                         style: TextStyle(fontSize: 14, color: Pallet.font3),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Icon(
//                     Icons.edit,
//                     size: 20,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             "Account settings",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(height: 10),
//           Container(
//               padding: EdgeInsets.only(left: 15),
//               decoration: BoxDecoration(color: Pallet.inner1),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Icon(Icons.delivery_dining, color: Pallet.primary),
//                       SizedBox(width: 10),
//                       Text("My Orders",
//                           style: TextStyle(color: Pallet.primary)),
//                       Expanded(child: SizedBox()),
//                       Icon(Icons.arrow_forward_ios,
//                           color: Pallet.primary, size: 14),
//                       SizedBox(width: 5)
//                     ],
//                   ),
//                   Divider(indent: 0, endIndent: 0, height: 18),
//                   Row(
//                     children: [
//                       Icon(Icons.lock_person_rounded, color: Pallet.primary),
//                       SizedBox(width: 10),
//                       Text("Login & Security",
//                           style: TextStyle(color: Pallet.primary)),
//                       Expanded(child: SizedBox()),
//                       Icon(Icons.arrow_forward_ios,
//                           color: Pallet.primary, size: 14),
//                       SizedBox(width: 5)
//                     ],
//                   ),
//                   Divider(indent: 0, endIndent: 0, height: 18),
//                   Row(
//                     children: [
//                       Icon(Icons.language, color: Pallet.primary),
//                       SizedBox(width: 10),
//                       Text("Choose language",
//                           style: TextStyle(color: Pallet.primary)),
//                       Expanded(child: SizedBox()),
//                       Icon(Icons.arrow_forward_ios,
//                           color: Pallet.primary, size: 14),
//                       SizedBox(width: 5)
//                     ],
//                   ),
//                   SizedBox(height: 12
//                   ),
//                   // Divider(indent: 0, endIndent: 0, height: 18),
//                   // Row(
//                   //   children: [
//                   //     Icon(Icons.notifications, color: Pallet.primary),
//                   //     SizedBox(width: 10),
//                   //     Text("Notification Prefrence",
//                   //         style: TextStyle(color: Pallet.primary)),
//                   //     Expanded(child: SizedBox()),
//                   //     Icon(Icons.arrow_forward_ios,
//                   //         color: Pallet.primary, size: 14),
//                   //     SizedBox(width: 5)
//                   //   ],
//                   // ),
//                   // Divider(indent: 0, endIndent: 0, height: 18),
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
// }
