import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseUser loggedInUser;
bool likedStatus = false;

class CommentWidget extends StatelessWidget {
  CommentWidget({
    this.postId,
    this.postDate,
    this.isMe,
    this.commentText,
    this.postTime,
    this.postedBy,
    this.commentId,
  });

  final String postedBy;
  final String commentText;
  final String postDate;
  final String postTime;
  final String postId;
  final bool isMe;
  final String commentId;

  @override
  Widget build(BuildContext context) {
    const end = "@";
    final endIndex = postedBy.toString().indexOf(end, 0);

    print(commentText);
    print(postedBy);
    print(postDate);
    print(postTime);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 20.0,
                  child: Text(
                    "${postedBy.toString().substring(0, 1).toUpperCase()}",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
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
                            style: TextStyle(),
                          ),
                          Text(
                            postedBy.toString().substring(0, endIndex),
                            style: TextStyle(
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
                        style: TextStyle(),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(
              height: 1.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: Text(
                "\"$commentText\"",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              height: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
