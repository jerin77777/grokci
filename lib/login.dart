import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets.dart';
import 'backend/server.dart';
import 'types.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      keyboardType: TextInputType.phone,
                  decoration: InputDecoration(border: InputBorder.none),
                ))
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Use Email instead",
                style: TextStyle(color: Pallet.primary2),
              )
            ],
          ),
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
          Button(label: "Log in", onPress: (){
            getOrders();
          }),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
