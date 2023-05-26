/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (complete_profile_widget.dart) Last Modified on 1/4/23, 7:50 PM
 *
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';
import 'login_page.dart';

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({Key? key}) : super(key: key);

  @override
  _CompleteProfileWidgetState createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  TextEditingController? addNameController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    addNameController = TextEditingController();
  }

  @override
  void dispose() {
    addNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Complete Profile',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Align(
            //   alignment: AlignmentDirectional(0, 0),
            //   child: Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            //     child: InkWell(
            //       onTap: () async {
            //         null;
            //         // final selectedMedia = await selectMedia(
            //         //   maxWidth: 1000.00,
            //         //   maxHeight: 1000.00,
            //         //   mediaSource: MediaSource.photoGallery,
            //         //   multiImage: false,
            //         // );
            //         // if (selectedMedia != null &&
            //         //     selectedMedia.every((m) =>
            //         //         validateFileFormat(m.storagePath, context))) {
            //         //   setState(() => isMediaUploading = true);
            //         //   var downloadUrls = <String>[];
            //         //   try {
            //         //     showUploadMessage(
            //         //       context,
            //         //       'Uploading file...',
            //         //       showLoading: true,
            //         //     );
            //         //     downloadUrls = (await Future.wait(
            //         //       selectedMedia.map(
            //         //             (m) async =>
            //         //         await uploadData(m.storagePath, m.bytes),
            //         //       ),
            //         //     ))
            //         //         .where((u) => u != null)
            //         //         .map((u) => u!)
            //         //         .toList();
            //         //   } finally {
            //         //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
            //         //     isMediaUploading = false;
            //         //   }
            //         //   if (downloadUrls.length == selectedMedia.length) {
            //         //     setState(() => uploadedFileUrl = downloadUrls.first);
            //         //     showUploadMessage(context, 'Success!');
            //         //   } else {
            //         //     setState(() {});
            //         //     showUploadMessage(context, 'Failed to upload media');
            //         //     return;
            //         //   }
            //         // }
            //       },
            //       child: Container(
            //         width: 80,
            //         height: 80,
            //         clipBehavior: Clip.antiAlias,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //         ),
            //         child: Image.asset(
            //           'assets/images/uiAvatar@2x.png',
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: addNameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                        const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF95A1AC),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your full name here...',
                        hintStyle:
                        const TextStyle(
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFDBE2E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: BrendanButtonWidget(
                onPressed: () async {
                  FirebaseAuth.instance.currentUser!.updateDisplayName(addNameController!.text);
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoginPageWidget()
                    ),
                        (r) => false,
                  );
                },
                text: 'Save Profile',
                options: const BrendanButtonOptions(
                  width: 230,
                  height: 50,
                  color: Color(0xFF090F13),
                  textStyle: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
