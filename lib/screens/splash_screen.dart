import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_colors.dart';
import 'main_tab_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      //Exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainTabScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Container(
              width: mq.width * .5,
              height: mq.width * .5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/icon_zylu.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: mq.height * .15,
              left: 0,
              right: 0,
              child: const Text("DEVELOPED BY BIJETHA WITH ❤️",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: .5,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
