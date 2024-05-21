/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (db_helper.dart) Last Modified on 4/7/23, 10:50 AM
 *
 */
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../utils/models/community_made_instructions.dart';

class DBHelper {
  static const String DB_NAME = "bookmarks.db";
  static const String TABLE_NAME = "bookmarks";
  static const String ID_COLUMN = "id";
  static const String TITLE_COLUMN = "title";
  static const String DESCRIPTION_COLUMN = "description";
  static const String POST_CREATED_AT_COLUMN = "post_created_at";
  static const String INSTRUCTIONS_COLUMN = "instructions";
  static const String CREATED_BY_COLUMN = "created_by";
  static const String CATEGORY_COLUMN = "category";
  static const String LIKES_COLUMN = "likes";
  static const String TAGS_COLUMN = "tags";
  static const String DIFFICULTY_COLUMN = "difficulty";
  static const String TIME_TO_COMPLETE_COLUMN = "time_to_complete";
  static const String SPONSORED_COLUMN = "sponsored";

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $TABLE_NAME($ID_COLUMN INTEGER PRIMARY KEY, $TITLE_COLUMN TEXT, $DESCRIPTION_COLUMN TEXT, $POST_CREATED_AT_COLUMN TEXT, $INSTRUCTIONS_COLUMN TEXT, $CREATED_BY_COLUMN TEXT, $CATEGORY_COLUMN TEXT, $LIKES_COLUMN INTEGER, $TAGS_COLUMN TEXT, $DIFFICULTY_COLUMN REAL, $TIME_TO_COMPLETE_COLUMN TEXT, $SPONSORED_COLUMN INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertBookmark(CommunityMadeInstructions post) async {
    final db = await database();

    await db.insert(
      TABLE_NAME,
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookmark(int id) async {
    final db = await database();

    await db.delete(
      TABLE_NAME,
      where: "$ID_COLUMN = ?",
      whereArgs: [id],
    );
  }

  Future<List<CommunityMadeInstructions>> getBookmarkedPosts() async {
    final db = await database();

    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    return List.generate(maps.length, (i) {
      return CommunityMadeInstructions(
        id: maps[i][ID_COLUMN],
        title: maps[i][TITLE_COLUMN],
        description: maps[i][DESCRIPTION_COLUMN],
        postCreatedAt: maps[i][POST_CREATED_AT_COLUMN],
        instructions: maps[i][INSTRUCTIONS_COLUMN],
        createdBy: maps[i][CREATED_BY_COLUMN],
        category: maps[i][CATEGORY_COLUMN],
        likes: maps[i][LIKES_COLUMN],
        tags: maps[i][TAGS_COLUMN],
        difficulty: maps[i][DIFFICULTY_COLUMN],
        timeToComplete: maps[i][TIME_TO_COMPLETE_COLUMN],
        sponsored: maps[i][SPONSORED_COLUMN] == 1,
      );
    });
  }
}
