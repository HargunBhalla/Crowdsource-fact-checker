import 'package:crowdsource_fact_checker/write_a_comment.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userConstants.dart';

class ViewThreadPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const ViewThreadPage ({ Key? key, required this.post }): super(key: key);

  @override
  State<ViewThreadPage> createState() => _ViewThreadPageState();
}

class _ViewThreadPageState extends State<ViewThreadPage> {

  Map<String, dynamic> post = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      post = widget.post;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fact Check"),
      ),
      body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8,8,0),
              child: Text(
                "Original Post",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
            PostTileView(post: this.widget.post,),
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 0, 6, 6),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,10,20,10),
                  child: Row(
                    children: [
                      Text("Average Truth Score: " + (widget.post["rating"] ?? "-")+"/10", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                      Spacer(),
                      (widget.post['rating'] == null) ?
                      Icon(Icons.question_answer, color: Colors.grey,) :
                      int.parse(widget.post['rating']) < 7 ?
                      Icon(Icons.close, color: Colors.red,) :
                      int.parse(widget.post['rating']) < 7 ?
                      Icon(Icons.horizontal_rule_rounded, color: Colors.grey,) :
                      //Icon(Icons.done_outline_rounded, color: Colors.green,),
                      Icon(Icons.verified_outlined, color: Colors.green,),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8,8,0),
              child: Text(
                "References",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 0, 6, 6),
              child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      ...List.generate(widget.post["references"] == null ? 0 : widget.post["references"].length, (index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () {
                            launch(widget.post["references"][index]["link"]);
                          },
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,8,8,0),
                                child: Row(
                                  children: [
                                    Container(width: 5,),
                                    Text(widget.post['references'][index]['title'] ?? "title missing", style: TextStyle(color: Color(0xff092b68), fontWeight: FontWeight.w500),),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 4, 8, 8),
                              child: Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                            )
                          ],
                        ),
                        );
                      }),
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8,8,0),
              child: Text(
                "Discussion",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 0, 6, 6),
              child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                child: Column(
                  children: [
                    ...List.generate(post["comments"] == null ? 0 : post["comments"].length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12.0,
                                  backgroundImage:
                                  NetworkImage(post['comments'][index]['profilePicture']),
                                  backgroundColor: Colors.transparent,
                                ),
                                Container(width: 5,),
                                Text(post['comments'][index]['username'] ?? "username missing"),
                                Spacer(),
                                Icon(Icons.reply_rounded),
                                Container(width: 5,),
                                Icon(Icons.keyboard_arrow_up),
                                Text(post['comments'][index]['votes'] ?? "0"),
                                Icon(Icons.keyboard_arrow_down),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            child: Text(post['comments'][index]["comment"] ?? "Content missing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 8, 12),
                            child: Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          )
                        ],
                      );
                    }),
                  ],
                )
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          var tmp = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WriteCommentPage(post: widget.post,)),
          );
          if (tmp != null) {
            post['comments'] = tmp;
          }
          print(post['comments'].toString());
          setState(() {
            post = post;
            widget.post['comments'] = post['comments'];
          });

        },
        tooltip: 'Comment',
        child: const Icon(Icons.comment_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class PostTileView extends StatelessWidget {
  const PostTileView({
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
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 15),
                child: Text(post['fact'] ?? "Content missing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,8,16,8),
                child: Row(
                  children: [
                    Spacer(),
                    Text("Source: " + (post["source"] ?? "Unknown")),
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
