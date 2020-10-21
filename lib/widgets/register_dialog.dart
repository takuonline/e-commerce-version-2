
import 'package:flutter/material.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/pages/register_page.dart';


class RegisterDialog  {
  static  Future<void> registerDialog(context) async {
    showDialog(
        context: context,
        builder: await (ctx) => AlertDialog(
          backgroundColor: kPrimaryColor,
          title: Text('Sign in First'),
          content: Text('You first need to register/sign in first',style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: Colors.black
          ),),
          actions: [

            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                 
                },
                child: Text('Close',style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black
                ),)),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RegistrationPage.id);
                },
                child: Text(' Sign In',style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black
                ),)),




          ],
        ));
  }
}

