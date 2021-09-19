import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'userConstants.dart';

class NewPostForm extends StatefulWidget {
  const NewPostForm({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<NewPostForm> createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {

  final _formKey = GlobalKey<FormState>();
  String fact = "";
  String source = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Fact Check"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 5,
                        decoration: new InputDecoration(hintText: "Enter a fact to check. E.g. Facebook post, Instagram post, Twitter thread, News article, etc."),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a fact to check';
                          }
                          setState(() {
                            fact = value;
                          });
                          return null;
                        },
                      ),
                    ),
                  ),
              Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLines: 2,
                    minLines: 1,
                    decoration: new InputDecoration(hintText: "Fact Source"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the source of your fact';
                      }
                      setState(() {
                        source = value;
                      });
                      return null;
                    },
                  ),
                ),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            CollectionReference reference = FirebaseFirestore.instance
                .collection('posts');
            reference
                .add({"fact": fact, "factSource": source, "username": UserConstants.username, "profilePicture": UserConstants.profilePicture});
            Navigator.pop(this.context);
          }
        },
        tooltip: 'Submit',
        label: const Text('Submit'),
        icon: const Icon(Icons.arrow_upward_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
