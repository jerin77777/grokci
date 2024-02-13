import 'package:flutter/material.dart';
import '../types.dart';
import '../widgets/widgets.dart';
import 'package:appwrite/appwrite.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          Text(
            "Orders",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 10),
          Container(
            height: 130,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10), boxShadow: [
              BoxShadow(color: Pallet.shadow, offset: const Offset(1, 1), blurRadius: 5, spreadRadius: 1),
            ]),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ProfileIcon(
                            size: 25,
                            color: Colors.blue,
                            name: "J",
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Jerin George Jacob",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox(height: 20)),
                      Text("51 Sri Sakthi Gardens, Sarvanampatti, Coimbatore"),
                      Text(
                        "5 km away",
                        style: TextStyle(fontSize: 13, color: Pallet.font3),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text("Distance"),
                    // Text("500 m"),
                    // SizedBox(height: 20),
                    // Expanded(child: SizedBox()),
                    Text("Amount"),
                    Text(
                      "90 Rs",
                      style: TextStyle(color: Pallet.primary, fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  "Order Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Pallet.inner1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order Id"),
                              Text("550e8400-e29b-41d4-a716-446655440000"),
                            ],
                          ),
                        ),
                        Icon(Icons.copy)
                      ],
                    )),
                SizedBox(height: 10),
                Text(
                  "user data:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jerin George Jacob"),
                          Text("jerinjacob0007@gmail.com"),
                          Text("+91 7845039503"),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
                        BoxShadow(color: Pallet.shadow, offset: const Offset(2, 2), blurRadius: 1, spreadRadius: 2),
                      ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call,
                            color: Pallet.primary,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "call",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Row(
                //   children: [
                //     ProfileIcon(
                //       size: 30,
                //       name: "J",
                //       color: Colors.blue,
                //     ),
                //     SizedBox(width: 10),
                //   ],
                // ),
                SizedBox(height: 10),

                // SizedBox(height: 5),
                Text(
                  "Items:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                // Text("Items:"),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Pallet.inner1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/oil.jpeg",
                          width: 90,
                          height: 90,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sun flower oil"),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Pallet.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "qty: 1",
                                      style: TextStyle(fontSize: 12, color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "550e8400-e29b-41d4-a716-446655440000",
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  Icon(Icons.copy)
                                ],
                              )),
                        ],
                      )),
                      // SizedBox(width: 5),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Details:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Pallet.primary),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Amount", style: TextStyle(fontSize: 12, color: Colors.white)),
                            // style: TextStyle(fontSize: 12, color: Pallet.font2)),
                            Expanded(child: SizedBox()),
                            Text("2000 Rs",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Pallet.primary),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Items weight", style: TextStyle(fontSize: 12, color: Colors.white)),
                            Expanded(child: SizedBox()),
                            Text("20 Kg",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Pallet.primary),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Payment type", style: TextStyle(fontSize: 12, color: Colors.white)),
                            Expanded(child: SizedBox()),
                            Text("COD",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Row(
            children: [
              Button(
                  label: "Go to Warehouse",
                  icon: Icon(Icons.my_location, color: Colors.white, size: 20),
                  onPress: () {}),
              SizedBox(width: 8),
              Expanded(
                  child: Button(
                      label: "Order Picked Up",
                      icon: Icon(Icons.check_circle, color: Colors.white, size: 20),
                      onPress: () {})),
            ],
          )
        ],
      ),
    );
  }
}
