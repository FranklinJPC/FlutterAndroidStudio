import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/main.dart'; // Asegúrate de importar tu pantalla principal de películas

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    // Timer para navegar a la pantalla principal después de 3 segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(), // Reemplaza con tu pantalla principal
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffaee1d3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
                  .animate(_slideAnimation),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/logodark.jpg', // Reemplaza con tu imagen de logo
                    width: 150.0, // Ajusta el ancho según tus necesidades
                    height: 150.0, // Ajusta la altura según tus necesidades
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SlideTransition(
              position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                  .animate(_slideAnimation),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Welcome to the World of Movies',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black, // Cambiado a negro
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            'Created by: Melani Molina '
                'Franklin Patiño', // Reemplaza con tu nombre
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
