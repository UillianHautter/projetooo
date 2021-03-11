import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget{

  ErrorBox({this.message});

  final  String message;

  @override
  Widget build(BuildContext context){
    if(message == null)
      return Container();
    return Container(
      color: Colors.red,
        padding: const EdgeInsets.all(5),
        child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(width: 15,),
          Expanded(
            child: Text(
              'Error! $message. Tente novamente ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),
            ),
          ),
        ],
      ),
    );
  }
}