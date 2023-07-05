import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_notes_app/screens/add_notes_page.dart';
import 'package:online_notes_app/screens/note_card.dart';

import '../ui_helper.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

late FirebaseFirestore firestore;
late CollectionReference<Map<String,dynamic>> Notes;
late Stream<QuerySnapshot<Map<String,dynamic>>> futureNotes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestore = FirebaseFirestore.instance;
   Notes = firestore.collection("Notes");
    futureNotes = Notes.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
      ),
      body: StreamBuilder(
        stream: futureNotes,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!= null && snapshot.data!.docs.isNotEmpty ){
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,


                ),
                itemCount: snapshot.data!.docs.length  ,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){},
                    child: NoteCard(
                        title: "${snapshot.data!.docs[index].get("title")}",
                        desc: "${snapshot.data!.docs[index].get("desc")}",

                    ),
                  );
                },);
          }else if(snapshot.hasError) {
            return Text("Error:${snapshot.error}");
          }else{
            return Container();
          }

        
      },),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Notes_Page(),));
        },),
    );
  }
}
