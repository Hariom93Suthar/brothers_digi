import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
);

void nextscreen(page){
  Get.to(page);
}