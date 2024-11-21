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

const maxAdsPerList = 20;

const keyRoleDefult = 'user'; // default role
const keyRoleUsers = 'users'; // _Role relationship users column
const keyRoleTable = '_Role'; // role table name
const keyRoleName = 'name'; // role column name

const keyUserId = 'objectId';
const keyUserName = 'username';
const keyUserNickname = 'nickname';
const keyUserEmail = 'email';
const keyUserPassword = 'password';
const keyUserPhone = 'phone';
const keyUserRole = 'role';

const keyAddressTable = 'Addresses';
const keyAddressId = 'objectId';
const keyAddressName = 'name';
const keyAddressZipCode = 'zipCode';
const keyAddressStreet = 'street';
const keyAddressNumber = 'number';
const keyAddressComplement = 'complement';
const keyAddressNeighborhood = 'neighborhood';
const keyAddressState = 'state';
const keyAddressCity = 'city';
const keyAddressOwner = 'owner';
const keyAddressCreatedAt = 'createdAt';

const keyAdTable = 'AdsSale';
const keyAdId = 'objectId';
const keyAdOwner = 'owner';
const keyAdOwnerId = 'ownerId';
const keyAdOwnerName = 'ownerName';
const keyAdOwnerRate = 'ownerRate';
const keyAdOwnerCity = 'ownerCity';
const keyAdOwnerCreatedAt = 'ownerCreatedAt';
const keyAdTitle = 'title';
const keyAdDescription = 'description';
const keyAdQuantity = 'quantity';
const keyAdPrice = 'price';
const keyAdStatus = 'status';
const keyAdMechanics = 'mechanic';
const keyAdImages = 'images';
const keyAdAddress = 'address';
const keyAdViews = 'views';
const keyAdCondition = 'condition';
const keyAdCreatedAt = 'createdAt';
const keyAdBoardGame = 'boardgame';

const keyFavoriteTable = 'Favorites';
const keyFavoriteId = 'objectId';
const keyFavoriteOwner = 'owner';
const keyFavoriteAd = 'ad';

const keyBgTable = 'Boardgame';
const keyBgId = 'objectId';
const keyBgName = 'name';
const keyBgImage = 'image';
const keyBgPublishYear = 'publishYear';
const keyBgMinPlayers = 'minPlayers';
const keyBgMaxPlayers = 'maxPlayers';
const keyBgMinTime = 'minTime';
const keyBgMaxTime = 'maxtime';
const keyBgMinAge = 'minAge';
const keyBgDesigner = 'designer';
const keyBgArtist = 'artist';
const keyBgDescription = 'description';
const keyBgMechanics = 'mechanics';

const keyMechanicTable = 'Mechanics';
const keyMechanicId = 'objectId';
const keyMechanicName = 'name';
const keyMechanicDescription = 'description';
