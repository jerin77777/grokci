import 'package:flutter/material.dart';
import 'dashboard.dart';
// import 'package:grokci_fe/orders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'orders.dart';
import 'account.dart';
import 'types.dart';
import 'package:appwrite/appwrite.dart';
import 'backend/server.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Client client = Client();
  account = Account(client);

  db = Databases(client);

  client
          .setEndpoint(DbConfig.endpoint) // Your Appwrite Endpoint
          .setProject(DbConfig.project) // Your project ID
          .setSelfSigned() // Use only on dev mode with a self-signed SSL cert
      ;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(TextTheme(
          displayLarge: TextStyle(color: Pallet.font1),
          displayMedium: TextStyle(color: Pallet.font1),
          bodyMedium: TextStyle(color: Pallet.font1),
          titleMedium: TextStyle(color: Pallet.font1),
        )),
        iconTheme: IconThemeData(color: Pallet.font1),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.background,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallet.background,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: navIdx,
        selectedItemColor: Pallet.primary,
        unselectedItemColor: Pallet.font3,
        onTap: (index) {
          navIdx = index;
          setState(() {});
        },
      ),
      body: SafeArea(child: Login()),
    );
  }
}
