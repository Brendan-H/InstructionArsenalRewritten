/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (create_community_made_instructions.dart) Last Modified on 3/27/23, 6:54 PM
 *
 */

import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';


import '../../../utils/widgets.dart';
import '../../homepage/homepage.dart';
class CreateCommunityMadeInstructionsPage extends StatefulWidget {
  const CreateCommunityMadeInstructionsPage({Key? key}) : super(key: key);

  @override
  State<CreateCommunityMadeInstructionsPage> createState() => _CreateCommunityMadeInstructionsPageState();
}

class _CreateCommunityMadeInstructionsPageState extends State<CreateCommunityMadeInstructionsPage> {
  DateTime? datePicked;
  TextEditingController? companyNameController;
  bool isSponsored = false;
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? instructionsController;
  TextEditingController? hoursController;
  late int difficulty = 0;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var dio = Dio();
  List<S2Choice<String>> categoryChoiceOptions = [
    S2Choice<String>(value: 'Technology', title: 'Technology'),
    S2Choice<String>(value: 'Automotive', title: 'Automotive'),
    S2Choice<String>(value: 'Cooking', title: 'Cooking'),
    S2Choice<String>(value: 'Sports', title: 'Sports'),
    S2Choice<String>(value: 'Home', title: 'Home'),
    S2Choice<String>(value: 'Other', title: 'Other'),
  ];



  var categoryChoice = "Automotive";

  void createPost() async {
    try {
      var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      var dio = Dio();
      var response = await dio.post('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions',
          data: {
            'title':titleController?.text,
            'description':descriptionController?.text,
            'instructions':instructionsController?.text,
            'createdBy': FirebaseAuth.instance.currentUser!.email,
            'category': categoryChoice,
            'difficulty': difficulty,
            'hours': hoursController?.text,
            'isSponsored': isSponsored,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          ));
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Community Made Instructions Created")));
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ),
              (r) => false,
        );
      }
      if (response.statusCode == 404) {
        print('404');
      }
      if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("401 Unauthorized. Try logging out and logging back in.")));
      }

    } on Exception catch (e) {
      throw Exception(e);
    }

  }

  @override
  void initState() {
    super.initState();
    companyNameController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    instructionsController = TextEditingController();
    hoursController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(

        key: scaffoldKey,
        appBar: AppBar(
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
          backgroundColor: Colors.white,

          automaticallyImplyLeading: false,
          flexibleSpace: const Align(
            alignment: AlignmentDirectional(0, 0.5),
            child: Text(
              'Add Community Made Instructions',
              style: TextStyle(
                color: Color(0xFF090F13),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: const [],
          elevation: 5,
        ),
//        backgroundColor: Colors.white,
        // Changed from white to off-white (f5f5f5)
        backgroundColor: const Color(0xFFf5f5f5),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmartSelect<String>.single(
                  modalHeaderStyle: const S2ModalHeaderStyle(
                    backgroundColor: Colors.black,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  choiceStyle: const S2ChoiceStyle(
                    color: Colors.black,
                    titleStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onSelect: (selected, state) {
                    print(categoryChoice);

                  },
                  modalType: S2ModalType.bottomSheet,
                  title: 'Category',
                  selectedValue: categoryChoice,
                  choiceItems: categoryChoiceOptions,
                  onChange: (state) => setState(() {
                    categoryChoice = state.value;
                  }),
                ),
              ),
              //a slider with the title "are these instructions sponsored?"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are these instructions sponsored?"),
                  Switch(value: isSponsored, onChanged: (value) {
                    setState(() {
                      isSponsored = value;
                    });
                  })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("How long will it take to complete these instructions? (in hours)"),
                ],
              ),
              Column(
                children: [
                  Text("Difficulty:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SmoothStarRating(
                         onRatingChanged: (v) {
                           setState(() {
                              difficulty = v.toInt();
                           });
                         },
                         starCount: 5,
                         rating: difficulty.toDouble(),
                         size: 32.5,
                         color: Colors.red,
                         borderColor: Colors.red,
                         spacing:0.0
                     )
                   ]
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enableInteractiveSelection: true,
                                    controller: titleController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Title',
                                      hintStyle:
                                      const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20, 32, 12, 0),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Title is required';
                                      }

                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      decoration: const BoxDecoration(
                        //                       color: Colors.white
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enableInteractiveSelection: true,
                                    controller: descriptionController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Description',
                                      hintStyle:
                                      const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20, 32, 20, 0),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 8,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Description is required';
                                      }

                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      decoration: const BoxDecoration(
                        //                       color: Colors.white
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enableInteractiveSelection: true,
                                    controller: instructionsController,
                                    obscureText: false,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: 'Instructions',
                                      hintStyle:
                                      const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20, 32, 20, 0),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Instructions are required';
                                      }

                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      decoration: const BoxDecoration(
                        //                       color: Colors.white
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enableInteractiveSelection: true,
                                    controller: hoursController,
                                    obscureText: false,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: 'Time to Complete',
                                      hintStyle:
                                      const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFDBE2E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20, 32, 20, 0),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Time to complete is required';
                                      }

                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),


              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: BrendanButtonWidget(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please verify your email'),
                        ),
                      );
                      return;
                    }
                    createPost();
/*
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBarPage(
                            initialPage: 'opportunitiesPage'),
                      ),
                          (r) => false,
                    );
*/
                  },
                  text: 'Add Instructions',
                  options: BrendanButtonOptions(
                    width: 270,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.white,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 4,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
