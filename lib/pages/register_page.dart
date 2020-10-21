import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:takuonline/pages/login_page.dart';

class RegistrationPage extends StatefulWidget {
  static final id = 'Registration';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _email;

  String _password;

  final _auth = FirebaseAuth.instance;



  @override
  void initState() {
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              'Register',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            color: Colors.black,
            child: TextField(
              onChanged: (value) {
                _email = value;
              },
              controller: TextEditingController(text: _email),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter you email',
              ),

//            textInputAction: TextInputAction.,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            color: Colors.black,
            child: TextField(
              onChanged: (value) {
                _password = value;
              },

              controller: TextEditingController(text: _password),
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter you Password',
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              //ToDo: sign in users

              try {
                var result = await _auth.createUserWithEmailAndPassword(
                    email: _email, password: _password);
                print(result);
                print('is result');

                if (result != null) {
                  Navigator.pop(context);
                }
              } catch (e) {}
            },

            child: Text(
              'Login'
            ),
          ),
          Spacer(flex:2),
          FlatButton(
            onPressed: () {
              //ToDo: already have an account


              Navigator.pushReplacementNamed(context,Login.id);

            },
            child: Text('Already have an account?',style: TextStyle(
              color: Colors.black
            ),),
          ),
        ],
      ),
    ));
  }
}
