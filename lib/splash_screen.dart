import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.45, -0.9),
                end: Alignment(0.45, 0.9),
                colors: [
                  Color(0xFF63B5AF), // rgb(99, 181, 175)
                  Color(0xFF438883), // rgb(67, 136, 131)
                ],
                stops: [0.045, 1.0],
              ),
            ),
          ),

          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeIn,
              opacity:  1.0 ,
              child: const Text(
                'Expenzia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
