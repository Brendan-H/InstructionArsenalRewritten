
/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (official_instructions_tab.dart) Last Modified on 1/12/23, 9:44 PM
 *
 */

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../utils/models/official_instructions.dart';
import 'create_official_instructions_page.dart';
import 'official_instructions_info_page.dart';


class OfficialInstructionsTab extends StatefulWidget {
  const OfficialInstructionsTab({Key? key}) : super(key: key);

  @override
  State<OfficialInstructionsTab> createState() => _OfficialInstructionsTabState();
}

class _OfficialInstructionsTabState extends State<OfficialInstructionsTab> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  Future<List<OfficialInstructions>?> fetchOfficialInstructions(int pageKey) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var title = _titleController.text;
    var company = _companyController.text;
    if (_titleController.text.isNotEmpty && _companyController.text.isNotEmpty) {
      var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/officialinstructions/titleandcompany/$company/$title?pageNo=$pageKey&pageSize=$_pageSize',
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          ));
      if (response.statusCode == 200) {
        var officialInstructions = <OfficialInstructions>[];
        for (var officialInstructionsJson in response.data) {
          officialInstructions.add(OfficialInstructions.fromJson(officialInstructionsJson));
        }
        final isLastPage = officialInstructions.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(officialInstructions);
          print(officialInstructions[0].title);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(officialInstructions, nextPageKey);
        }
        print(officialInstructions);
        return officialInstructions;

      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
        throw Exception('An error occurred');
      }
    }  else {
      var response;
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

  late Future<List<OfficialInstructions>?> futureOfficialInstructions;

  bool _buttonPressed = false;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      fetchOfficialInstructions(pageKey);
    });
    super.initState();

  //  futureOfficialInstructions = fetchOfficialInstructions();
  }
  static const _pageSize = 20;

  final PagingController<int, OfficialInstructions> _pagingController =
  PagingController(firstPageKey: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {  },
        child: PopupMenuButton<int>(
          icon: const Icon(Icons.add, color: Colors.white,),
          onSelected: (widget) async {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateOfficialInstructionsPage(),
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
                    width: 10,
                  ),
                  Text("Add Official Instructions", style: TextStyle(color: Colors.black),),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.search),
                          //search box
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Instruction Title',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.search),
                          //search box
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: TextField(
                                controller: _companyController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Company',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () async {
                            var firebaseid = await FirebaseAuth.instance.currentUser?.getIdToken();
                            if (_titleController.text.length <
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
                            if (_companyController.text.length <
                                2) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "You must enter a company name!",
                                  ),
                                ),
                              );
                              return;
                            }
                            setState(() {
                            _buttonPressed = true;
                         //   futureOfficialInstructions = fetchOfficialInstructions();
                            });

                            print(firebaseid);
                          },
                          child: const Text(
                          "Search",
                            style: TextStyle(color: Colors.white),
                        ),
                        ),
                      ),

                      //filters and other stuff
                    ],
                  ),
                )
              ),
              Visibility(
                  visible: _titleController.text.isNotEmpty && _companyController.text.isNotEmpty && _buttonPressed == true,
                  child: Expanded(
                      child: PagedListView<int, OfficialInstructions>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<OfficialInstructions>(
                          itemBuilder: (context, item, index) => Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                item.title!.length > 100 ? '${item.title!.substring(0, 100)}...' : item.title ?? "Title",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  "Company: ${item.company}" ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OfficialInstructionsInfoPage(
                                      isMyPost: false,
                                      officialInstructions: item,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ),
                      )
                  )
              )

            ],
          ),
        ),
    )
    );
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}