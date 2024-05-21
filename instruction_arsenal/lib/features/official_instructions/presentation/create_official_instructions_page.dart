/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (create_official_instructions_page.dart) Last Modified on 1/4/23, 7:37 PM
 *
 */

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';
import '../../homepage/homepage.dart';

class CreateOfficialInstructionsPage extends StatefulWidget {
  const CreateOfficialInstructionsPage({Key? key}) : super(key: key);

  @override
  State<CreateOfficialInstructionsPage> createState() => _CreateOfficialInstructionsPageState();
}

class _CreateOfficialInstructionsPageState extends State<CreateOfficialInstructionsPage> {
  DateTime? datePicked;
  TextEditingController? companyNameController;
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? instructionsController;
  int? hoursControllerValue;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var dio = Dio();

  void createPost() async {
    try {
      var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      var dio = Dio();
      var response = await dio.post('http://10.0.2.2:8080/api/v1/instructions/officialinstructions',
          data: {
            'title':titleController?.text,
            'description':descriptionController?.text,
            'company':companyNameController?.text,
            'instructions':instructionsController?.text,
            'createdBy': FirebaseAuth.instance.currentUser!.email,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          ));
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Official Instructions Created")));
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
              'Add Official Instructions',
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
                                    controller: companyNameController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Company Name',
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
                                    maxLines: 1,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Company is required';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  text: 'Add Official Instructions',
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
