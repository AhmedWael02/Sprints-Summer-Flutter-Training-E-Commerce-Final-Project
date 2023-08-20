import 'package:ahmed_wael_ecommerce_app/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahmed_wael_ecommerce_app/signin.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  String _username = '';
  String _email = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _username = prefs.getString('username') ?? '';
      _email = prefs.getString('email') ?? '';
      _phone = prefs.getString('phone') ?? '';
    });
  }

  Future<void> _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all cached data

    // Clear the cached products list
    clearCachedProducts();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 0),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/user_avatar.png'),
            ),
            SizedBox(height: 40),
            Text(
              'Name:',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              _name,
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              'Username:',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              _username,
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              'Email:',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              _email,
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              'Phone:',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              _phone,
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _logOut,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 40),
              ),
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
