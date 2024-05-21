
/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (official_instructions_info_page.dart) Last Modified on 2/3/23, 5:21 PM
 *
 */

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/models/official_instructions.dart';
import '../../homepage/homepage.dart';



class OfficialInstructionsInfoPage extends StatefulWidget {


  final OfficialInstructions officialInstructions;

  final bool isMyPost;
  
  const OfficialInstructionsInfoPage({Key? key, required this.officialInstructions, required this.isMyPost}) : super(key: key);





@override
  State<OfficialInstructionsInfoPage> createState() => _OfficialInstructionsInfoPageState();
}


class _OfficialInstructionsInfoPageState extends State<OfficialInstructionsInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  String getCreatedBy() {
    if (FirebaseAuth.instance.currentUser!.email == widget.officialInstructions.createdBy) {
      return "You";
    }
    else {
      return widget.officialInstructions.createdBy;
    }

  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () async {Navigator.pop(context);},
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed:  () async {
        var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
        var dio = Dio();
        await dio.delete(
            "http://10.0.2.2:8080/api/v1/instructions/officialinstructions/${widget.officialInstructions.id}",
            options: Options(
              headers: {
                'Authorization': "Bearer $idToken",
              },
            )
        );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post Deleted")));
        Navigator.pop(context);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Post"),
      content: const Text("Are you sure you would like to delete this post?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String dateTimeFormat(String format, DateTime? dateTime) {
      if (dateTime == null) {
        return '';
      }
      if (format == 'relative') {
        return timeago.format(dateTime);
      }
      return DateFormat(format).format(dateTime);
    }

    final createdAtDate = dateTimeFormat(
      //  "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
      // "hh:mma MMMM dd, yyyy",
        "MMMM dd, yyyy hh:mma",
        DateTime.parse(widget.officialInstructions.postCreatedAt ?? "Cannot retrieve time when post was created"));




    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.isMyPost,
            child: PopupMenuButton<int>(
              onSelected: (widget) {
                showAlertDialog(context);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(Icons.delete),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("Delete this post")
                    ],
                  ),
                ),
              ],
              offset: const Offset(0, 100),
              icon: const Icon(Icons.more_vert, color: Colors.black,),
              elevation: 2,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
                  (r) => false,
            );
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Official Instruction",
        style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        widget.officialInstructions.title ?? "Title",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xFF0F1113),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        widget.officialInstructions.company ?? "Company",
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                           Text(
                            "Description:",
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          Text(
                            "${widget.officialInstructions.description}",
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //service hours
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                           Text(
                            "Created By:",
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          Text(
                            getCreatedBy(),
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                           Text(
                            "Created At:",
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          Text(
                            "${createdAtDate.substring(0, 17)} at ${createdAtDate.substring(18, 23)} ${createdAtDate.substring(23)}"
                            
                            ,
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                           Text(
                            "Instructions:",
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          Text(
                            "${widget.officialInstructions.instructions}",
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),
                    ),
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
