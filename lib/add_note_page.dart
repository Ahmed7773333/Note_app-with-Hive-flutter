// ignore: file_names
import 'package:flutter/material.dart';
import 'package:noota/hive_helper.dart';

import 'home.dart';
import 'iconbtn.dart';
import 'note.dart';

class AddNotePage extends StatefulWidget {
  final String title;
  final String subject;
  final String time;

  const AddNotePage({
    super.key,
    required this.title,
    required this.subject,
    required this.time,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _subjectController.text = widget.subject;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Iconbtn(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              size: 24),
        ),
        actions: [
          InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.2,
                          bottom: MediaQuery.of(context).size.height * 0.02),
                      actionsAlignment: MainAxisAlignment.center,
                      backgroundColor: const Color(0xff252525),
                      title: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: const Center(
                          child: Icon(
                            Icons.info,
                            color: Color(0xff606060),
                            size: 36,
                          ),
                        ),
                      ),
                      content: const Text(
                        'Saving note?',
                        style: TextStyle(
                          color: Color(0xffCFCFCF),
                          fontSize: 23,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffFF0000))),
                          child: const Text(
                            'Discard',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff30BE71))),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            CrudHelper.add(Note(
                              title: _titleController.text,
                              subject: _subjectController.text,
                            ));

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            ); // pop the note page
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.5),
                    duration: const Duration(milliseconds: 2500),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'You can\'t leave any of both textfields empty!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
            child: Iconbtn(
                icon: const Icon(Icons.save, color: Colors.white), size: 24),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.time,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
                TextFormField(
                  controller: _titleController,
                  maxLines: 3,
                  maxLength: 50,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Color(0xff9A9A9A),
                      fontSize: 48,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _subjectController,
                  maxLines: 100,
                  maxLength: 4000,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 23),
                  decoration: const InputDecoration(
                    hintText: 'Type something...',
                    hintStyle:
                        TextStyle(color: Color(0xff9A9A9A), fontSize: 23),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
