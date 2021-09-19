import 'package:crowdsource_fact_checker/about_page.dart';
import 'package:crowdsource_fact_checker/userConstants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';


int numFacts = 0;

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("User Info"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: [
         Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,30,0,20),
                child: CircleAvatar(
                  radius: 88.0,
                  backgroundImage:
                  NetworkImage(UserConstants.profilePicture),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Text(UserConstants.username, style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),),
              Text(UserConstants.usercode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              Container(height: 30,),
              NumbersWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 32, 16, 16),
                    child: Text("Your Facts", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700,),),
                  ),
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("posts").snapshots(),
                  builder:(context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      numFacts = 0;
                      return Container(
                        child: Column(
                            children: [
                              ...snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                if (data["username"] == UserConstants.username) {
                                  print(document.id.toString());
                                  numFacts += 1;
                                  return PostTile(post: data);
                                }else{
                                  return Container();
                                }
                              }).toList(),
                              Container(height: 100,)
                            ]
                        ),
                      );
                    }
                  }
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        },
        tooltip: 'New Fact',
        icon: const Icon(Icons.edit),
        label: Text("Edit"),
      ), //
    );
  }
}


class NumbersWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton(context, numFacts.toString(), 'Facts'),
      buildDivider(),
      buildButton(context, '35', 'Checks'),
      buildDivider(),
      buildButton(context, '12', 'References'),
    ],
  );
  Widget buildDivider() => Container(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
