import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'note.dart';

class CrudHelper {
  static const String boxName = 'note';

  static void add(Note note) {
    final box = Hive.box<Note>(boxName);
    box.add(note);
  }

  static void update(dynamic id, Note updatednote) {
    final box = Hive.box<Note>(boxName);
    box.put(id, updatednote);
  }

  static List<Note> getAll() {
    final box = Hive.box<Note>(boxName);
    return box.values.toList();
  }

  static Note? getById(dynamic id) {
    final box = Hive.box<Note>(boxName);
    return box.get(id);
  }

  static void delete(dynamic id) {
    final box = Hive.box<Note>(boxName);
    box.delete(id);
  }

  static void clear() {
    final box = Hive.box<Note>(boxName);
    box.clear();
  }

  static registsHive() async {
    await Hive.initFlutter();
    WidgetsFlutterBinding.ensureInitialized();
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(NoteAdapter());
    await Hive.openBox<Note>(CrudHelper.boxName);
  }
}
