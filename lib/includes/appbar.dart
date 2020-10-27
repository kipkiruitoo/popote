import 'package:flutter/material.dart';

Widget appbar({String title, bool haveBack, }){
  return AppBar(
      title: Text(title, style: TextStyle(color: Colors.black),),
    elevation: 0,
    backgroundColor: Colors.white,
  );
}