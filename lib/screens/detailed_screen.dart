import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:twbh/utils/comment_widget.dart';

String onPosted;

class DetailedScreen extends StatefulWidget {
  DetailedScreen({
    this.isMe,
    this.likes,
    this.postDate,
    this.postId,
    this.postText,
    this.postTime,
    this.postedBy,
    this.cpostedBy,
    this.cpostText,
    this.cpostDate,
    this.cpostTime,
    this.cId,
    this.onPostId,
  });

  final String postedBy;
  final String postText;
  final String postDate;
  final String postTime;
  final int likes;
  final bool isMe;
  final String postId;
  final String cpostedBy;
  final String cpostText;
  final String cpostDate;
  final String cpostTime;
  final String cId;
  final String onPostId;

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String commentText;
FirebaseAuth _auth = FirebaseAuth.instance;

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    onPosted = widget.postId;
    const end = "@";
    final endIndex = widget.postedBy.toString().indexOf(end, 0);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black87,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                        radius: 25.0,
                        child: Text(
                          "${widget.postedBy.toString().substring(0, 1).toUpperCase()}",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                            // color: Colors.white,
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
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  widget.postedBy
                                      .toString()
                                      .substring(0, endIndex),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "On ${widget.postTime}  ${widget.postDate}",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 15.0),
                    child: Text(
                      "\"${widget.postText}\"",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            widget.likes != null
                                ? Text(
                                    widget.likes.toString(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  )
                                : Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                            SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  _firestore
                                      .collection('posts')
                                      .document(widget.postId)
                                      .updateData({'like': widget.likes + 1});
                                },
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 20.0,
                                )),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: CircleAvatar(
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: TextField(
                                                onChanged: (value) {
                                                  commentText = value;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Write Comment',
                                                  hintStyle: TextStyle(),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: RaisedButton(
                                                color: Colors.deepOrangeAccent,
                                                onPressed: () {
                                                  var dbtimekey =
                                                      DateTime.now();
                                                  var timekey =
                                                      DateFormat("hh:mm")
                                                          .format(dbtimekey)
                                                          .toString();
                                                  var datekey =
                                                      DateFormat("MM/dd/yyyy")
                                                          .format(dbtimekey)
                                                          .toString();
                                                  _firestore
                                                      .collection('comments')
                                                      .add({
                                                    'commentText': commentText,
                                                    'postedBy':
                                                        loggedInUser.email,
                                                    'date': datekey,
                                                    'time': timekey,
                                                    'postId': widget.postId,
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Comment',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.chat_bubble_outline,
                            size: 20.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FlutterShare.share(
                              chooserTitle: 'Share Via',
                              title: 'Thoughts',
                              text: " widget.postText \n By widget.postedBy",
                            );
                          },
                          child: Icon(
                            Icons.share,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                  ),
                ],
              ),
            ),
            CommentStream(),
          ],
        ),
      ),
    );
  }
}

class CommentStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('comments').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final posts = snapshot.data.documents.reversed;
        List<CommentWidget> commentWidegts = [];
        for (var post in posts) {
          final postedBy = post.data['postedBy'];
          final postDate = post.data['date'];
          final postTime = post.data['time'];
          final postText = post.data['commentText'];
          final postId = post.data['postId'];
          final cid = post.documentID;
          final currentUser = loggedInUser.email;

          final postContent = CommentWidget(
            postedBy: postedBy,
            commentText: postText,
            postDate: postDate,
            postTime: postTime,
            postId: postId,
            commentId: cid,
            isMe: currentUser == postedBy,
          );
          if (onPosted == postId) {
            commentWidegts.add(postContent);
          }
        }
        return Expanded(
          child: ListView(
            // reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            children: commentWidegts,
          ),
        );
      },
    );
  }
}
