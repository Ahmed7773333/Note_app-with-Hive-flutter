import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/note.dart';
import 'package:note_app/notePage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Note> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
  }

  void _performSearch() {
    Box<Note> notesBox = Hive.box<Note>('note');
    String searchText = _searchController.text;

    if (searchText.isEmpty) {
      setState(() {
        _searchResults = [];
      });
    } else {
      List<Note> notes = notesBox.values.toList();
      setState(() {
        _searchResults = notes
            .where((note) =>
                note.title.toLowerCase().contains(searchText.toLowerCase()) ||
                note.subject.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin:
              EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0), // Add padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), // Make it circular
            color: Color(0xff3B3B3B),
          ),
          child: TextField(
            style: TextStyle(
              color: Color(0xffCCCCCC),
              fontSize: 20,
            ),
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by the keyword...',
              hintStyle: TextStyle(
                color: Color(0xffCCCCCC),
                fontSize: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Color(0xffCCCCCC),
                  size: 14,
                ),
                onPressed: () {
                  _searchController.clear();
                  Navigator.pop(context);
                },
              ),
              border: InputBorder.none, // Remove the underline
              contentPadding:
                  EdgeInsets.all(10.0), // Add padding inside the TextField
            ),
          ),
        ),
      ),
      body: _searchController.text.isEmpty && _searchResults.isEmpty
          ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/search.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'File not found. Try searching again.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _searchResults[index].title,
                    style: TextStyle(
                      color: Color(0xffCCCCCC),
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotePage(
                          title: _searchResults[index].title,
                          subject: _searchResults[index].subject,
                          time: _searchResults[index].time!,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
