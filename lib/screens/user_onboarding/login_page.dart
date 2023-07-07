import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_notes_app/screens/home/home_page.dart';
import 'package:online_notes_app/screens/user_onboarding/sign_up_page.dart';

class Login_Page extends StatefulWidget {


  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  late FirebaseFirestore firestore;
  late CollectionReference<Map<String,dynamic>> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestore = FirebaseFirestore.instance;
    users = firestore.collection('Users');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "e-mail",
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: passController,
                decoration: InputDecoration(
                  hintText: "password",
                ),
              ),
              SizedBox(height: 80,),
              ElevatedButton(onPressed: () async{
                try{
                  var logInCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email:emailController.text.toString() ,
                      password:passController.text.toString() );
                  print(logInCred.user!.uid);

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Page(),));
                }on FirebaseAuthException catch(e){
                  print(e.toString());
                  if(e.code == "wrong-password"){
                    print("wrong password");
                  }else if(e.code == 'user-not-found'){
                    print('user not found ');
                  }
                } catch(e){
                  print(e.toString());
                }



              }, child: Text("Login")),
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              Container(
                height: 1,
                  width: double.infinity,
                color: Colors.black,
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account, "),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp_Page(),));
                      },
                      child: Text("Create One ",style: TextStyle(color: Colors.blue),)),
                ],
              )
            ],

          ),
        ),
      ),
    );
  }
}
