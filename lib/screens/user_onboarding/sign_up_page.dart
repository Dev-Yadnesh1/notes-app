import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp_Page extends StatefulWidget {

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var mobNoController = TextEditingController();

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "e-mail",
                ),
              ),
              TextField(
                controller: passController,
                decoration: InputDecoration(
                  hintText: "password",
                ),
              ),
              TextField(
                controller: mobNoController,
                decoration: InputDecoration(
                  hintText: "mob-no",
                ),
              ),
              ElevatedButton(
                  onPressed: () async{
                try{
                  var signInCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email:emailController.text.toString() ,
                      password:passController.text.toString() );
                  print(signInCred.user!.uid);

                  users.doc(signInCred.user!.uid).set({
                    "uid" : signInCred.user!.uid.toString(),
                    "email" :emailController.text.toString(),
                    "pass" :passController.text.toString(),
                    "mob-no" :mobNoController.text.toString()
                  });
                  Navigator.pop(context);
                }on FirebaseAuthException catch(e){
                  print(e.toString());
                  if(e.code == "weak-password"){
                    print("weak password");
                  }else if(e.code == 'email-already-in-use'){
                    print('email already existed');
                  }
                } catch(e){
                  print(e.toString());
                }



              },
                  child: Text("Create account")),
            ],
          ),
        ),
      ),
    );
  }
}
