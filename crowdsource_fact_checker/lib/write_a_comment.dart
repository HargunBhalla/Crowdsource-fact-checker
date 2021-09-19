import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'userConstants.dart';

class WriteCommentPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const WriteCommentPage ({ Key? key, required this.post }): super(key: key);

  @override
  State<WriteCommentPage> createState() => _WriteCommentPageState();
}

class _WriteCommentPageState extends State<WriteCommentPage> {
  static List<String> referencesList = [""];

  final _formKey = GlobalKey<FormState>();
  String comment = "";
  String source = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write A Comment"),
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
                        decoration: new InputDecoration(hintText: "Write your comment here"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a comment';
                          }
                          setState(() {
                            comment = value;
                          });
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('References',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  ..._getReferences(),
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

          print(widget.post['id']);
          setState(() {
            if (widget.post['comments'] != null) {
              var list = widget.post['comments'];
              var realList = list.toList();
              realList.add({
                "username": UserConstants.username,
                "profilePicture": UserConstants.profilePicture,
                "comment": comment
              });
              widget.post['comments'] = realList;
            } else {
              widget.post['comments'] = [{
                "username": UserConstants.username,
                "profilePicture": UserConstants.profilePicture,
                "comment": comment
              }];
            }
          });
          FirebaseFirestore.instance.collection("posts").doc(widget.post['id']).update({"comments": widget.post['comments']});
            Navigator.pop(context, widget.post['comments']);
          }
        },
        tooltip: 'Submit',
        label: const Text('Submit'),
        icon: const Icon(Icons.arrow_upward_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _getReferences(){
    List<Widget> friendsTextFieldsList = [];
    for(int i=0; i<referencesList.length; i++){
      friendsTextFieldsList.add(
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: ReferencesFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row only
                _addRemoveButton(i == referencesList.length-1, i),
              ],
            ),
          )
      );
    }
    return friendsTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          referencesList.insert(0, "");
        }
        else referencesList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove, color: Colors.white,
        ),
      ),
    );
  }
}


class ReferencesFields extends StatefulWidget {
  final int index;
  ReferencesFields(this.index);
  @override
  _ReferencesFieldsState createState() => _ReferencesFieldsState();
}
class _ReferencesFieldsState extends State<ReferencesFields> {
  TextEditingController _nameController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController.text = _WriteCommentPageState.referencesList[widget.index]
          ?? '';
    });
    return TextFormField(
      controller: _nameController,
      // save text field data in friends list at index
      // whenever text field value changes
      onChanged: (v) => _WriteCommentPageState.referencesList[widget.index] = v,
      decoration: InputDecoration(
          hintText: 'Enter a reference'
      ),
      validator: (v){
        //validate
        //if(v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}