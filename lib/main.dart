import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:simplytranslate/simplytranslate.dart';
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

  gt = SimplyTranslator(EngineType.google);

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
      debugShowCheckedModeBanner: false,
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
      home: Loader(),
    );
  }
}

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool? loggedIn;
  bool adminApproved = false;
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    await local.ready;
    String? _phone = local.getItem("phone");
    bool? _adminApproved = local.getItem("adminApproved");
    english = local.getItem("english") ?? true;

    loggedIn = (_phone != null);

    if (_adminApproved == false) {
      adminApproved = await getAdminApproved(_phone!);
    } else {
      adminApproved = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loggedIn == true) {
      return Home(adminApproved: adminApproved);
    } else if (loggedIn == false) {
      return Login();
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.adminApproved});
  final bool adminApproved;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navIdx = 0;

  @override
  void initState() {
    // test();
    super.initState();
  }

  test() async {
    await local.ready;
    local.setItem("admin", "7845039503");
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    if (!widget.adminApproved) {
      return Scaffold(
        body: Center(
          child: Text("Waiting for Admin Aproval"),
        ),
      );
    }
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
