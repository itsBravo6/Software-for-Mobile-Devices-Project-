import 'package:chat_app/components/roundedbutton.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, upperBound: 1, duration: Duration(seconds: 3));

    //  animation= CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation =
        ColorTween(begin: Colors.green, end: Colors.blue).animate(controller);

    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
      //   print(animation.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
              ],
            ),
            TextLiquidFill(
              text: 'SMD Project \n 19-0061 Muhammad Abeer \n 19P-0012 Aitzaz Tahir'

              , waveColor: Colors.orange,
              boxBackgroundColor: animation.value,
              textStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 48.0,
            ),
            OutlineGradientButton(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Center(
                child: Text('SIGN IN',
                    style: TextStyle(color: Colors.black, fontSize: 30)),
              ),
              gradient: SweepGradient(
                colors: List.generate(
                    360,
                    (h) =>
                        HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor()),
              ),
              strokeWidth: 2,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              radius: Radius.circular(8),
            ),
            SizedBox(
              height: 20,
            ),
            OutlineGradientButton(
              onTap: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              child: Center(
                child: Text('SIGN UP',
                    style: TextStyle(color: Colors.black, fontSize: 30)),
              ),
              gradient: SweepGradient(
                colors: List.generate(
                    360,
                    (h) =>
                        HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor()),
              ),
              strokeWidth: 2,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              radius: Radius.circular(8),
            ),
          ],
        ),
      ),
    );
  }
}
