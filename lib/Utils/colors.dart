import 'package:flutter/cupertino.dart';

class AppColor {
  static const black = Color(0xff0A0A0A);
  static const primary = Color(0xfffea092);
  static const primary1 = Color(0xffFEBB9E);
  static const white = Color(0xffFFFFFF);
  static const shadowGrey = Color(0xffC4C4C4);
  static const customGrey = Color(0xffD9D9D9);
  static const grey1 = Color(0xff6c757d);
  static const iconGrey = Color(0xff85847E);
  static const customWhite = Color(0xffF5F5F5);
    static const maroon = Color(0xff800000);
  static const yellow = Color(0xffFDAD55);
  static const original = Color(0xffFB8BC3);
  static const red = Color(0xffFB6260);
  static const lightblue = Color(0xff75EBC7);

  static Color green = fromHex('#73AE6E');
  static Color splashScreen = fromHex('#FBFFFB');
  static Color lightGreen = fromHex('#5DB3C1');
  static Color skyBlue = fromHex('#E7F8FE');
  static Color skyDarkBlue = fromHex('#84D6E3');
  static Color lightPink = fromHex('#EED1FF');
  static Color grey = fromHex('#E2E2E2');
  static Color yellowText = fromHex('#FA9900');
  static Color lightCream = fromHex('#FFF4F4');
  static Color cardColor = fromHex('#FEE7F9');
  static Color cashColor = fromHex('#EDFEE7');
  static Color trackCircle = fromHex('#95A5DF');
  static Color upiColor = fromHex('#FEEBFA');
  static Color lightCher = fromHex('#FFE3BB');
  static Color backGround = fromHex('#F8F8FF');
  static Color pinkDark = fromHex('#A03466');
  static Color pinkLight = fromHex('#FF98C7');
  static Color lightGrey = fromHex('#C8C8C8');
  static Color midPurpleDark = fromHex('#5B4BB7');
  static Color purpleLight = fromHex('#989CFF');
  static Color blueDark = fromHex('#2A7087');
  static Color blueLight = fromHex('#7BDEFE');
  static Color redDark = fromHex('#901616');
  static Color redLight = fromHex('#FF9898');
  static Color yellowLight = fromHex('#F9D182');
  static Color seaGreenLight = fromHex('#7BFEE6');
  static Color purpleDark = fromHex('#6148F7');
  static Color purple = fromHex('#DDB5FD');
  static Color greenMedium = fromHex('#97E7BF');
  static Color greenMedium1 = fromHex('#DFF6DC');
  static Color greenLight = fromHex('#C8F1C5');
  static Color orange = fromHex('#FFA412');
  static Color GreenMedium = fromHex('#97E7BF');
  static Color SkyBlue = fromHex('#A5E8FF');
  static Color darkBlue = fromHex('#6148F7');

  static Gradient blueGradient = LinearGradient(
    colors: [midPurpleDark, blueLight],
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    // stops: [0.1, 9.0],
  );
  final Gradient backgroundGradient = LinearGradient(
    colors: [
      midPurpleDark.withOpacity(0.4),
      blueLight.withOpacity(0.4),
    ],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    // stops: [0.1, 9.0],
  );

  // static const Gradient yellowGradient1 = LinearGradient(
  //   colors: [yellow1,lightYellow1],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   stops: [0.5, 9.0],
  // );
  final LinearGradient myGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [
      AppColor.midPurpleDark.withOpacity(0.3),
      AppColor.blueLight.withOpacity(0.3)
    ],
  );
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
