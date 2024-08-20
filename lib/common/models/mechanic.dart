// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class MechanicModel {
  int? id;
  String? psId;
  String name;
  String? description;

  MechanicModel({
    this.id,
    this.psId,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'psId': psId,
      'name': name,
      'description': description,
    };
  }

  factory MechanicModel.fromMap(Map<String, dynamic> map) {
    return MechanicModel(
      id: map['id'] as int,
      psId: map['psId'] as String?,
      name: map['name'] as String,
      description: map['description'] as String?,
    );
  }

  @override
  String toString() {
    return 'MechanicModel(id: $id,'
        ' psId: $psId,'
        ' name: $name,'
        ' description: $description)';
  }
}
