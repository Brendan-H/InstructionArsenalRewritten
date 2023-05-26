/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (dynamic_links_service.dart) Last Modified on 2/24/23, 5:44 PM
 *
 */

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
//import 'package:instruction_arsenal/homepage/community_made_instructions/community_made_instructions_info_page.dart';

//import '../backend/models/community_made_instructions.dart';
import 'models/community_made_instructions.dart';


class DynamicLinkService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> handleDynamicLinks(BuildContext context) async {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();

    _handleLinkData(data, context);

    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData? dynamicLink) async {
          _handleLinkData(dynamicLink, context);
        }, onError: (e) async {
      print('Dynamic Link Failed: ${e.message}');
    });
  }

  static Future<void> _handleLinkData(
      PendingDynamicLinkData? data, BuildContext context) async {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink);
      final postId = deepLink.queryParameters['postId'];
      // _callAPI(postId).then((post) {
      //   navigatorKey.currentState?.push(
      //       MaterialPageRoute(
      //           builder: (context) => CommunityMadeInstructionsInfoPage(communityMadeInstructions: post, isMyPost: false,)));
      // }
      //);
      //TODO implement this

    //   var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    //   var dio = Dio();
    //     var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/$postId',
    //         options: Options(
    //           headers: {
    //             'Authorization': "Bearer $idToken",
    //           },
    //         ));
    //     if (response.statusCode == 200) {
    //       var communityMadeInstructions = CommunityMadeInstructions.fromJson(
    //           response.data);
    // // await Navigator.pushNamed(context, "/communitymadeinstructionsinfo",
    // //     arguments: {"communityMadeInstructions": communityMadeInstructions, "isMyPost": false});
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CommunityMadeInstructionsInfoPage(
    //         communityMadeInstructions: communityMadeInstructions, isMyPost: false),
    //   ),
    // );
    //     }



      }
    }
  static Future<CommunityMadeInstructions> _callAPI(String? postId) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/$postId',
        options: Options(
          headers: {
            'Authorization': "Bearer $idToken",
          },
        ));
    if (response.statusCode == 200) {
      var communityMadeInstructions = CommunityMadeInstructions.fromJson(
          response.data);
      return communityMadeInstructions;
    }
    else {
      return Future.error('Error');
    }
  }
  Future<Uri> createDynamicLink(num postId) async {
    final parameters = DynamicLinkParameters(
      // uriPrefix: 'https://instructionarsenal.brendanharan.com/go/',
      // link: Uri.parse('https://instructionarsenal.brendanharan.com/go/id/$id'),
      uriPrefix: 'https://instructionarsenal.brendanharan.com/go',
      link: Uri.parse('https://instructionarsenal.brendanharan.com/go/post?postId=$postId'),
      androidParameters: AndroidParameters(
          packageName: 'com.brendanharan.instructionarsenal',
          minimumVersion: 0),
      // iosParameters: IosParameters(
      //     bundleId: 'com.your.bundle.id',
      //     minimumVersion: '0'),
      // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable,
      // ),
      // socialMetaTagParameters: SocialMetaTagParameters(
      //   title: 'Your Post Title',
      //   description: 'Your Post Description',
      //   imageUrl: Uri.parse('https://your-image-url.com'),
      // )
    );

    var dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
     //var dynamicUrl = await FirebaseDynamicLinks.instance.buildLink(parameters);
    final Uri shortUrl = dynamicUrl.shortUrl;
    //return dynamicUrl;
    return shortUrl;
  }
  }


