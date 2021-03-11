import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget{

  FieldTitle ({this.title});

  final String title;


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      child: Wrap(
        children: [
          Text(
            '$title',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}