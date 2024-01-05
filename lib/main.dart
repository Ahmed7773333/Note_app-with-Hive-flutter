import 'package:flutter/material.dart';
import 'package:noota/hive_helper.dart';
import 'my_app.dart';

void main() async {
  await CrudHelper.registsHive();
  runApp(const NoteApp());
}
