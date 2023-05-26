/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (official_instructions.dart) Last Modified on 12/29/22, 6:39 PM
 *
 */

/// id : 1
/// title : "Title"
/// description : "description"
/// company : "company"
/// postCreatedAt : "2022-12-22T17:20:21.834439"
/// instructions : "instructions"
/// createdBy : null

class OfficialInstructions {
  OfficialInstructions({
      num? id, 
      String? title, 
      String? description, 
      String? company, 
      String? postCreatedAt, 
      String? instructions, 
      dynamic createdBy,}){
    _id = id;
    _title = title;
    _description = description;
    _company = company;
    _postCreatedAt = postCreatedAt;
    _instructions = instructions;
    _createdBy = createdBy;
}

  OfficialInstructions.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _company = json['company'];
    _postCreatedAt = json['postCreatedAt'];
    _instructions = json['instructions'];
    _createdBy = json['createdBy'];
  }
  num? _id;
  String? _title;
  String? _description;
  String? _company;
  String? _postCreatedAt;
  String? _instructions;
  dynamic _createdBy;
OfficialInstructions copyWith({  num? id,
  String? title,
  String? description,
  String? company,
  String? postCreatedAt,
  String? instructions,
  dynamic createdBy,
}) => OfficialInstructions(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  company: company ?? _company,
  postCreatedAt: postCreatedAt ?? _postCreatedAt,
  instructions: instructions ?? _instructions,
  createdBy: createdBy ?? _createdBy,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get company => _company;
  String? get postCreatedAt => _postCreatedAt;
  String? get instructions => _instructions;
  dynamic get createdBy => _createdBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['company'] = _company;
    map['postCreatedAt'] = _postCreatedAt;
    map['instructions'] = _instructions;
    map['createdBy'] = _createdBy;
    return map;
  }

}