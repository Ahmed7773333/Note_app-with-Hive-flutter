import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/iconbtn.dart';
import 'package:note_app/note.dart';

import 'addnotePage.dart';
import 'notePage.dart';
import 'search.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String mapToPattern(int n) {
  final pattern = ['0', '1', '2', '3', '4', '5'];

  final indexInPattern = n % pattern.length;

  return pattern[indexInPattern];
}

class _HomeScreenState extends State<HomeScreen> {
  bool visi = true;
  List<Color> colors = [
    Color(0xffFD99FF),
    Color(0xffFF9E9E),
    Color(0xff91F48F),
    Color(0xffFFF599),
    Color(0xff9EFFFF),
    Color(0xffB69CFF),
  ];
  String information =
      '''Home Screen: When you open the app, you'll see the home screen. This screen lists all your notes. If you haven't created any notes yet, you'll see a message encouraging you to create your first note.

Creating a Note: To create a note, tap the '+' button located at the bottom right corner of the home screen. This will take you to the 'Add Note' page. Here, you can enter the title and content of your note. Once you're done, tap the 'Save' button in the top right corner to save your note.

Viewing a Note: To view a note, simply tap on it from the list on the home screen. This will take you to the 'Note' page where you can see the details of your note.

Editing a Note: To edit a note, open the note and then tap the 'Edit' button (pencil icon) in the top right corner. This will allow you to modify the title and content of your note. Remember to tap 'Save' after making your changes.

Deleting a Note: To delete a note, long press on it from the list on the home screen. A delete icon will appear. Tap on it to delete the note.

Searching for a Note: To search for a note, tap the 'Search' icon (magnifying glass) in the top right corner of the home screen. This will take you to the 'Search' page. Here, you can enter a keyword to search for in your notes. The results will update as you type.

Info Button: The 'Info' button (i in a circle) in the top right corner of the home screen provides information about the app.

Remember, your notes are saved locally on your device and are not backed up anywhere. So be careful not to uninstall the app or clear its data, or you might lose your notes.''';
  bool _showDelete = false;
  int _longPressedIndex = -1;

  void _longPress(int index) {
    setState(() {
      _showDelete = true;
      _longPressedIndex = index;
    });
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showDelete = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Box<Note> notesBox = Hive.box<Note>('note');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Notes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 43,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
              child: Iconbtn(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  size: 24),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: AlertDialog(
                        contentPadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.2,
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        actionsAlignment: MainAxisAlignment.center,
                        backgroundColor: Color(0xff252525),
                        title: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  information,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xff30BE71))),
                            child: Text(
                              'ok',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Iconbtn(
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                  size: 24),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder(
              valueListenable: notesBox.listenable(),
              builder: (context, Box box, widget) {
                if (box.isEmpty) {
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bg.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Create your first note !',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          Note Notes = box.getAt(index);
                          return Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotePage(
                                      title: (box.getAt(index)).title,
                                      subject: (box.getAt(index)).subject,
                                      time: (box.getAt(index)).time,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () => _longPress(index),
                              child: Card(
                                elevation: 5,
                                color: colors[int.parse(mapToPattern(index))],
                                shadowColor: Colors.black,
                                child: Stack(
                                  children: [
                                    // Original Container
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: colors[
                                            int.parse(mapToPattern(index))],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          Notes.title,
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Delete Container
                                    Positioned.fill(
                                      child: AnimatedOpacity(
                                        opacity: _showDelete &&
                                                _longPressedIndex == index
                                            ? 1.0
                                            : 0.0,
                                        duration: Duration(seconds: 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                if (_showDelete)
                                                  setState(() {
                                                    box.deleteAt(index);
                                                    _longPressedIndex = -1;
                                                  });
                                                else
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          NotePage(
                                                        title:
                                                            (box.getAt(index))
                                                                .title,
                                                        subject:
                                                            (box.getAt(index))
                                                                .subject,
                                                        time: (box.getAt(index))
                                                            .time,
                                                        index: index,
                                                      ),
                                                    ),
                                                  );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              }),
          Positioned(
            right:
                MediaQuery.of(context).size.width * 0.05, // 5% from the right
            bottom:
                MediaQuery.of(context).size.height * 0.05, // 5% from the bottom
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotePage(
                      title: '',
                      subject: '',
                      time: '',
                    ),
                  ),
                );
              },
              backgroundColor: Color(0xff252525),
              elevation: 5.0, // This is the shadow
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
