import 'package:flutter/material.dart';
import 'package:movies/screens/forgotpassword.dart';
import 'package:provider/provider.dart';

import '../theme/theme_state.dart';

class LoginScreen extends StatelessWidget {
  final ThemeData? themeData;
  LoginScreen({this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData!.primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: themeData!.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Log In',
          style: themeData!.textTheme.headline5,
        ),
      ),
      body: LoginForm(themeData: themeData),

    );
  }
}

class LoginForm extends StatefulWidget {
  final ThemeData? themeData;
  LoginForm({this.themeData});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return Container(
      //color: widget.themeData?.scaffoldBackgroundColor, // Usa el color de fondo del tema
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                //color: widget.themeData?.primaryColor, // Usa el color primario del tema
                child: TextFormField(
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
              ),
              SizedBox(height: 16),
              Container(
                //color: widget.themeData?.primaryColor, // Usa el color primario del tema
                child: TextFormField(
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
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Acción del botón de inicio de sesión
                  }
                },
                style: ElevatedButton.styleFrom(
                  //primary: widget.themeData?.primaryColor, // Usa el color primario del tema
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Log In'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(
                        themeData: state.themeData,
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
}
