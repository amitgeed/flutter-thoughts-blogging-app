import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twbh/utils/my_bottom_navbar.dart';
import 'package:intl/intl.dart';
import 'package:twbh/utils/post_widget.dart';

class PostScreen extends StatefulWidget {
  static const String id = 'post_screen';
  @override
  _PostScreenState createState() => _PostScreenState();
}

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String postText;
  int likes = 0;

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
    print(loggedInUser.email);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, MyBottomNavbar.id);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Your Posts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              loggedInUser.email != null
                  ? PostStream()
                  : Center(
                      child: Text('No Post Found\nTry Again Later'),
                    )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(
            Icons.create,
            size: 25.0,
          ),
          onPressed: () {
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: TextField(
                                onChanged: (value) {
                                  postText = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Write Somethong',
                                  hintStyle: TextStyle(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: RaisedButton(
                                color: Colors.deepOrangeAccent,
                                onPressed: () {
                                  var dbtimekey = DateTime.now();
                                  var timekey = DateFormat("hh:mm")
                                      .format(dbtimekey)
                                      .toString();
                                  var datekey = DateFormat("MM/dd/yyyy")
                                      .format(dbtimekey)
                                      .toString();
                                  _firestore.collection('posts').add({
                                    'postText': postText,
                                    'sender': loggedInUser.email,
                                    'date': datekey,
                                    'time': timekey,
                                    'like': likes,
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Post',
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
        ),
      ),
    );
  }
}

class PostStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || loggedInUser.email == null) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrangeAccent,
            ),
          );
        }
        final posts = snapshot.data.documents.reversed;
        List<PostWidget> postWidgets = [];
        for (var post in posts) {
          final postedBy = post.data['sender'];
          final postDate = post.data['date'];
          final postTime = post.data['time'];
          final postText = post.data['postText'];
          final likes = post.data['like'];
          final pid = post.documentID;
          final currentUser = loggedInUser.email;

          final postContent = PostWidget(
            postedBy: postedBy,
            postText: postText,
            postDate: postDate,
            postTime: postTime,
            likes: likes,
            id: pid,
            isMe: currentUser == postedBy,
          );
          if (loggedInUser.email == postedBy) {
            postWidgets.add(postContent);
          }
        }
        return Expanded(
          child: ListView(
            // reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: postWidgets,
          ),
        );
      },
    );
  }
}
