import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/home.dart';
import 'package:note_app/iconbtn.dart';
import 'package:note_app/note.dart';

class AddNotePage extends StatefulWidget {
  final String title;
  final String subject;
  final String time;

  AddNotePage({
    required this.title,
    required this.subject,
    required this.time,
  });

  @override
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
              icon: Icon(Icons.arrow_back_ios, color: Colors.white), size: 24),
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
                      backgroundColor: Color(0xff252525),
                      title: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: Center(
                          child: Icon(
                            Icons.info,
                            color: Color(0xff606060),
                            size: 36,
                          ),
                        ),
                      ),
                      content: Text(
                        'Saving note?',
                        style: TextStyle(
                          color: Color(0xffCFCFCF),
                          fontSize: 23,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffFF0000))),
                          child: Text(
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
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff30BE71))),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            var box = Hive.box<Note>('note');
                            await box.add(Note(
                              title: _titleController.text,
                              subject: _subjectController.text,
                            ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
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
                    duration: Duration(milliseconds: 2500),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Container(
                      padding: EdgeInsets.all(16),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
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
            child:
                Iconbtn(icon: Icon(Icons.save, color: Colors.white), size: 24),
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
                    style: TextStyle(
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                  ),
                  decoration: InputDecoration(
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
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
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
