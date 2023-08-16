import 'package:ahmed_wael_ecommerce_app/product_list.dart';
import 'package:ahmed_wael_ecommerce_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _togglePasswordVisibility() async {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _signIn() async {
    // Validate username and password here
    String username = _usernameController.text;
    String password = _passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (username == savedUsername && password == savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed in successfully'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect Username or Password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  style: TextStyle(color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.amber),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(color: Colors.amber),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    labelStyle: TextStyle(color: Colors.amber),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signIn,
                  child: Text('Sign In', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text('Sign Up', style: TextStyle(color: Colors.amber)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
