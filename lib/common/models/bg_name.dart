// Copyright (C) 2024 Rudson Alves
//
// This file is part of bgbazzar.
//
// bgbazzar is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// bgbazzar is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with bgbazzar.  If not, see <https://www.gnu.org/licenses/>.

class BGNameModel {
  int? id;
  String? bgId;
  String? name;

  BGNameModel({
    this.id,
    this.bgId,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bgId': bgId,
      'name': name,
    };
  }

  factory BGNameModel.fromMap(Map<String, dynamic> map) {
    return BGNameModel(
      id: map['id'] != null ? map['id'] as int : null,
      bgId: map['bgId'] != null ? map['bgId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }
}
