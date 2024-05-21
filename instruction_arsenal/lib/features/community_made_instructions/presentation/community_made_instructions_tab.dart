/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (community_made_instructions_tab.dart) Last Modified on 3/27/23, 6:13 PM
 *
 */

import 'dart:io';

import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/models/community_made_instructions.dart';
import '../CommunityMadeInstructionsCategorySliver.dart';
import '../CommunityMadeInstructionsSearchSliver.dart';
import 'community_made_instructions_info_page.dart';
import 'create_community_made_instructions.dart';
import 'data/get_icon.dart';
import 'data/like_button.dart';
import 'data/star_difficulty.dart';

//TODO add ability to buy ad-free with inapp purchase

class CommunityMadeInstructionsTab extends StatefulWidget {
  const CommunityMadeInstructionsTab({Key? key}) : super(key: key);

  @override
  State<CommunityMadeInstructionsTab> createState() => _CommunityMadeInstructionsTabState();
}

class _CommunityMadeInstructionsTabState extends State<CommunityMadeInstructionsTab> {
  final TextEditingController _searchController = TextEditingController();
 // late BannerAd _bannerAd;

  // void _createBannerAd() {
  //   final adUnitId = Platform.isAndroid
  //       ? 'ca-app-pub-3940256099942544/6300978111'
  //       : 'ca-app-pub-3940256099942544/2934735716';
  //   _bannerAd = BannerAd(
  //     adUnitId: adUnitId,
  //     size: AdSize.mediumRectangle,
  //     request: const AdRequest(),
  //     listener: BannerAdListener(
  //       onAdFailedToLoad: (ad, error) {
  //         print("AD FAILED TO LOAD");
  //         ad.dispose();
  //       },
  //       onAdLoaded: (ad) {
  //         // Called when an ad is successfully loaded.
  //         print('Ad loaded.');
  //       },
  //     ),
  //   );
  //   _bannerAd.load();
  // }



  Future<List?> fetchCommunityMadeInstructions(int pageKey) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var title = _searchController.text;
    var category = categoryChoice;
    if (_searchController.text.length > 3) {
     var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/titleandcategory/$title/$category?pageNo=$pageKey&pageSize=$_pageSize',
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          ));
      if (response.statusCode == 200) {
        var communityMadeInstructions = <CommunityMadeInstructions>[];
        for (var communityMadeInstructionsJson in response.data) {
          communityMadeInstructions.add(CommunityMadeInstructions.fromJson(communityMadeInstructionsJson));
        }
        var communityMadeInstructionsWithAds = <dynamic>[];
        for (var i = 0; i < communityMadeInstructions.length; i++) {
          communityMadeInstructionsWithAds.add(communityMadeInstructions[i]);
          // if ((i + 1) % 10 == 0) {
          //   communityMadeInstructionsWithAds.insert(i+1, AdWidget(
          //     ad: _bannerAd,
          //   ));
          // }
        }
        final isLastPage = communityMadeInstructionsWithAds.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(communityMadeInstructionsWithAds);
        } else {
          final nextPageKey = pageKey + communityMadeInstructionsWithAds.length;
          _pagingController.appendPage(communityMadeInstructionsWithAds, nextPageKey);
        }
        return communityMadeInstructionsWithAds;
      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
       // return exampleCommunityMadeInstructions;
        throw Exception('An error occurred');
      }
    } else if (_searchController.text.isEmpty) {
      var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/all?pageNo=$pageKey&pageSize=$_pageSize',
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          )
      );
      if (response.statusCode == 200) {
        var communityMadeInstructions = <CommunityMadeInstructions>[];
        for (var communityMadeInstructionsJson in response.data) {
          communityMadeInstructions.add(CommunityMadeInstructions.fromJson(communityMadeInstructionsJson));
        }
        var communityMadeInstructionsWithAds = <dynamic>[];
        for (var i = 0; i < communityMadeInstructions.length; i++) {
          communityMadeInstructionsWithAds.add(communityMadeInstructions[i]);
          // if ((i + 1) % 10 == 0) {
          //   communityMadeInstructionsWithAds.insert(i+1, AdWidget(
          //     ad: _bannerAd,
          //   ));
          //   _bannerAd.load();
          // }
        }
        final isLastPage = communityMadeInstructionsWithAds.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(communityMadeInstructionsWithAds);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(communityMadeInstructionsWithAds, nextPageKey);
        }
        return communityMadeInstructionsWithAds;
      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
       // throw Exception('An error occurred');
      }
    } else {
      //return exampleCommunityMadeInstructions;
      return null;
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
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post Deleted")));
        Navigator.pop(context);

      },
    );

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

  List<S2Choice<String>> categoryChoiceOptions = [
    S2Choice<String>(value: 'Technology', title: 'Technology'),
    S2Choice<String>(value: 'Automotive', title: 'Automotive'),
    S2Choice<String>(value: 'Cooking', title: 'Cooking'),
    S2Choice<String>(value: 'Sports', title: 'Sports'),
    S2Choice<String>(value: 'Home', title: 'Home'),
    S2Choice<String>(value: 'Other', title: 'Other'),
  ];

  late Future<List<dynamic>?> futureCommunityMadeInstructions;


  var categoryChoice = "Automotive";

  @override
  void initState() {
    //_createBannerAd();
    _pagingController.addPageRequestListener((pageKey) {
      fetchCommunityMadeInstructions(pageKey);
    });

    super.initState();
    //futureCommunityMadeInstructions = fetchCommunityMadeInstructions();
  }

  void submitValue(String value) async {
    if (_searchController.text.length <
        4) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Title must be at least 4 characters long!",
          ),
        ),
      );
      return;
    }
   // fetchCommunityMadeInstructions();
  }

  static const _pageSize = 20;

  final PagingController<int, dynamic> _pagingController =
  PagingController(firstPageKey: 0);

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



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {  },
        child: PopupMenuButton<int>(
          icon: const Icon(Icons.add),
          onSelected: (widget) async {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateCommunityMadeInstructionsPage(),
              ),
                  (r) => false,
            );
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: const [
                  Icon(Icons.add,
                    color: Colors.black,),
                  SizedBox(
                    // sized box with width 10
                    width: 15,
                  ),
                  Text("Add Instructions")
                ],
              ),
            ),
          ],
          offset: const Offset(0, 100),
          color: Colors.white,
          elevation: 2,
        ),

      ),
      backgroundColor: Colors.white60,
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget> [
                    CommunityMadeInstructionsSearchSliver(
                      onChanged: (value) {
                        setState(() {
                          _searchController.text = value;
                          _pagingController.refresh();
                        });
                      },
                    ),
                    CommunityMadeInstructionsCategorySliver(
                      onChanged: (value) {
                        setState(() {
                          categoryChoice = value;
                          _pagingController.refresh();
                        });
                      },
                    ),
                    PagedSliverList<int, dynamic>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, item, index) {
                      //  if (item is AdWidget) {
                        if (item is SizedBox) {
                          return SizedBox(
                            height: 300,
                            child: item,
                          );
                        } else {
                          return  InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommunityMadeInstructionsInfoPage(
                                    communityMadeInstructions: item,
                                    isMyPost: false,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .9945,
                              height: MediaQuery.of(context).size.height * .33,
                              child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                                          child: Row(
                                            children: [
                                              Text("Created By: ${item.createdBy}"),
                                              const Spacer(),
                                              Visibility(
                                                visible: item.sponsored ?? false,
                                                child: const Text("Sponsored",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.bold)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text('${item.title}',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600
                                          ),),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Text(item.description ?? "description",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child:
                                          //Text(communityMadeInstruction.instructions ?? "instructions",
                                          Text(item.instructions!.length > 200 ? '${item.instructions!.substring(0, 200)}...' : item.instructions ?? "Title",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black54
                                            ),),
                                        ),

                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Row(
                                            children: [
                                              const Text("Difficulty: "),
                                              StarDifficulty(difficulty: item.difficulty as int),
                                              const Spacer(),
                                              const Text("Time to Complete: 30 minutes"),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GetIcon(category: item.category ?? "Other"),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                              child: Text("Category: ${item.category}"),
                                            ),
                                            const Spacer(),
                                            LikeButton(likes: item.likes, id: item.id),
                                            // const Icon(Icons.favorite_border, color: Colors.red,),
                                            // Text((item.likes!.toInt() - item.dislikes!.toInt()).toString()),
                                            const Spacer(),
                                            Text(dateTimeFormat(
                                              //  "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                                              // "hh:mma MMMM dd, yyyy",
                                                "MMMM dd, yyyy hh:mma",
                                                DateTime.parse(item.postCreatedAt ?? "Cannot retrieve time when post was created")))
                                          ],
                                        ),

                                      ],
                                    ),
                                  )
                              ),

                            ),
                          );
                        }

  }
                    ),

                  ),
                  ]
                )


              )
            ],
          ),
        )
      ),

    );
  }
  @override
  void dispose() {
    _pagingController.dispose();
 //   _bannerAd.dispose();
    super.dispose();
  }
}
