import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';






Widget defaultMaterialButton({
required final void Function()? function,
required String text,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blueGrey[100],
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );



Widget defaultTextButton({
  required final Function()? function,
  required String text,
  Color textColor=defaultColor,
}) =>
    MaterialButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
        ),
      ),
    );


Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,//
  final String? Function(String?)? onChange,//
  final String? Function(String?)? onSubmit,//
  void Function()? onTap,
  bool obsecuredText = false,
  IconData? suffix,
  void Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap:onTap,
      validator: validate,
      obscureText: obsecuredText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ))
            : null,
      ),
    );

Widget mySeparator()=>Padding(
  padding: const EdgeInsetsDirectional.only(

    top: 15,
    bottom: 15,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  ),
);


 pushNavigateTo(context,widget)
{
  Navigator.push(
    context ,
    MaterialPageRoute(builder: (context)
    {return widget;}
    ),
  );

}
// Navigator method
pushAndRemoveNavigateTo(context,widget)
{
  Navigator.pushAndRemoveUntil(
    context ,
    MaterialPageRoute(builder: (context)
    {return widget;}
    ),
    (Route<dynamic> route) => false,
  );

}


void showToast({required String msg,required MsgState status})=>Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 10,
    backgroundColor: SelectMsgColor(status),
    textColor: Colors.white,
    fontSize: 16.0,

);

enum MsgState{SUCCESS,ERROR,WARNING}


Color SelectMsgColor(MsgState status){

  Color color;

  switch (status)
      {
    case MsgState.SUCCESS:
      color=Colors.green;
      break;

      case MsgState.ERROR:
      color=Colors.red;
      break;

      case MsgState.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}

