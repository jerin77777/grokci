import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/dashboard.dart';
// import 'package:grokci_fe/orders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login.dart';
import 'screens/orders.dart';
import 'screens/account.dart';
import 'types.dart';
import 'package:appwrite/appwrite.dart';
import 'backend/server.dart';
// import 'package:twilio_flutter/twilio_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Client client = Client();
  account = Account(client);

  db = Databases(client);
  storage = Storage(client);

  client
          .setEndpoint(AppConfig.endpoint) // Your Appwrite Endpoint
          .setProject(AppConfig.project) // Your project ID
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
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navIdx = 0;

  @override
  void initState() {
    test();
    
    super.initState();
  }

  test() async {
    await local.ready;
    local.setItem("phone", "7845039503");
  }

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
      body: SafeArea(
        child: Navigator(
          pages: [
            if (navIdx == 0)
              MaterialPage(
                child: Dashboard(),
              )
            else if (navIdx == 1)
              MaterialPage(
                child: Orders(),
              )
            else if (navIdx == 2)
              MaterialPage(
                child: Profile(),
              )
          ],
          onPopPage: (route, result) {
            return true;
          },
        ),
      ),
    );
  }
}
