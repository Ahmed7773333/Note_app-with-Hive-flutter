import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'note.dart';
import 'note_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
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
      List<Note> results = notes
          .where((note) =>
              note.title.toLowerCase().contains(searchText.toLowerCase()) ||
              note.subject.toLowerCase().contains(searchText.toLowerCase()))
          .toList();

      if (results.isEmpty) {
        setState(() {
          _searchResults = [];
        });
      } else {
        setState(() {
          _searchResults = results;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: const EdgeInsets.only(
              top: 0.0, left: 10.0, right: 10.0), // Add padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), // Make it circular
            color: const Color(0xff3B3B3B),
          ),
          child: TextField(
            style: const TextStyle(
              color: Color(0xffCCCCCC),
              fontSize: 20,
            ),
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by the keyword...',
              hintStyle: const TextStyle(
                color: Color(0xffCCCCCC),
                fontSize: 20,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
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
              contentPadding: const EdgeInsets.all(
                  10.0), // Add padding inside the TextField
            ),
          ),
        ),
      ),
      body: _searchController.text.isEmpty || _searchResults.isEmpty
          ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/search.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Align(
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
                    style: const TextStyle(
                      color: Color(0xffCCCCCC),
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotePage(
                          note: _searchResults[index],
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
