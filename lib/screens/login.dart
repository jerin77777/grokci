// import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/widgets.dart';
import '../backend/server.dart';
import '../types.dart';
import 'package:telephony/telephony.dart';
import 'package:file_picker/file_picker.dart';

backgrounMessageHandler(SmsMessage message) async {
  //Handle background message
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Telephony telephony = Telephony.instance;
  TextEditingController phoneNumber = TextEditingController();
  String phoneError = "";
  @override
  void initState() {
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          print(message.body);
        },
        onBackgroundMessage: backgrounMessageHandler);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    width: 150,
                    "assets/logo.svg",
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                "To get the best of us, please Log in",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "Enter your phone number to continue",
                // style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              if (phoneError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(phoneError, style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
              Container(
                height: 50,
                // padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.5)),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text("+91"),
                    Icon(Icons.arrow_drop_down_rounded),
                    Expanded(
                        child: TextField(
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                      onChanged: (_) {
                        if (phoneError.isNotEmpty) {
                          phoneError = "";
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(border: InputBorder.none),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //       "Use Email instead",
              //       style: TextStyle(color: Pallet.primary2),
              //     )
              //   ],
              // ),
              Expanded(child: SizedBox()),
              RichText(
                text: TextSpan(
                  text: "By continuing, you agree to Grocki's ",
                  style: TextStyle(fontSize: 14, color: Pallet.font1),
                  children: <TextSpan>[
                    TextSpan(text: 'Terms of Use', style: TextStyle(color: Pallet.primary2)),
                    TextSpan(text: ' & '),
                    TextSpan(text: 'Privacy Policy!', style: TextStyle(color: Pallet.primary2)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Button(
                  label: "Log in",
                  onPress: () {
                    bool error = false;
                    RegExp numReg = RegExp(r'^-?[0-9]+$');
                    if (phoneNumber.text.length != 10 || !numReg.hasMatch(phoneNumber.text)) {
                      phoneError = "invalid number";
                      error = true;
                    }
                    setState(() {});
                    if (!error) {
                      login(context, phoneNumber.text);
                    }
                  }),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // error texts
  String fileError = "";
  String ageError = "";
  String nameError = "";

  FilePickerResult? fileFront;
  FilePickerResult? fileBack;
  TextEditingController userName = TextEditingController();
  TextEditingController age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          width: 150,
                          "assets/logo.svg",
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      "We need some more information about you",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    // SizedBox(height: 10),
                    Text("Enter your user name"),
                    SizedBox(height: 6),
                    if (nameError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(nameError, style: TextStyle(color: Colors.red, fontSize: 12)),
                      ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: nameError.isEmpty ? Colors.black : Colors.red)),
                      child: TextField(
                        controller: userName,
                        keyboardType: TextInputType.text,
                        onChanged: (_) {
                          if (nameError.isNotEmpty) {
                            nameError = "";
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("what is your age"),
                    SizedBox(height: 6),
                    if (ageError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(ageError, style: TextStyle(color: Colors.red, fontSize: 12)),
                      ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: ageError.isEmpty ? Colors.black : Colors.red)),
                      child: TextField(
                        controller: age,
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          if (ageError.isNotEmpty) {
                            ageError = "";
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("proof of identity"),
                    SizedBox(height: 6),
                    if (fileError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(fileError, style: TextStyle(color: Colors.red, fontSize: 12)),
                      ),
                    GestureDetector(
                      onTap: () async {
                        fileFront = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
                        if (fileFront != null) {
                          fileError = "";
                          setState(() {});
                        }
                      },
                      child: DottedBorder(
                        color: fileError.isNotEmpty ? Colors.red : Pallet.primary,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.symmetric(vertical: 25),
                        dashPattern: [8, 4],
                        child: Column(
                          children: [
                            Icon(
                              Icons.add,
                              color: fileError.isNotEmpty ? Colors.red : Pallet.primary,
                              size: 18,
                            ),
                            SizedBox(height: 3),
                            Text(
                              "add front",
                              style: TextStyle(color: fileError.isNotEmpty ? Colors.red : Pallet.primary, fontSize: 14),
                            ),
                            Row(
                              children: [],
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        fileBack = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
                        // File temp = await storage.createFile(
                        //     bucketId: "65cdfdc7bba4531e45ad",
                        //     fileId: ID.unique(),
                        //     file: InputFile.fromBytes(
                        //         bytes: List<int>.from(result!.files.first.bytes!), filename: result!.files.first.name));
                        // result.files.clear();
                        // fileBack = temp.$id;
                      },
                      child: DottedBorder(
                        color: Pallet.primary,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.symmetric(vertical: 25),
                        dashPattern: [8, 4],
                        child: Column(
                          children: [
                            Icon(
                              Icons.add,
                              color: Pallet.primary,
                              size: 18,
                            ),
                            SizedBox(height: 3),
                            Text(
                              "add back",
                              style: TextStyle(color: Pallet.primary, fontSize: 14),
                            ),
                            Row(
                              children: [],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Button(
                  label: "Done",
                  onPress: () {
                    // if (fileFront.isNotEmpty) {
                    // }
                    RegExp numReg = RegExp(r'^-?[0-9]+$');
                    bool error = false;
                    if (age.text.isEmpty) {
                      ageError = "required *";
                      error = true;
                    } else if (!numReg.hasMatch(age.text)) {
                      ageError = "must be int";
                      error = true;
                    }

                    if (fileFront == null) {
                      error = true;
                      fileError = "required *";
                    }

                    if (userName.text.isEmpty) {
                      nameError = "required *";
                      error = true;
                    }

                    setState(() {});

                    if (!error) {
                      createAccount(context,widget.phoneNumber, userName.text, age.text, fileFront!, fileBack);
                    }
                  }),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
