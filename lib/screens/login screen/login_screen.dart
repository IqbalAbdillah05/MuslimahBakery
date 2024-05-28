import 'package:flutter/material.dart';
import 'package:shopping_provider/screens/main_screen.dart';
import 'package:shopping_provider/screens/register%20screen/register_screen.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String _validUsername = 'user';
  final String _validPassword = '123';

  bool _obscurePassword = true;

  void _login() {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username == _validUsername && password == _validPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/latar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.jpg',
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 18, color:Colors.black)),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: _navigateToRegister,
                      child: Text('Register', style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
