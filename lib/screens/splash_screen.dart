import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7cd7cf),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(390.90),
                  border: Border.all(color: Colors.black, width: 20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(390.90),
                  child: Image.asset('assets/images/fondo3.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.linear,
                ),
              ),
              child: const Text(
                'World of Movies!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 40,
        child: Text(
          'Creator by: Melani Molina Franklin Patiño',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
