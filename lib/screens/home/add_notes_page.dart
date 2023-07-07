import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add_Notes_Page extends StatelessWidget {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 40),
                controller:titleController ,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",

                ),

              ),
              Container(
                color: Colors.black,
                height: 1,
                width: double.infinity,
              ),

              Expanded(
                flex: 6,
                  child: TextField(
                    controller: descController,
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: (){
                        FirebaseFirestore firestore = FirebaseFirestore.instance;
                      var Notes = firestore.collection("Notes");
                      Notes.add({
                        "title" : titleController.text.toString(),
                        "desc" : descController.text.toString(),
                      }).then((value) {
                        print("Notes added");
                      });
                      Navigator.pop(context);

                      },
                      child: Text("Save")))
            ],
          ),
        ),
      ),
    );
  }
}
