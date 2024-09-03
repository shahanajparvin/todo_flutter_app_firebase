import 'package:flutter/material.dart';

abstract class Dimension {
  double get iconSize;
}

class DimensionMobile extends Dimension {
  @override
  double get iconSize => 250;
}

class DimensionTablet extends Dimension {
  @override
  double get iconSize => 450;
}

class DimensionFactory {
  static Dimension getDimension(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < 600) {
      // Mobile
      return DimensionMobile();
    } else {
      // Tablet or other larger devices
      return DimensionTablet();
    }
  }
}



class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimension dimension = DimensionFactory.getDimension(context);

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/ic_splash_logo.png',
          width: dimension.iconSize,
          height: dimension.iconSize,
        ),
      ),
    );
  }
}
