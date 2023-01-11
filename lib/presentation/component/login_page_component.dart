


import 'package:flutter/material.dart';

Widget textFormField({
  required String lable,
  Function(String)? onChanged,
  required bool obscure

}) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    obscureText: obscure ,

    onChanged: onChanged ,
    validator: (data){
      if(data!.isEmpty){
        return 'please enter valid data';
      }

    },
    decoration:  InputDecoration(
      labelText: lable,
      labelStyle: const TextStyle(
          color: Colors.white
      ),
      border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          )
      ),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          )
      ),


    ),
  ),
);
Widget defaultMaterialButton({
  required String text,
  VoidCallback? function
})=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: double.infinity,

    height: 50.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            250.0,

        ),
        color: Colors.white

    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),

    ),
  ),
);

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context,String message,Color color)=>ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(message),
    backgroundColor: color,
  ),
);
