import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../types.dart';
import '../widgets/chart.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView(
        children: [
          Row(
            children: [
              // SizedBox(width: 10),
              SvgPicture.asset(
                width: 100,
                "assets/logo.svg",
                // color: Pallet.font3,
              ),
              Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Pallet.inner1,
                ),
                child: Row(
                  children: [
                    ProfileIcon(
                      size: 22,
                      name: "J",
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Jerin George Jacob",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.notifications_none)
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pallet.inner1,
                boxShadow: [
                  BoxShadow(
                      color: Pallet.shadow,
                      offset: const Offset(1, 1),
                      blurRadius: 5,
                      spreadRadius: 2),
                ]),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "pending order",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "51 Sri Sakthi Gardens, Sarvanampatti, Coimbatore",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 25,
                  height: 25,
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.red)),
                  child: Center(
                    child: Text(
                      "!",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                )
                // Icon(Icons.location_searching)
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 120,
                  padding: EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF30E287),
                      boxShadow: [
                        BoxShadow(
                            color: Pallet.shadow,
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                            spreadRadius: 4),
                      ]),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Icon(
                          Icons.monetization_on_outlined,
                          size: 60,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "todays earning",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "100 Rs",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 120,
                  padding: EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF30E287),
                      boxShadow: [
                        BoxShadow(
                            color: Pallet.shadow,
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                            spreadRadius: 4),
                      ]),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Icon(
                          Icons.delivery_dining,
                          size: 60,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "orders delivered",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "2",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     height: 160,
              //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Pallet.inner1),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Icon(
              //           Icons.delivery_dining,
              //           size: 60,
              //           color: Pallet.primary,
              //         ),
              //         SizedBox(height: 10),
              //         Text("orders delivered"),
              //         SizedBox(height: 5),
              //         Text(
              //           "2",
              //           style: TextStyle(
              //               fontSize: 18, fontWeight: FontWeight.w600),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Pallet.inner1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("monthly sales"),
                    Expanded(child: SizedBox()),
                    Icon(Icons.navigate_next_outlined, size: 20)
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: LineChart2(
                    isShowingMainData: false,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}