import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../colors.dart';
import 'journalling.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _journalController = TextEditingController();
  List<String> journalEntries = [];


  @override
  void initState() {
    super.initState();
    // Load journal entries from Firestore when the widget initializes
    _loadJournalEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: _refreshJournalEntries,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'List of Journal Entries:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryblue,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: journalEntries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.secondaryblue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _getEmoji(journalEntries[index]), // Display emoji
                            style: TextStyle(fontSize: 20), // Font size for emoji
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _getNoteText(journalEntries[index]), // Display note text
                              style: TextStyle(fontFamily: 'Poppins'), // Set font to Poppins
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final updatedEntries = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JournallingPage()),
          );
          if (updatedEntries != null) {
            setState(() {
              journalEntries = List.from(updatedEntries);
              _saveEntryToFirestore(updatedEntries.last); // Save the last entry to Firestore
            });
          }
        },
        backgroundColor: AppColors.secondaryblue,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _refreshJournalEntries() async {
    await _loadJournalEntries();
  }

  String _getEmoji(String entry) {
    // Extracts the emoji from the entry
    List<String> parts = entry.split(' - ');
    // Replace text representation with emoji
    switch (parts[0]) {
      case 'sad':
        return '😢';
      case 'neutral':
        return '😐';
      case 'happy':
        return '😊';
      case 'very happy':
        return '😄';
      case 'excited':
        return '😃';
      default:
        return '';
    }
  }

  String _getNoteText(String entry) {
    // Extracts the note text from the entry
    List<String> parts = entry.split(' - ');
    return parts[1];
  }

  Future<void> _loadJournalEntries() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Fetch journal entries from Firestore collection
      QuerySnapshot querySnapshot = await _firestore
          .collection('journals')
          .where('userId', isEqualTo: userId) // Filter by userId
          // .where('userEmail', isEqualTo: FirebaseAuth.instance.currentUser!.email) // Filter by userEmail
          .orderBy('timestamp', descending: true)
          .get();

      List<String> entries = [];
      querySnapshot.docs.forEach((doc) {
        // Construct entry string with emoji and note
        String entry = doc['emoji'] + ' - ' + doc['journal'];
        entries.add(entry);
      });
      setState(() {
        journalEntries = entries;
      });
    } catch (error) {
      print('Failed to load journal entries: $error');
    }
  }


  void _saveEntryToFirestore(String entry) async {
    // Your save entry code here...
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Journal',
        style: TextStyle(
          color: AppColors.secondaryblue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

