/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (main_drawer.dart) Last Modified on 1/4/23, 7:50 PM
 *
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/features/authentication/presentation/settings_page.dart';
//import 'package:instruction_arsenal/profile/bookmarked_community_made_instructions_page.dart';
//import 'package:instruction_arsenal/profile/profile_page.dart';

import '../../../generated/l10n.dart';
import 'login_page.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .175,
            child: DrawerHeader(
              decoration: const BoxDecoration(
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      FirebaseAuth.instance.currentUser?.email ?? "Email not found",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? 'Name not found',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
          //  title: const Text('Your Instructions'),
            title: Text(S.of(context).yourInstructions),
            onTap: () async{
              // await Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ProfilePage(),
              //   ),
              //       (r) => false,
              // );
              //TODO Implement this
              },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text(S.of(context).bookmarkedInstructions),
            onTap: () async{
              // await Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const BookmarkedCommunityMadeInstructionsPage(),
              //   ),
              //       (r) => false,
              // );
              //TODO IMPLEMENT THIS
              },
          ),
           ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () async {
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
                    (r) => false,
              );
            },
          ),
           ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
             onTap: () async {
               await FirebaseAuth.instance.signOut();
               await Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const LoginPageWidget(),
                 ),
                     (r) => false,
               );
             },
          ),
          Visibility(
            visible: FirebaseAuth.instance.currentUser!.emailVerified == false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text("Your email is not verified. You will not be able to post until you verify your email.",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Verify Email")
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
