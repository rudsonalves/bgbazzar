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

const dbName = 'bgg.db';
const dbVersion = 1;
const dbAssertPath = 'assets/data/bgg.db';

const rankTable = "bggRank";
const rankIndex = "rankGameNameIndex";
const rankId = "id";
const rankGameName = "gameName";
const rankYearPublished = "yearPublished";
const rankBggRank = "rank";
const rankBayesAverage = "bayesAverage";
const rankAverage = "average";
const rankUsersRated = "usersRated";
const rankIsExpansion = "isExpansion";
const rankAbstractsRank = "abstractsRank";
const rankCgsRank = "cgsRank";
const rankChildrensgamesRank = "childrensGamesrank";
const rankConstFamilyGamesRank = "familyGamesRank";
const rankPartyGamesRank = "partyGamesRank";
const rankStrategyGamesRank = "strategyGamesRank";
const rankThematicRank = "thematicRank";
const rankWarGamesRank = "warGamesRank";

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
const dbVersionNumber = "version";
const dbCurrentVersion = 1002;
