import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'types.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon(
      {super.key,
      this.image,
      this.name,
      this.color,
      required this.size,
      this.fontSize});
  final String? image;
  final String? name;
  final Color? color;
  final double size;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(size)),
        child: Center(
          child: Text(name![0].toString().toUpperCase(),
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w500))),
        ),
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          // width: size,
          // height: size,
          // decoration: BoxDecoration(color: color, borderRadius: ),
          // child: Image.network(server.getAsssetUrl(image!))
          // child: Center(
          // child: Text(name![0].toString().toUpperCase(), style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500))),
          // ),
        ),
      );
    }
  }
}

class Button extends StatefulWidget {
  const Button(
      {super.key,
      required this.label,
      this.icon,
      required this.onPress,
      this.active = true});
  final Icon? icon;
  final String label;
  final bool active;
  final Function onPress;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Pallet.primary2,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Pallet.shadow,
          blurRadius: 2,
          spreadRadius: 0.5,
          offset: Offset(1, 3),
        ),
      ],
    ),
    end: BoxDecoration(
      color: Pallet.primary2,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Pallet.shadow,
          blurRadius: 2,
          spreadRadius: 0.5,
          offset: Offset(1, 3),
        ),
      ],
    ),
  );

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..forward();

  @override
  void initState() {
    if (!widget.active) {
      decorationTween = DecorationTween(
        begin: BoxDecoration(
          color: Pallet.primary2.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        end: BoxDecoration(
          color: Pallet.primary2.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      );

      setState(() {});
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Button oldWidget) {
    if (widget.active) {
      decorationTween = DecorationTween(
        begin: BoxDecoration(
          color: Pallet.primary2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Pallet.shadow,
              blurRadius: 2,
              spreadRadius: 0.5,
              offset: Offset(1, 3),
            ),
          ],
        ),
        end: BoxDecoration(
          color: Pallet.primary2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Pallet.shadow,
              blurRadius: 2,
              spreadRadius: 0.5,
              offset: Offset(1, 3),
            ),
          ],
        ),
      );

      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) async {
        if (widget.active) {
          await _controller.reverse();
          await _controller.forward();
          widget.onPress();
        }
      },
      onTapDown: (_) {},
      onTapCancel: () {
        _controller.forward();
      },
      child: DecoratedBoxTransition(
        decoration: decorationTween.animate(_controller),
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: (widget.icon == null)? 15: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: (widget.icon == null)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (widget.icon != null) widget.icon!,
              SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: (widget.active)
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 10)
            ],
          ),
        ),
      ),
    );
  }
}
