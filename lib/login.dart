import 'package:e2ee_messaging_app/view/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final usernameTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    final email = TextFormField(
      controller: usernameTextController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordTextController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          /*
          burada Login fonksiyonu çağırılarak userID alınabilir.
          */ 
          print("username:" + email.controller.text);
          print("password:" + password.controller.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatsPage(userId: email.controller.text,),
              ));},
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Login',
            style: TextStyle(
                color: Color(0xFF006175), fontWeight: FontWeight.bold)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      onPressed: () {},
    );
    final createaccount = FlatButton(
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.pink]
                    )
                  ),
                ),
                Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Image.asset('assets/logo.png',  height: 200,),
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: email,
              ),
             
              password,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel,
              createaccount,
            ],
          ),
        )
              ] ,
      ),
    );
  }
}
