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

const dbName = 'bgBazzar.db';
const dbVersion = 1;
const dbAssertPath = 'assets/data/bgBazzar.db';

const mechTable = "mechanics";
const mechIndexName = "mechNameIndex";
const mechIndexNome = "mechNomeIndex";
const mechId = "id";
const mechName = "name";
const mechNome = "nome";
const mechDescription = "description";
const mechDescricao = "descricao";

const dbVersionTable = "dbVersion";
const dbVersionId = "id";
const dbAppVersion = "version";
const dbBGVersion = 'bg_version';
const dbBGList = 'bg_list';

const bgNamesTable = 'bgNames';
const bgId = 'id';
const bgBgId = 'bgId';
const bgName = 'name';

const dbAppVersionValue = 1002;
const dbBGVersionValue = 1;
