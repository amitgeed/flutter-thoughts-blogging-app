import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twbh/utils/post_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class _HomeScreenState extends State<HomeScreen> {
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return WillPopScope(
      onWillPop: () {
        exit(0);
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
                    "All Posts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              loggedInUser.email == null
                  ? Center(child: Text('No Post Found\nTry Again Later'))
                  : PostStream(),
            ],
          ),
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

          postWidgets.add(postContent);
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
