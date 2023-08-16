import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _togglePasswordVisibility() async {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _signUp() async {
    String name = _nameController.text;
    String username = _usernameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    if (name.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Name must be at least 2 characters'),
        ),
      );
    } else if (username.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username must be at least 2 characters'),
        ),
      );
    } else if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email format'),
        ),
      );
    } else if (phone.length < 9 ||
        phone.length > 13 ||
        int.tryParse(phone) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Phone number must be between 9 and 13 numerical characters'),
        ),
      );
    } else if (password.length < 8 || password.length > 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be between 8 and 16 characters'),
        ),
      );
    } else {
      // Save user data in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      await prefs.setString('phone', phone);
      await prefs.setString('password', password);

      // Redirect to Sign In
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _usernameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(color: Colors.white),
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
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
