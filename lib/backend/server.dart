// import 'dart:js_interop';

import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:grokci/main.dart';
import 'package:grokci/screens/login.dart';
import 'package:simplytranslate/simplytranslate.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:io' as fl;
import 'package:path/path.dart';

late Databases db;
late Account account;
late Storage storage;
late BuildContext mainContext;
late SimplyTranslator gt;

bool english = true;
final LocalStorage local = LocalStorage('grokci');

// late TwilioFlutter twilioFlutter;

// delivery states picking, delivering, completed
// order states delivering, delivered, payed
// all database details used from here
class AppConfig {
  static String endpoint = "https://cloud.appwrite.io/v1";
  static String project = "grokci";
  static String database = "6504263e007ff813b432";
  static String orders = "65c9e1dda6e0b52f3463";
  static String products = "650426742ba0530f4ed7";
  static String orderProductMap = "65cf257b2dfaa673e1ad";
  static String drivers = "65ccc7954c7d0de38f77";
  static String warehouses = "65cf4c83826d08f5f8f0";
  static String twilloSid = "***";
  static String twilloToken = "***";
  static String twilloNumber = "***";
}

getOrders() async {
  List<Map> result = [];
  DocumentList temp = await db.listDocuments(
    databaseId: AppConfig.database,
    collectionId: AppConfig.orders,
    queries: [Query.equal("orderStatus", "pending"), Query.limit(50)],
  );
  result = getResult(temp.documents);
  return result;
}

getProducts(orderId) async {
  print(orderId);
  List<Map> products = [];

  DocumentList result1 = await db.listDocuments(
      databaseId: AppConfig.database,
      collectionId: AppConfig.orderProductMap,
      queries: [Query.equal("orderId", orderId)]);
  print(result1.documents);

  List<Map> result2 = getResult(result1.documents);
  for (var product in result2) {
    print(product["productId"]);
    Document temp = await db.getDocument(
        databaseId: AppConfig.database, collectionId: AppConfig.products, documentId: product["productId"]);
    temp.data["qty"] = product["qty"];
    products.add(temp.data);
  }

  return products;
}

getMyOrders() async {
  await local.ready;
  String phone = local.getItem("phone");
  DocumentList temp = await db.listDocuments(
      databaseId: AppConfig.database, collectionId: AppConfig.orders, queries: [Query.equal("driverId", phone)]);
  return getResult(temp.documents);
}

Future<Map> getDashboard() async {
  double amount = 0;
  int count = 0;
  Map data = {};
  List<double> graph = [];
  int lastDay = 0;
  // pending order
  double maxY = 0;

  await local.ready;
  String phone = local.getItem("phone");

  DocumentList temp = await db.listDocuments(
      databaseId: AppConfig.database,
      collectionId: AppConfig.orders,
      queries: [Query.equal("driverId", phone), Query.notEqual("orderStatus", "delivered")]);

  List<Map> result = getResult(temp.documents);
  if (result.isNotEmpty) {
    data["pendingOrder"] = result.first;
  }

  DateTime now = DateTime.now();
  lastDay = DateTime(now.year, now.month + 1, 0).day;
  for (var i = 0; i < lastDay; i++) {
    graph.add(0);
  }
  print(graph.length);

  Document userData =
      await db.getDocument(databaseId: AppConfig.database, collectionId: AppConfig.drivers, documentId: phone);

  data["userName"] = userData.data["userName"];
  temp = await db.listDocuments(databaseId: AppConfig.database, collectionId: AppConfig.orders, queries: [
    Query.equal("driverId", phone),
    Query.equal("orderStatus", "delivered"),
    Query.between("deliveryTime", DateTime(now.year, now.month, 1), DateTime(now.year, now.month + 1, 0)),
  ]);

  List<Map> monthlyData = getResult(temp.documents);

  for (var data in monthlyData) {
    int idx = DateTime.parse(data["deliveryTime"]).day - 1;
    if (now.day == DateTime.parse(data["deliveryTime"]).day) {
      amount += data["amount"];
      count += 1;
    }
    graph[idx] += data["amount"];
    if (graph[idx] > maxY) {
      maxY = graph[idx];
    }
  }

  data["amount"] = amount;
  data["count"] = count;
  data["graph"] = graph;
  data["graph_1"] = graph.sublist(0, 13);
  data["graph_2"] = graph.sublist(13, 25);
  data["graph_3"] = graph.sublist(25, lastDay);
  data["maxY"] = maxY + 10;
  data["maxX"] = graph.length.toDouble();
  data["showGraph"] = true;

  return data;
}

Future<Map> getUserData() async {
  await local.ready;
  String phone = local.getItem("phone");
  Document temp =
      await db.getDocument(databaseId: AppConfig.database, collectionId: AppConfig.drivers, documentId: phone);
  print(temp.data);
  return temp.data;
}

List<Map> getResult(List<Document> documents) {
  List<Map> result = [];

  for (var doc in documents) {
    result.add(doc.data);
  }
  return result;
}

Future<Map> getWareHouse() async {
  DocumentList temp = await db.listDocuments(databaseId: AppConfig.database, collectionId: AppConfig.warehouses);
  return temp.documents.first.data;
}

login(context, phoneNumber) async {
  try {
    bool adminApproved = await getAdminApproved(phoneNumber);
    // Document temp =
    // await db.getDocument(databaseId: AppConfig.database, collectionId: AppConfig.drivers, documentId: phoneNumber);
    await local.ready;
    local.setItem("phone", phoneNumber);
    local.setItem("adminApproved", adminApproved);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home(
              adminApproved: adminApproved,
            )));
  } catch (e) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignUp(
              phoneNumber: phoneNumber,
            )));
  }
}

Future<int> sendOtp(phoneNumber) async {
  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: AppConfig.twilloSid, // replace *** with Account SID
      authToken: AppConfig.twilloToken, // replace xxx with Auth Token
      twilioNumber: AppConfig.twilloNumber // replace .... with Twilio Number
      );

  final Random _random = Random();
  int _otp = 1000 + _random.nextInt(9000);
  await twilioFlutter.sendSMS(toNumber: "+91 ${phoneNumber}", messageBody: " your one time otp is: ${_otp}");
  return _otp;
}

getUrl(String imageId) {
  print("imaaageeeeee " + imageId);
  return "https://cloud.appwrite.io/v1/storage/buckets/65cdfdc7bba4531e45ad/files/${imageId}/view?project=grokci&mode=admin";
}

acceptDelivery(String orderId) async {
  await local.ready;
  String phone = local.getItem("phone");
  print(phone);
  DocumentList result =
      await db.listDocuments(databaseId: AppConfig.database, collectionId: AppConfig.orders, queries: [
    Query.equal("driverId", phone),
    Query.notEqual("orderStatus", "completed"),
  ]);

  // if driver has no pending orders
  if (result.documents.isEmpty) {
    Document? result2;
    try {
      result2 = await db.getDocument(
          databaseId: AppConfig.database, collectionId: AppConfig.orders, documentId: AppConfig.orders);
    } catch (e) {}

    // if no other drivers has taken order
    if (result2?.data["driverId"] == null) {
      updateOrderStatus(orderId, "picking");
      print("can pick up");
    }
  } else {
    print("already have pending order");
  }
}

updateOrderStatus(String orderId, String status) async {
  // print(orderId);
  await local.ready;
  String phone = local.getItem("phone");
  Map data = {};
  if (status == "delivered") {
    DateTime now = DateTime.now();
    data = {"driverId": phone, "orderStatus": status, "deliveryTime": now.toString()};
  } else {
    data = {"driverId": phone, "orderStatus": status};
  }
  await db.updateDocument(
      databaseId: AppConfig.database, collectionId: AppConfig.orders, documentId: orderId, data: data);
}

Future<bool> getAdminApproved(String phoneNumber) async {
  Document temp =
      await db.getDocument(databaseId: AppConfig.database, collectionId: AppConfig.drivers, documentId: phoneNumber);
  return temp.data["adminApproved"];
}

createAccount(
  context,
  String phoneNumber,
  String userName,
  String age,
  fl.File fileFront,
  fl.File? fileBack,
) async {
  String? _fileBack;
  File front = await storage.createFile(
      bucketId: "65cdfdc7bba4531e45ad",
      fileId: ID.unique(),
      file:
          InputFile.fromBytes(bytes: List<int>.from(fileFront.readAsBytesSync()), filename: basename(fileFront.path)));
  String _fileFront = front.$id;
// https://cloud.appwrite.io/v1/storage/buckets/65cdfdc7bba4531e45ad/files/65ce10b30237d3fb3a63/view?project=grokci&mode=admin

  if (fileBack != null) {
    File back = await storage.createFile(
        bucketId: "65cdfdc7bba4531e45ad",
        fileId: ID.unique(),
        file: InputFile.fromBytes(
            bytes: List<int>.from(fileFront.readAsBytesSync()), filename: basename(fileFront.path)));
    _fileBack = back.$id;
  }

  db.createDocument(databaseId: AppConfig.database, collectionId: AppConfig.drivers, documentId: phoneNumber, data: {
    "userName": userName,
    "phoneNumber": int.parse(phoneNumber),
    "age": int.parse(age),
    "fileFront": _fileFront,
    "fileBack": _fileBack
  });

  local.setItem("phone", phoneNumber);
  local.setItem("adminApproved", false);
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(adminApproved: false)));
}
