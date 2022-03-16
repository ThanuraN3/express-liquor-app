
import 'package:express/AllScreens/loginScreen.dart';
import 'package:express/AllScreens/mainscreen.dart';
import 'package:express/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatelessWidget {
   RegistrationScreen({Key? key}) : super(key: key);

  //Registration and Login page link
  static const String idScreen="register";

  //Connect firebase
  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController nicTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();
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
              SizedBox(height: 1.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 150.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Register Here",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
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
                      controller: nicTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "NIC",
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
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
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
                            "Create Account",
                            style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: ()
                      {
                        // print("Register in Button Clicked");
                        if(nameTextEditingController.text.length<3)
                          {
                            dispayToastMessage("Name must be atleast 3 Characters.", context);
                          }
                        else if(nicTextEditingController.text.isEmpty)
                        {
                          dispayToastMessage("NIC number is mandatory", context);
                        }
                        else if(!emailTextEditingController.text.contains("@"))
                          {
                            dispayToastMessage("Email address is not valid.", context);
                          }
                        else if(phoneTextEditingController.text.isEmpty)
                        {
                          dispayToastMessage("Phone number is mandatory", context);
                        }
                        else if(passwordTextEditingController.text.length<6)
                        {
                          dispayToastMessage("Password is must be atleast 6 Characters.", context);
                        }
                        else
                          {
                            registerNewUser(context);
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
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                    "Already have an Account? Login Here."
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  //Save Data in Database
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void registerNewUser(BuildContext context)async
   {
      final User? firebaseUser=(await _firebaseAuth
         .createUserWithEmailAndPassword(
         email: emailTextEditingController.text,
         password: passwordTextEditingController.text).catchError((errMsg){
           dispayToastMessage("Error: "+errMsg.toString(), context);
      })).user;

      if(firebaseUser!=null)//User Created
        {
          //Save User into database


          Map userDataMap={
            "name":nameTextEditingController.text.trim(),
            "nic":nicTextEditingController.text.trim(),
            "email":emailTextEditingController.text.trim(),
            "phone":phoneTextEditingController.text.trim(),
          };
          userRef.child(firebaseUser.uid).set(userDataMap);
          dispayToastMessage("Congratulations, your account has been created.", context);

          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
        }
      else
        {
          //Failed data into database display message
          dispayToastMessage("New user account has not been Created.", context);
        }
   }

}

dispayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}
