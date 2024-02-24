import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:grokci/backend/server.dart';
import 'package:telephony/telephony.dart';
import '../main.dart';
import '../types.dart';
import '../widgets/widgets.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

backgrounMessageHandler(SmsMessage message) async {
  //Handle background message
}

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Map> orders = [];
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    orders = await getOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          TextTra(
            "Orders",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 10),
          for (var order in orders)
            GestureDetector(
              onTap: () {
                Navigator.of(mainContext).push(MaterialPageRoute(builder: (context) => OrderDetails(order: order)));
              },
              child: Container(
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
                                name: order["username"],
                              ),
                              SizedBox(width: 8),
                              TextTra(
                                order["username"],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox(height: 20)),
                          TextTra(order["deliveryAddress"].toString().trim()),
                          TextTra(
                            "${order["distance"]} km away",
                            style: TextStyle(fontSize: 13, color: Pallet.font3),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // TextTra("Distance"),
                        // TextTra("500 m"),
                        // SizedBox(height: 20),
                        // Expanded(child: SizedBox()),
                        TextTra("Amount"),
                        TextTra(
                          "${order["amount"]} Rs",
                          style: TextStyle(color: Pallet.primary, fontSize: 18, fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.order});
  final Map order;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Map> products = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    print("iddddd  " + widget.order["\$id"]);
    products = await getProducts(widget.order["\$id"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  TextTra(
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
                                TextTra("Order Id"),
                                TextTra(widget.order["\$id"]),
                              ],
                            ),
                          ),
                          Icon(Icons.copy)
                        ],
                      )),
                  SizedBox(height: 10),
                  TextTra(
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
                            TextTra(widget.order["username"]),
                            SizedBox(height: 5),
                            // TextTra("jerinjacob0007@gmail.com"),
                            TextTra("+91 ${widget.order["phoneNumber"]}"),
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
                            TextTra(
                              "call",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  TextTra(
                    "Items:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  for (var product in products)
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Pallet.inner1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              getUrl(product["imageId"]),
                              // "assets/oil.jpeg",
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
                                  TextTra(product["name"]),
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Pallet.primary,
                                      ),
                                      child: Center(
                                        child: TextTra(
                                          "qty: ${product["qty"]}",
                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextTra(
                                        product["\$id"],
                                        style: TextStyle(fontSize: 12),
                                      )),
                                      Icon(Icons.copy)
                                    ],
                                  )),
                            ],
                          )),
                        ],
                      ),
                    ),
                  SizedBox(height: 5),
                  TextTra(
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
                              TextTra("Total Amount", style: TextStyle(fontSize: 12, color: Colors.white)),
                              // style: TextStyle(fontSize: 12, color: Pallet.font2)),
                              Expanded(child: SizedBox()),
                              TextTra("${widget.order["amount"]} Rs",
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
                              TextTra("Items weight", style: TextStyle(fontSize: 12, color: Colors.white)),
                              Expanded(child: SizedBox()),
                              TextTra("${widget.order["itemWeight"]} Kg",
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
                              TextTra("Payment type", style: TextStyle(fontSize: 12, color: Colors.white)),
                              Expanded(child: SizedBox()),
                              TextTra(widget.order["paymentType"],
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
            if (widget.order["orderStatus"] == "pending")
              Button(
                  label: "Accept Delivery",
                  onPress: () async {
                    await acceptDelivery(widget.order["\$id"]);
                    widget.order["orderStatus"] = "picking";
                    setState(() {});
                  }),
            if (widget.order["orderStatus"] == "picking")
              Row(
                children: [
                  Button(
                      label: "Go to Warehouse",
                      icon: Icon(Icons.my_location, color: Colors.white, size: 18),
                      onPress: () async {
                        Map warehouse = await getWareHouse();
                        bool? exist = await MapLauncher.isMapAvailable(MapType.google);
                        if (exist == true) {
                          await MapLauncher.showMarker(
                            mapType: MapType.google,
                            coords: Coords(warehouse["latitude"], warehouse["longitude"]),
                            title: "Warehouse 1",
                          );
                        }
                      }),
                  SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          label: "Order Picked Up",
                          icon: Icon(Icons.check_circle, color: Colors.white, size: 18),
                          onPress: () {
                            updateOrderStatus(widget.order["\$id"], "delivering");
                            widget.order["orderStatus"] = "delivering";
                            setState(() {});
                          })),
                ],
              )
            else if (widget.order["orderStatus"] == "delivering")
              Row(
                children: [
                  Button(
                      label: "Go to Location",
                      icon: Icon(Icons.my_location, color: Colors.white, size: 18),
                      onPress: () async {
                        bool? exist = await MapLauncher.isMapAvailable(MapType.google);
                        if (exist == true) {
                          await MapLauncher.showMarker(
                            mapType: MapType.google,
                            coords: Coords(widget.order["latitude"], widget.order["longitude"]),
                            title: "Delivery Location",
                          );
                        }
                      }),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          label: "Delivery Completed",
                          icon: Icon(Icons.check_circle, color: Colors.white, size: 18),
                          onPress: () async {
                            int _otp = await sendOtp(widget.order["phoneNumber"]);
                            Navigator.of(mainContext).push(MaterialPageRoute(
                                builder: (context) => ConfirmDelivery(
                                      orderId: widget.order["\$id"],
                                      checkOtp: _otp,
                                    )));
                          })),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ConfirmDelivery extends StatefulWidget {
  const ConfirmDelivery({super.key, required this.checkOtp, required this.orderId});
  final int checkOtp;
  final String orderId;
  @override
  State<ConfirmDelivery> createState() => _ConfirmDeliveryState();
}

class _ConfirmDeliveryState extends State<ConfirmDelivery> {
  final Telephony telephony = Telephony.instance;

  @override
  void initState() {
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          if (int.parse(message.body!.split(":")[1].trim()) == widget.checkOtp) {
            updateOrderStatus(widget.orderId, "delivered");
            Navigator.of(mainContext).push(MaterialPageRoute(
                builder: (context) => Home(
                      adminApproved: true,
                    )));
          }
        },
        onBackgroundMessage: backgrounMessageHandler);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              TextTra(
                "Confirm Delivery",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 40),
              TextTra(
                "Enter otp:",
              ),
              SizedBox(height: 15),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFF512DA8),
                showFieldAsBox: true,
                onSubmit: (String verificationCode) {
                  if (int.parse(verificationCode) == widget.checkOtp) {
                    updateOrderStatus(widget.orderId, "delivered");
                    Navigator.of(mainContext).push(MaterialPageRoute(
                        builder: (context) => Home(
                              adminApproved: true,
                            )));
                  }
                }, // end onSubmit
              ),
            ],
          ),
        ),
      ),
    );
  }
}
