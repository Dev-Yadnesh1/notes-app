import 'dart:math' as math;


import 'package:flutter/material.dart';
Widget NoteCard ({required String title, required String desc,} ){

  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.35),

      borderRadius: BorderRadius.circular(16)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(fontSize: 30),maxLines: 2,overflow: TextOverflow.ellipsis,),
        SizedBox(height: 16,),
        Text(desc,
          style: TextStyle(fontSize: 18,color: Colors.grey[600],fontWeight: FontWeight.normal),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,)

      ],
    ),
  );
}