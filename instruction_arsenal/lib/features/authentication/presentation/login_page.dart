/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (login_page.dart) Last Modified on 2/24/23, 5:44 PM
 *
 */

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instruction_arsenal/features/authentication/data/auth_provider.dart';
//import 'package:instruction_arsenal/homepage/homepage.dart';
import '../../../generated/l10n.dart';
import '../../../utils/widgets.dart';
import 'package:flutter/material.dart';
import 'complete_profile_widget.dart';
import 'forgot_password_page.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  TextEditingController? confirmPasswordController;
  var dio = Dio();
  late bool confirmPasswordVisibility;
  TextEditingController? createEmailController;
  TextEditingController? createPasswordController;
  late bool createPasswordVisibility;
  late TextEditingController loginEmailAddressController;
  late TextEditingController loginPasswordController;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  late bool loginPasswordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<dynamic> sendTokenForValidation(var idtoken) async {
    var dio = Dio();
    try {
      var response = await dio.post(
          'http://10.0.2.2:8080/api/users/id/verify',
          // 'https://firebase-auth-test-brendan.herokuapp.com/api/users/id/verify',
          options: Options(
              headers: {"Authorization": idtoken}
          )
      );
      if (response.statusCode == 200) {
        var uid = await jsonDecode(jsonEncode(response.data));
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    confirmPasswordController = TextEditingController();
    confirmPasswordVisibility = false;
    createEmailController = TextEditingController();
    createPasswordController = TextEditingController();
    createPasswordVisibility = false;
    loginEmailAddressController = TextEditingController();
    loginPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    loginPasswordVisibility = false;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white60,
      body: Consumer(builder: (context, ref, child) {
        final auth = ref.watch(fireBaseAuthProvider);
        return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
           Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 52, 16, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).welcomeTo,
                  style: const TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Instruction Arsenal',
                  style: TextStyle(
                    fontFamily: 'armalite',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black87,
                    indicatorColor: Colors.black45,
                    tabs: [
                      Tab(
                        text: 'Login',
                      ),
                      Tab(
                        text: 'Create Account',
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white60,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 4, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Enter your details to continue.',
                                        textAlign: TextAlign.center,
                                        style:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          //                                        color: Color(0x77FFFFFF),
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 16, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller:
                                          loginEmailAddressController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Email Address',
                                            labelStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            hintText:
                                            'Enter your email here...',
                                            hintStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF2B343A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 16, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: loginPasswordController,
                                          obscureText: !loginPasswordVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            hintText:
                                            'Enter your email here...',
                                            hintStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                    () => loginPasswordVisibility =
                                                !loginPasswordVisibility,
                                              ),
                                              child: Icon(
                                                loginPasswordVisibility
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: const Color(0xFF95A1AC),
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF2B343A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 0),
                                  child: BrendanButtonWidget(

                                    onPressed: () async {
                                      if (loginPasswordController.text.isEmpty || loginEmailAddressController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Please enter your email and password to continue",
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      try {
                                        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                          email: loginEmailAddressController.text,
                                          password: loginPasswordController.text,
                                        ).whenComplete(() => auth.authStateChanges().listen((event) async {
                                          if (event == null) {
                                            return;
                                          }
                                        }));

                                        
                                        var idtoken = await FirebaseAuth.instance.currentUser?.getIdToken();
                                        print(idtoken);
                                        if (user == null) {
                                          return;
                                        }
                                        // await Navigator.pushAndRemoveUntil(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => const Homepage(),
                                        //   ),
                                        //       (r) => false,
                                        // );
                                        //TODO implement homepage
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Invalid email or password",
                                            ),
                                          ),
                                        );
                                      }



                                    },
                                    text: 'Login',
                                    options: const BrendanButtonOptions(
                                      width: 230,
                                      height: 50,
                                      color: Color(0xFF090F13),
                                      textStyle:
                                      TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      elevation: 3,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 8,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: BrendanButtonWidget(

                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const ForgotPasswordPage(),
                                        ),
                                      );

                                    },

                                    text: 'Forgot Password?',
                                    options: const BrendanButtonOptions(
                                      width: 200,
                                      height: 30,
                                      color: Color(0x00FFFFFF),
                                      textStyle:
                                      TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
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
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white60,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Create Account',
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 4, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Enter the information below to get started.',
                                        textAlign: TextAlign.center,
                                        style:
                                        TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 16, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: createEmailController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Email Address',
                                            labelStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            hintText:
                                            'Enter your email here...',
                                            hintStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF2B343A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 16, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: createPasswordController,
                                          obscureText:
                                          !createPasswordVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            hintText: 'Enter your password',
                                            hintStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                    () => createPasswordVisibility =
                                                !createPasswordVisibility,
                                              ),
                                              child: Icon(
                                                createPasswordVisibility
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: const Color(0xFF95A1AC),
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF2B343A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 16, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: confirmPasswordController,
                                          obscureText:
                                          !confirmPasswordVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Confirm Password',
                                            labelStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            hintText:
                                            'Enter the same password as above.',
                                            hintStyle: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFDBE2E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                    () => confirmPasswordVisibility =
                                                !confirmPasswordVisibility,
                                              ),
                                              child: Icon(
                                                confirmPasswordVisibility
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: const Color(0xFF95A1AC),
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF2B343A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: BrendanButtonWidget(
                                    onPressed: () async {
                                      if (createPasswordController!.text !=
                                          confirmPasswordController!.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Passwords don't match!",
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      if (createPasswordController!.text.length <
                                          8) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Password must be at least 8 characters long!",
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(createEmailController!.text)) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text("Invalid email address")
                                            ));
                                        return;
                                      }

                                      await FirebaseAuth.instance.createUserWithEmailAndPassword(

                                          email: createEmailController!.text,
                                          password: createPasswordController!.text)
                                          .whenComplete(() => auth.authStateChanges().listen((event) async {
                                        if (event == null) {
                                          const AsyncValue.loading();
                                          return;
                                        }
                                      }));
                                      await FirebaseAuth.instance.currentUser?.sendEmailVerification();



                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const CompleteProfileWidget(),
                                        ),
                                            (r) => false,
                                      );
                                    },
                                    text: 'Create Account',
                                    options: const BrendanButtonOptions(
                                      width: 230,
                                      height: 50,
                                      color: Color(0xFF090F13),
                                      textStyle:
                                      TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      elevation: 3,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 8,
                                    ),

                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ); },),
    );
  }
}


