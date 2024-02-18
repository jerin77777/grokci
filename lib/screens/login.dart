// import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/widgets.dart';
import '../backend/server.dart';
import '../types.dart';
import 'package:telephony/telephony.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

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
    // test();
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          print(message.body);
        },
        onBackgroundMessage: backgrounMessageHandler);
    // TODO: implement initState
    super.initState();
  }

  test() async {
    await Future.delayed(Duration(milliseconds: 500));
    selectPickerType(mainContext);
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
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

  File? fileFront;
  File? fileBack;
  TextEditingController userName = TextEditingController();
  TextEditingController age = TextEditingController();
  final ImagePicker picker = ImagePicker();

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
                    if (fileFront == null)
                      GestureDetector(
                        onTap: () async {
                          ImageSource? sourceType = await selectPickerType(context);
                          if (sourceType != null) {
                            XFile? temp = await picker.pickImage(source: sourceType);
                            if (temp != null) {
                              fileFront = File(temp.path);
                              fileError = "";
                            }
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
                                style:
                                    TextStyle(color: fileError.isNotEmpty ? Colors.red : Pallet.primary, fontSize: 14),
                              ),
                              Row(
                                children: [],
                              )
                            ],
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  Image.memory(fileFront!.readAsBytesSync(), height: 80, width: 80, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(basename(fileFront!.path)),
                                SizedBox(height: 8),
                                Text(getSize(fileFront!.lengthSync()))
                              ],
                            )),
                            SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  fileFront = null;
                                  setState(() {});
                                },
                                child: Icon(Icons.delete, color: Pallet.font3))
                          ],
                        ),
                      ),

                    SizedBox(height: 10),
                    if (fileBack == null)
                      GestureDetector(
                        onTap: () async {
                          ImageSource? sourceType = await selectPickerType(context);
                          if (sourceType != null) {
                            XFile? temp = await picker.pickImage(source: sourceType);
                            if (temp != null) {
                              fileBack = File(temp.path);
                              setState(() {});
                            }
                          }
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
                    else
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  Image.memory(fileBack!.readAsBytesSync()!, height: 80, width: 80, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(basename(fileBack!.path)),
                                SizedBox(height: 8),
                                Text(getSize(fileBack!.lengthSync()))
                              ],
                            )),
                            SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  fileBack = null;
                                  setState(() {});
                                },
                                child: Icon(Icons.delete, color: Pallet.font3))
                          ],
                        ),
                      ),
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
                      createAccount(context, widget.phoneNumber, userName.text, age.text, fileFront!, fileBack);
                    }
                  }),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  getSize(int size) {
    double _size = size / 1048576;
    if (_size < 1) {
      _size = _size * 1000;
      return _size.toStringAsFixed(2) + " KB";
    } else if (_size < 1000) {
      return _size.toStringAsFixed(2) + " MB";
    } else {
      _size = _size / 1000;
      return _size.toStringAsFixed(2) + " GB";
    }
  }
}

Future<ImageSource?> selectPickerType(BuildContext context) async {
  ImageSource? selected;
  await showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.zero,
          // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
          backgroundColor: Colors.transparent,
          content: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: 150,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Pallet.inner1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      selected = ImageSource.camera;
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallet.primary)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Camera",
                            style: TextStyle(color: Pallet.primary),
                          )),
                          Icon(
                            Icons.camera_alt,
                            color: Pallet.primary,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      selected = ImageSource.gallery;
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallet.primary)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Gallery",
                            style: TextStyle(color: Pallet.primary),
                          )),
                          Icon(
                            Icons.photo,
                            color: Pallet.primary,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    },
  );
  return selected;
}
