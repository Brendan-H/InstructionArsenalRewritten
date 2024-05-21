/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (like_button.dart) Last Modified on 4/6/23, 9:45 PM
 *
 */
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int likes;
  final int id;
  const LikeButton({Key? key, required this.likes, required this.id}) : super(key: key);
  @override
  _LikeButtonState createState() => _LikeButtonState();
}


class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;
  bool _isUpdated = false;

  Future<int> setLikes() async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    await dio.put('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/likepost/${widget.id}',
        options: Options(
          headers: {
            'Authorization': "Bearer $idToken",
          },
        ));
    var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/getlikes/${widget.id}',
        options: Options(
          headers: {
            'Authorization': "Bearer $idToken",
          },
        ));
    return response.data;
  }

  Future<int> getLikes() async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/getlikes/${widget.id}',
        options: Options(
          headers: {
            'Authorization': "Bearer $idToken",
          },
        ));
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: _isLiked ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.red,),
          onPressed: () async {
            if (_isLiked == false) {
              setLikes();
            }
            setState(() {
              _isLiked = !_isLiked;
              _isUpdated = true;
            });
          },
        ),
        FutureBuilder<int>(
          future: _isUpdated ? getLikes() : Future.value(widget.likes),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}