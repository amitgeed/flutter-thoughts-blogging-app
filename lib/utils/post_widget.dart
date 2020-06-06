import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twbh/screens/detailed_screen.dart';

FirebaseUser loggedInUser;
bool likedStatus = false;

class PostWidget extends StatelessWidget {
  PostWidget({
    this.likes,
    this.postDate,
    this.isMe,
    this.id,
    this.postText,
    this.postTime,
    this.postedBy,
  });

  final String postedBy;
  final String postText;
  final String postDate;
  final String postTime;
  final int likes;
  final bool isMe;
  final String id;

  @override
  Widget build(BuildContext context) {
    const end = "@";
    final endIndex = postedBy.toString().indexOf(end, 0);

    print(likes);
    print(postedBy);
    print(postDate);
    print(postText);
    print(postTime);
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DetailedScreen(
                        isMe: isMe,
                        likes: likes,
                        postDate: postDate,
                        postId: id,
                        postText: postText,
                        postTime: postTime,
                        postedBy: postedBy,
                      )));
        },
        child: Card(
          borderOnForeground: true,
          // color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.deepOrangeAccent,
                      radius: 20.0,
                      child: Text(
                        "${postedBy.toString().substring(0, 1).toUpperCase()}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Posted by ",
                                style: TextStyle(color: Colors.white38),
                              ),
                              Text(
                                postedBy.toString().substring(0, endIndex),
                                style: TextStyle(
                                  // color: Colors.white54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "On $postTime  $postDate",
                            style: TextStyle(
                                // color: Colors.white38,
                                ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  height: 1.0,
                  // color: Colors.white10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 15.0),
                  child: Text(
                    "\"$postText ...\"",
                    maxLines: 2,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      // color: Colors.white54,
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                  // color: Colors.white10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
