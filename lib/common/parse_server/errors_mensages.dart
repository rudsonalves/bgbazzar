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

class ParserServerErrors {
  static String message(String err) {
    final code = _getErroCode(err);

    switch (code) {
      case 101:
        return 'Usuário e senha inválidos. Por favor, tente novamente.';
      case 202:
        return 'Este usuário já possui cadastro. Tente '
            'um outro usuário ou recupere a senha na página de login.';
      case 203:
        return 'Este e-mail já foi utilizado. Tente '
            'um outro e-mail ou recupere a senha na página de login.';
      case 205:
        return 'Esta conta ainda não foi verificada. Verifique sua caixa de e-mail.';
      default:
        return 'Desculpe. Ocorreu um erro. Por favor, tente mais tarde.';
    }
  }

  static int _getErroCode(String errStr) {
    String code = '';
    for (final line in errStr.split('\n')) {
      if (line.contains(':')) {
        final value = line.trim().split(':');
        final key = value[0];
        code = value[1].trim();
        if (key.trim() == 'Code') break;
      }
    }

    int icode = int.tryParse(code.trim()) ?? -1;

    if (icode == -1) {
      if (errStr.contains('Account already exists for this username.')) {
        icode = 203;
      }
    }

    return icode;
  }
}
