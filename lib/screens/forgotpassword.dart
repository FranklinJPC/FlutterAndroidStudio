import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final ThemeData? themeData;
  ForgotPasswordScreen({this.themeData});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.themeData?.primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: widget.themeData?.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Forgot Password',
          style: widget.themeData?.textTheme.headline5,
        ),
      ),
      body: Container(
        color: widget.themeData?.scaffoldBackgroundColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your email to receive a password reset link.',
              style: widget.themeData?.textTheme.bodyText1,
            ),
            SizedBox(height: 16),
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
                // Puedes agregar validaciones adicionales para el formato del correo
                return null;
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para enviar el correo de recuperación
                _showConfirmationDialog();
              },
              style: ElevatedButton.styleFrom(
                //primary: widget.themeData?.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset Link Sent'),
          content: Text('Please check your email for a password reset link.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Cierra la vista de Forgot Password
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
