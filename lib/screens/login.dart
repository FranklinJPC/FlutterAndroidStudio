import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa la biblioteca de autenticación de Firebase
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/screens/signup.dart';
import 'package:movies/screens/forgotpassword.dart'; // Importa la vista de Forgot Password
import 'package:movies/theme/theme_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final ThemeData? themeData;
  LoginScreen({this.themeData});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia de FirebaseAuth

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.themeData?.primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: widget.themeData?.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Log In',
          style: widget.themeData?.textTheme.headline5,
        ),
      ),
      body: Container(
        color: widget.themeData?.primaryColor,
        child: LoginForm(themeData: widget.themeData, auth: _auth),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final ThemeData? themeData;
  final FirebaseAuth auth; // Recibe la instancia de FirebaseAuth
  LoginForm({this.themeData, required this.auth});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.themeData?.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
                style: widget.themeData?.textTheme.bodyText1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                style: widget.themeData?.textTheme.bodyText1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Aquí puedes agregar la lógica de inicio de sesión con Firebase
                    _signInWithEmailAndPassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                  // primary: widget.themeData?.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Log In'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navega a la pantalla de Forgot Password
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ForgotPasswordScreen(
                            themeData: widget.themeData,
                          ),
                    ),
                  );
                },
                child: Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await widget.auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Éxito al iniciar sesión
      print('Signed in successfully');

      // Mostrar notificación
      Fluttertoast.showToast(
        msg: "Login successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Puedes agregar lógica adicional aquí, como navegar a otra pantalla
    } catch (e) {
      // Error al iniciar sesión
      print('Error signing in: $e');

      // Puedes mostrar un mensaje de error o realizar otras acciones según necesites
      Fluttertoast.showToast(
        msg: "Error signing in: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
