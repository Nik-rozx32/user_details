import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUserDetails(String userId) async {
    await firestore.collection('users').doc(userId).collection('details').add({
      'name': nameController.text,
      'email': emailController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    String userId = 'user_id';

    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await addUserDetails(userId);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Details added')));
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
