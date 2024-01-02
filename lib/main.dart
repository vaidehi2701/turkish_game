import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double buttonPositionX = 90;
  double buttonPositionY = 220;
  late AnimationController controller;
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // initialize confettiController
    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              "images/bg.png",
            ),
            Positioned(
                top: 70,
                left: 80,
                child: Row(
                  children: [
                    Text(
                      "Will You Marry me ???",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                    Lottie.asset('images/blush.json', height: 50),
                  ],
                )),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _centerController,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 1,
                emissionFrequency: 0.03,

                // 10 paticles will pop-up at a time
                numberOfParticles: 10,
                colors: const [
                  Colors.yellow,
                  Colors.amber,
                ], // m
                // particles will pop-up
                gravity: 0,
                // createParticlePath: drawStar,
              ),
            ),
            Positioned(
              top: 150,
              left: 90,
              child: CustomButton(
                  onTap: () {
                    _centerController.play();
                  },
                  text: "Yes"),
            ),
            Stack(
              children: [
                Positioned(
                  left: buttonPositionX,
                  top: buttonPositionY,
                  child: MouseRegion(
                    onEnter: (_) {
                      moveButtonToRandomPosition();
                    },
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return CustomButton(onTap: () {}, text: "No");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void moveButtonToRandomPosition() {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const buttonWidth = 100.0;
    const buttonHeight = 36.0;

    setState(() {
      buttonPositionX = random.nextDouble() * (screenWidth - buttonWidth / 3);
      buttonPositionY = random.nextDouble() * (screenHeight - buttonHeight);
      controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffffcb4c),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 30,
            color: const Color(0xff493d00),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
