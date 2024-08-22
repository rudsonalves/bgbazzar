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

class Utils {
  static String title(String text) {
    final buffer = StringBuffer();
    final trimText = text.trim();
    String before = '';
    for (int i = 0; i < trimText.length; i++) {
      if (i == 0) {
        buffer.write(trimText[i].toUpperCase());
        continue;
      }
      final c = trimText[i];
      if (before == ' ' && c != ' ') {
        buffer.write(c.toUpperCase());
      } else {
        buffer.write(c.toLowerCase());
      }

      before = c;
    }

    return buffer.toString();
  }

  static String normalizeFileName(String fileName) {
    // Remove accents
    String normalized = _removeDiacritics(fileName);

    // Replace spaces with underscore
    normalized = normalized.replaceAll(' ', '_');

    // Remove or replace other invalid characters
    normalized = normalized.replaceAll(RegExp(r'[^\w\.\-]'), '');

    return normalized;
  }

  static String _removeDiacritics(String text) {
    const base = 'áéíóúàèìòùäëïöüâêîôûãẽĩõũçñÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛÃẼĨÕŨÇÑ'
        'åÅøØæÆœŒßþÞðÐ'
        'šŠžŽ'
        'łŁ'
        'đĐ'
        'ńŃ'
        'řŘ'
        'ůŮ'
        'čČ'
        'ďĎ'
        'ťŤ'
        'ýÝ'
        'žŽ'
        'ůŮ'
        'ľĽ'
        'żŻ'
        'ąĄęĘłŁńŃśŚźŹ'
        'çÇ'
        'ğĞşŞ'
        'æÆøØåÅ'
        'ªº'
        ' ';
    const replace = 'aeiouaeiouaeiouaeiouaeioucnAEIOUAEIOUAEIOUAEIOUAEIOUCN'
        'aAooeEe'
        'sSzZ'
        'lL'
        'dD'
        'nN'
        'rR'
        'uU'
        'cC'
        'dD'
        'tT'
        'yY'
        'zZ'
        'uU'
        'lL'
        'zZ'
        'aAeoEnNsSzZ'
        'cC'
        'gGsS'
        'aeAEoeOaA'
        'aO'
        '_';

    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      int index = base.indexOf(char);
      if (index != -1) {
        buffer.write(replace[index]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }
}
