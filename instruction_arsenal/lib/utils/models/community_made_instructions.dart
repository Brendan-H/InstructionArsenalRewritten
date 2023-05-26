/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (community_made_instructions.dart) Last Modified on 1/12/23, 7:25 PM
 *
 */

/// id : 12
/// title : "2 How to change the tire on a car"
/// description : "This tutorial will show you the exact steps for safely replacing the tire on any car. It will be demonstrated on a 2017 Toyota Camry"
/// postCreatedAt : "2023-01-03T16:54:30.756846"
/// instructions : "Step 1: Park the car on a flat surface and turn off the engine. Make sure the car is in park and the parking brake is on. Step 2: Locate the jack and the lug wrench. Step 3: Remove the lug nuts from the tire. Step 4: Place the jack under the car and raise it until the tire is off the ground. Step 5: Remove the tire and replace it with the spare. Step 6: Replace the lug nuts and tighten them. Step 7: Lower the car and remove the jack. Step 8: Replace the lug wrench and jack in their original locations. Step 9: Turn on the car and drive away. Step 10: Go to a tire shop to get the flat tire fixed."
/// createdBy : "bjharan7@gmail.com"
/// category : "Automotive"
/// likes : 155
/// dislikes : 11
/// tags : "cars, tire, automotive, wheels, repair"
/// difficulty : 3
/// timeToComplete : "30 Minutes"
/// sponsored : true

class CommunityMadeInstructions {
  CommunityMadeInstructions({
      int? id,
      String? title, 
      String? description, 
      String? postCreatedAt, 
      String? instructions, 
      String? createdBy, 
      String? category, 
      int? likes,
      String? tags, 
      num? difficulty, 
      String? timeToComplete, 
      bool? sponsored,}){
    _id = id;
    _title = title;
    _description = description;
    _postCreatedAt = postCreatedAt;
    _instructions = instructions;
    _createdBy = createdBy;
    _category = category;
    _likes = likes;
    _tags = tags;
    _difficulty = difficulty;
    _timeToComplete = timeToComplete;
    _sponsored = sponsored;
}

  CommunityMadeInstructions.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _postCreatedAt = json['postCreatedAt'];
    _instructions = json['instructions'];
    _createdBy = json['createdBy'];
    _category = json['category'];
    _likes = json['likes'];
    _tags = json['tags'];
    _difficulty = json['difficulty'];
    _timeToComplete = json['timeToComplete'];
    _sponsored = json['sponsored'];
  }
  int? _id;
  String? _title;
  String? _description;
  String? _postCreatedAt;
  String? _instructions;
  String? _createdBy;
  String? _category;
  int? _likes;
  String? _tags;
  num? _difficulty;
  String? _timeToComplete;
  bool? _sponsored;
CommunityMadeInstructions copyWith({  int? id,
  String? title,
  String? description,
  String? postCreatedAt,
  String? instructions,
  String? createdBy,
  String? category,
  int? likes,
  String? tags,
  num? difficulty,
  String? timeToComplete,
  bool? sponsored,
}) => CommunityMadeInstructions(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  postCreatedAt: postCreatedAt ?? _postCreatedAt,
  instructions: instructions ?? _instructions,
  createdBy: createdBy ?? _createdBy,
  category: category ?? _category,
  likes: likes ?? _likes,
  tags: tags ?? _tags,
  difficulty: difficulty ?? _difficulty,
  timeToComplete: timeToComplete ?? _timeToComplete,
  sponsored: sponsored ?? _sponsored,
);
  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get postCreatedAt => _postCreatedAt;
  String? get instructions => _instructions;
  String? get createdBy => _createdBy;
  String? get category => _category;
  int? get likes => _likes;
  String? get tags => _tags;
  num? get difficulty => _difficulty;
  String? get timeToComplete => _timeToComplete;
  bool? get sponsored => _sponsored;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['postCreatedAt'] = _postCreatedAt;
    map['instructions'] = _instructions;
    map['createdBy'] = _createdBy;
    map['category'] = _category;
    map['likes'] = _likes;
    map['tags'] = _tags;
    map['difficulty'] = _difficulty;
    map['timeToComplete'] = _timeToComplete;
    map['sponsored'] = _sponsored;
    return map;
  }
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'title': _title,
      'description': _description,
      'postCreatedAt': _postCreatedAt,
      'instructions': _instructions,
      'createdBy': _createdBy,
      'category': _category,
      'likes': _likes,
      'tags': _tags,
      'difficulty': _difficulty,
      'timeToComplete': _timeToComplete,
      'sponsored': _sponsored,
    };
  }

}
