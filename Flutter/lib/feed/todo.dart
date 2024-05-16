import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../colors.dart';
import '../home.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _todoController = TextEditingController();
  List<Map<String, dynamic>> todosList = [];

  @override
  @override
  void initState() {
    super.initState();
    // Get the current user's email
    String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    // Load to-do items from Firestore for the current user
    _loadToDoItems(userEmail);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todosList.length,
                itemBuilder: (context, index) {
                  return ToDoItem(
                    todo: todosList[index],
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            _buildAddTaskInput(),
          ],
        ),
      ),
    );
  }

  void _handleToDoChange(Map<String, dynamic> todo) {
    setState(() {
      todo['isDone'] = !todo['isDone'];
    });
    // Update the completed status in Firestore
    _updateToDoItem(todo);
  }

  void _deleteToDoItem(String id) async {
    setState(() {
      todosList.removeWhere((item) => item['id'] == id);
    });
    // Delete the item from Firestore
    await _firestore.collection('todo').doc(id).delete();
  }

  void _addToDoItem(String toDo) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Retrieve additional user information from Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          String name = userDoc['name'];
          String email = userDoc['email'];

          // Add the item to Firestore
          DocumentReference docRef = await _firestore.collection('todo').add({
            'userId': user.uid,
            'userName': name,
            'userEmail': email,
            'todoText': toDo,
            'isDone': false,
            'createdAt': FieldValue.serverTimestamp(),
          });

          // Update the local list with the added item
          setState(() {
            todosList.add({
              'id': docRef.id,
              'todoText': toDo,
              'isDone': false,
            });
          });
        }
      }
    } catch (error) {
      print('Failed to add to-do item: $error');
    }
  }

  void _loadToDoItems(String userEmail) async {
    try {
      // Fetch to-do items from Firestore for the specific user
      QuerySnapshot querySnapshot = await _firestore
          .collection('todo')
          .where('userEmail', isEqualTo: userEmail) // Filter by user's email
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> items = [];
      querySnapshot.docs.forEach((doc) {
        items.add({
          'id': doc.id,
          'todoText': doc['todoText'],
          'isDone': doc['isDone'],
        });
      });

      // Update the local list with fetched items
      setState(() {
        todosList = items;
      });
    } catch (error) {
      print('Failed to load to-do items: $error');
    }
  }


  void _updateToDoItem(Map<String, dynamic> todo) async {
    try {
      // Update the completed status in Firestore
      await _firestore.collection('todo').doc(todo['id']).update({'isDone': todo['isDone']});
    } catch (error) {
      print('Failed to update to-do item: $error');
    }
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'To-do List',
        style: TextStyle(
          color: AppColors.secondaryblue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userId: '',)));
          },
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
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddTaskInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _todoController,
            cursorColor: AppColors.secondaryblue, // Set cursor color
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: 'Add a new task',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.secondaryblue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.secondaryblue),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (_todoController.text.trim().isNotEmpty) {
              _addToDoItem(_todoController.text);
              _todoController.clear();
            }
          },
          icon: Icon(Icons.add, size: 30),
          color: AppColors.secondaryblue,
        ),
      ],
    );
  }
}

class ToDoItem extends StatelessWidget {
  final Map<String, dynamic> todo;
  final Function(Map<String, dynamic>) onToDoChanged;
  final Function(String) onDeleteItem;

  ToDoItem({
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryblue, // Choose your border color
          width: 1.0, // Choose your border width
        ),
        borderRadius: BorderRadius.circular(25.0), // Choose your border radius
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          todo['todoText'],
          style: TextStyle(
            decoration: todo['isDone'] ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Transform.scale(
          scale: 1.3,
          child: Checkbox(
            checkColor: Colors.white,
            shape: CircleBorder(),
            activeColor: AppColors.secondaryblue,
            value: todo['isDone'],
            onChanged: (value) {
              onToDoChanged(todo);
            },
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            onDeleteItem(todo['id']);
          },
        ),
      ),
    );
  }
}
