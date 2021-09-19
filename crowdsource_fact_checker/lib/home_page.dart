import 'package:crowdsource_fact_checker/new_post_form.dart';
import 'package:crowdsource_fact_checker/user_page.dart';
import 'package:crowdsource_fact_checker/view_thread.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class PostItem {
  String userName;
  String fact;
  String comments;
  String truthRating;

  PostItem(this.userName, this.fact, this.comments, this.truthRating);

  PostItem.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        comments = json['comments'],
        truthRating = json['rating'],
        fact = json['fact'];

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'comments': comments,
    'rating': truthRating,
    'fact': fact,
  };
}
class _HomePageState extends State<HomePage> {

  List<PostItem> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*Image.asset(
            'assets/Crowdcheck_App_Icon.png',
            fit: BoxFit.contain,
            height: 32,
          ),*/
          Icon(Icons.check),
          Container(
              padding: const EdgeInsets.all(8.0), child: Text('crowdcheck'))
        ],

      ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserPage()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder:(context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16 ,8 ,8 ),
                        child: Text("New Posts For You", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),),
                      ),
                      ...snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      data['id'] = document.id.toString();
                      return PostTile(post: data);
                   }).toList(),
                      Container(height: 100,)
                  ]
                  ),
                  );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPostForm()),
          );
        },
        tooltip: 'New Fact',
        child: const Icon(Icons.post_add_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Map<String, dynamic> post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        child: InkWell (
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewThreadPage(post: post,)),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,8,16,8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12.0,
                      backgroundImage:
                      NetworkImage(post['profilePicture']),
                      backgroundColor: Colors.transparent,
                    ),
                    Container(width: 5,),
                    Text(post['username'] ?? "username missing"),
                    Spacer(),
                    Text(post['rating'] ?? "Not Answered"),
                    Container(width: 5,),
                    (post['rating'] == null) ?
                      Icon(Icons.question_answer, color: Colors.grey,) :
                      int.parse(post['rating']) < 7 ?
                      Icon(Icons.close, color: Colors.red,) :
                      int.parse(post['rating']) < 7 ?
                      Icon(Icons.horizontal_rule_rounded, color: Colors.grey,) :
                      //Icon(Icons.done_outline_rounded, color: Colors.green,),
                      Icon(Icons.verified_outlined, color: Colors.green,),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 20),
                child: Text(post['fact'] ?? "Content missing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12,8,16,8),
                child: Row(
                  children: [
                    Icon(Icons.mode_comment_outlined),
                    Container(width: 5,),
                    Text(post["numComments"] ?? "0"),
                    Spacer(),
                    Icon(Icons.share_outlined,),
                    Container(width: 5,),
                    Text("Share"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
