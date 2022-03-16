import 'package:express/AllScreens/mainscreen.dart';
import 'package:express/AllScreens/registrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  //Registration and Login page link
  static const String idScreen="login";
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 25.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Log In",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 10.0,),
                    RaisedButton(
                      color: Colors.black54,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: ()
                      {
                        // print("Logged in Button Clicked");
                        if(!emailTextEditingController.text.contains("@"))
                        {
                          dispayToastMessage("Email address is not valid.", context);
                        }
                        else if(passwordTextEditingController.text.isEmpty)
                        {
                          dispayToastMessage("Password is mandatory.", context);
                        }
                        else
                        {
                          loginAndAuthenticateUser(context);
                        }

                      },
                    ),
                  ],
                ),
              ),

              FlatButton(
                onPressed: ()
                {
                  // print("Clicked");
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Do Not have an Account? Register Here."
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

   final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
   void loginAndAuthenticateUser(BuildContext context)async
   {
     final User? firebaseUser=(await _firebaseAuth
         .signInWithEmailAndPassword(
         email: emailTextEditingController.text,
         password: passwordTextEditingController.text).catchError((errMsg){
       dispayToastMessage("Error: "+errMsg.toString(), context);
     })).user;

     if(firebaseUser!=null)
     {
       await userRef.child(firebaseUser.uid).get().then((DataSnapshot snap){
         if(snap.value!=null)
           {
             Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
             dispayToastMessage("You are Logged-In Now.", context);
           }
         else
           {
             _firebaseAuth.signOut();
             dispayToastMessage("No record exists for this user. Please create new account.", context);
           }
       });
     }
     else
     {
       //Failed data into database display message
       dispayToastMessage("Error Occured. Can't sign.", context);
     }
   }

}
