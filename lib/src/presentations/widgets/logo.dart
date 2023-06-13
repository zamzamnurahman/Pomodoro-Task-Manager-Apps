import 'package:flutter/material.dart';

import '../../config/theme.dart';

class Logo extends StatelessWidget {
  final bool? isAnimation;
  const Logo({super.key, this.isAnimation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.white,
                width: 10,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(-4, 10),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Center(
                child: Stack(
              children: [
                Text(
                  "25\n00\n",
                  style: TextStyle(
                    height: 1.0,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Digital",
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Colors.white,
                  ),
                ),
                const Text(
                  "25\n00\n",
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Digital",
                      height: 1.0),
                ),
              ],
            )),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              strokeWidth: 20,
              color: secondary,
              value: isAnimation == null ? 0.2 : null,
            ),
          ),
        ],
      ),
    );
  }
}
