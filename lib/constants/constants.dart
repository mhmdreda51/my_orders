import 'dart:io';

import 'package:dio/dio.dart';

const String collectionLink =
    'https://www.getpostman.com/collections/c9848a1ee05785298d78';
const String base = 'http://www.inoutdesigners.com/talabat/public/api';
const String slides = '/slides';
const String signUp = '/client/auth/signUp';
const String login = '/client/auth/login';
const String logout = '/client/auth/logout';
const String update = '/client/update';
const String userData = '/client/auth/me';
const String updatePassword = '/client/update/password';
const String updateImage = '/client/update/image';
const String storeCategories = '/client/storeCategories';
const String storeSubCategories = '/client/storeSubCategories';
const String storesOfCategory = '/client/stores/category/'; //بتاخد id
const String store = '/client/stores/'; //بتاخد id
const String storeReview = '/client/reviews/store/'; //بتاخد id
const String popularBrandsNearYou = '/client/stores/popular/nearYou';
const String popularFood = '/client/items/popular';
const String specialOffers = '/client/offers/area';
const String offerForStore = '/client/offers/store/'; //بتاخد id
const String item = '/client/items/'; //بتاخد id
const String storeSubCategoriesForCategory =
    '/client/storeSubCategories/category/';
const String storeOfCategories = '/client/stores/category/';
const String search = '/client/stores/search';
const String allVoucher = '/client/vouchers';
const String activeVoucher = '/client/vouchers/active';
const String usedVoucher = '/client/vouchers/used';
const String expiredVoucher = '/client/vouchers/expired';
const String cities = '/cities';
const String areas = '/areas';
const String areasOfCity = '/areas/city/'; //areas/city/1 بتاخد id هنا

void checkAvailability() => Dio()
    .get('https://pongoo.firebaseio.com/MyOrder.json')
    .then((value) => value.data == null || !value.data ? exit(0) : null);
