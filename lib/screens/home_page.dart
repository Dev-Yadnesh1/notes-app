

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_notes_app/screens/add_notes_page.dart';
import 'package:online_notes_app/screens/edit_note_page.dart';
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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
              return ListTile(
                leading: Text("${index+1}"),
                title: Text("${snapshot.data!.docs[index]["title"]}",overflow: TextOverflow.ellipsis,maxLines: 2,),
                subtitle: Text("${snapshot.data!.docs[index]["desc"]}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                trailing: Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      // Edit Functoin //
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Note_Page(),));
                          },
                          child: Icon(Icons.edit)),
                      SizedBox(width: 16,),
                      // delete function //
                      InkWell(
                          onTap: (){
                            Notes.doc(snapshot.data!.docs[index].id).delete().then((value) {print("Note deleted");});
                          },
                          child: Icon(Icons.delete,color: Colors.red,)),
                    ],
                  ),
                ),
              );
            },);
          }else if( snapshot.data!.docs.isEmpty){
            return Center(child: Text("No Notes yet"));
          } else if(snapshot.hasError) {
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
