import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSans extends StatelessWidget {
  final String text;
  final Color color;
  const OpenSans({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        color: color,
        fontSize: 20.0,
      ),
    );
  }
}

class FrostedGlass extends StatelessWidget {
  final width;
  final height;
  final child;
  final borderColor;
  const FrostedGlass({super.key, this.width, this.height, this.child, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        color: Colors.transparent,
        //we use Stack(); because we want the effects be on top of each other,
        child: Stack(
          children: [
            //blur effect ==> the third layer of stack
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //we use this container to scale up the blur effect to fit its
                //  parent, without this container the blur effect doesn't appear.
                child: Container(),
              ),
            ),
            //gradient effect ==> the second layer of stack
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: borderColor.withOpacity(0.13)),
                borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05)
                  ])),
            ),
            //child ==> the first/top layer of stack
            Center(
              child: child,
            )
          ],
        ));
  }
}

// class FrostedGlassBox extends StatelessWidget {
//   const FrostedGlassBox(
//       {Key? key,
//         required this.theWidth,
//         required this.theHeight,
//         required this.theChild})
//       : super(key: key);
//
//   final theWidth;
//   final theHeight;
//   final theChild;
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(30),
//       child: Container(
//         width: theWidth,
//         height: theHeight,
//         color: Colors.transparent,
//         //we use Stack(); because we want the effects be on top of each other,
//         //  just like layer in photoshop.
//         child: Stack(
//           children: [
//             //blur effect ==> the third layer of stack
//             BackdropFilter(
//               filter: ImageFilter.blur(
//                 //sigmaX is the Horizontal blur
//                 sigmaX: 4.0,
//                 //sigmaY is the Vertical blur
//                 sigmaY: 4.0,
//               ),
//               //we use this container to scale up the blur effect to fit its
//               //  parent, without this container the blur effect doesn't appear.
//               child: Container(),
//             ),
//             //gradient effect ==> the second layer of stack
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 border: Border.all(color: Colors.white.withOpacity(0.13)),
//                 gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       //begin color
//                       Colors.white.withOpacity(0.15),
//                       //end color
//                       Colors.white.withOpacity(0.05),
//                     ]),
//               ),
//             ),
//             //child ==> the first/top layer of stack
//             Center(child: theChild),
//           ],
//         ),
//       ),
//     );
//   }
// }
