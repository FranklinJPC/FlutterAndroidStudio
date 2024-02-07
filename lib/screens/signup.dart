import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies/screens/login.dart';
import '../theme/theme_state.dart';

class SignUpScreen extends StatelessWidget {
  final ThemeData? themeData;
  SignUpScreen({this.themeData});

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
          'Sign Up',
          style: themeData!.textTheme.headline5,
        ),
      ),
      body: SignUpForm(themeData: themeData),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final ThemeData? themeData;
  SignUpForm({this.themeData});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return Container(
      //color: widget.themeData?.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                //color: widget.themeData?.primaryColor,
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    icon: Icon(Icons.person),
                  ),
                  style: widget.themeData?.textTheme.bodyText1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                //color: widget.themeData?.primaryColor,
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    icon: Icon(Icons.person),
                  ),
                  style: widget.themeData?.textTheme.bodyText1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                //color: widget.themeData?.primaryColor,
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
               // color: widget.themeData?.primaryColor,
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
                    // Acción del botón de registro
                  }
                },
                style: ElevatedButton.styleFrom(
                  //primary: widget.themeData?.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Sign Up'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        themeData: state.themeData,
                      ),
                    ),
                  );
                },
                child: Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

