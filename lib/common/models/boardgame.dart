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

class BoardgameModel {
  String? bgId;
  String name;
  String image;
  int publishYear;
  int minPlayers;
  int maxPlayers;
  int minTime;
  int maxTime;
  int minAge;
  String? designer;
  String? artist;
  String? description;
  int views;
  List<String> mechsPsIds;

  BoardgameModel({
    this.bgId,
    required this.name,
    required this.image,
    required this.publishYear,
    required this.minPlayers,
    required this.maxPlayers,
    required this.minTime,
    required this.maxTime,
    required this.minAge,
    this.designer,
    this.artist,
    this.description,
    this.views = 0,
    required this.mechsPsIds,
  });

  static String cleanDescription(String text) {
    String description = text.replaceAll('<br/>', '\n');

    while (description[description.length - 1] == '\n') {
      description = description.substring(0, description.length - 1);
    }

    return description;
  }

  @override
  String toString() {
    return 'BoardgameModel('
        ' id: $bgId,\n'
        ' name: $name,\n'
        ' image: $image,\n'
        ' yearpublished: $publishYear,\n'
        ' minplayers: $minPlayers,\n'
        ' maxplayers: $maxPlayers,\n'
        ' minplaytime: $minTime,\n'
        ' maxplaytime: $maxTime,\n'
        ' age: $minAge,\n'
        ' designer: $designer,\n'
        ' artist: $artist,\n'
        ' description: $description,\n'
        ' views: $views,\n'
        ' boardgamemechanic: $mechsPsIds)';
  }
}
