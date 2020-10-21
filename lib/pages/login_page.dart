import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takuonline/providers/is_signed_in.dart';


class Login extends StatefulWidget {
  static final id = '/login' ;


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


String _email ;
String _password ;

final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    bool _isLoggedIn =  context.watch<IsLoggedIn>().isLoggedIn;


    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Text(
                  'login',
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
                    var result = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    print(result);
                    print('is result');

                    if (result != null) {
                      context.read<IsLoggedIn>().setIsLoggedIn(true);
                      Navigator.pop(context);
                    }
                  } catch (e) {}
                },

                child: Text(
                    'Login'
                ),
              ),
              Spacer(flex:2),


            ],
          ),
        ));
  }
}
