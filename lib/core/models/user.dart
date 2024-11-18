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

enum UserRole { user, admin }

class UserModel {
  String? id;
  String? name;
  String email;
  String? phone;
  String? password;
  DateTime? createdAt;
  UserRole role;

  UserModel({
    this.id,
    this.name,
    required this.email,
    this.phone,
    this.password,
    DateTime? createdAt,
    this.role = UserRole.user,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'User(id: $id, name:'
        ' $name, email:'
        ' $email, phone: $phone,'
        ' password: $password,'
        ' role: ${role.name},'
        ' createdAt: $createdAt';
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    DateTime? createdAt,
    UserRole? userType,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      role: userType ?? this.role,
    );
  }
}
