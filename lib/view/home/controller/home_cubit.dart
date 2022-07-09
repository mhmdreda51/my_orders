// ignore_for_file: implementation_imports

import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../core/cacheHelper/cache_helper.dart';
import '../../../core/dioHelper/dio_helper.dart';
import '../../../core/router/router.dart';
import '../../food/model/store_model.dart';
import '../../food/model/store_model_of_category.dart';
import '../model/item_model.dart';
import '../model/logout_model.dart';
import '../model/popular_brands_model.dart';
import '../model/popular_food_model.dart';
import '../model/slides_model.dart';
import '../model/special_offers_model.dart';
import '../model/store_categories_model.dart';
import '../model/store_sub_categories_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
//===============================================================
  StoreCategoriesModel? storeCategoriesModel;
  StoreSubCategoriesModel? storeSubCategoriesModel;
  StoreOfCategoryModel? storeOfCategoryModel;
  StoreModel? storeModel;
  PopularBrandsModel? popularBrandsModel;
  PopularFoodModel? popularFoodModel;
  SpecialOffersModel? specialOffersModel;
  ItemModel? itemModel;
  LogoutModel? logoutModel;
  SlidesModel? slidesModel;
  int carouselIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//===============================================================
  changeCarouselIndex({required int index}) {
    carouselIndex = index;
    emit(ChangeCarouselIndex());
  }

//===============================================================
  Future<void> getSlides() async {
    emit(GetSlidesLoading());
    final response = await DioHelper.getData(
      url: slides,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      slidesModel = SlidesModel.fromJson(response.data);
      emit(GetSlidesSuccess(slidesModel: slidesModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetSlidesError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit((GetSlidesError()));
    }
  }

//===============================================================
  Future<void> getStoreCategories() async {
    emit(GetStoreCategoriesLoading());
    final response = await DioHelper.getData(
      url: storeCategories,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      storeCategoriesModel = StoreCategoriesModel.fromJson(response.data);
      emit(GetStoreCategoriesSuccess(
          storeCategoriesModel: storeCategoriesModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetStoreCategoriesError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetStoreCategoriesError());
    }
  }

//===============================================================
  Future<void> getPopularBrands() async {
    emit(GetPopularBrandsLoading());
    //TODO: change the getDataByToken to getData here
    final response = await DioHelper.getDataByToken(
      url: popularBrandsNearYou,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      popularBrandsModel = PopularBrandsModel.fromJson(response.data);
      emit(GetPopularBrandsSuccess(popularBrandsModel: popularBrandsModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetPopularBrandsError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetPopularBrandsError());
    }
  }

//===============================================================
  Future<void> getPopularFood() async {
    emit(GetPopularFoodLoading());
    //TODO: change the getDataByToken to getData here
    final response = await DioHelper.getDataByToken(
      url: popularFood,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      popularFoodModel = PopularFoodModel.fromJson(response.data);
      emit(GetPopularFoodSuccess(popularFoodModel: popularFoodModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetPopularFoodError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetPopularFoodError());
    }
  }

//===============================================================
  Future<void> getSpecialOffers() async {
    emit(GetSpecialOffersLoading());
    //TODO: change the getDataByToken to getData here
    final response = await DioHelper.getDataByToken(
      url: specialOffers,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      specialOffersModel = SpecialOffersModel.fromJson(response.data);
      emit(GetSpecialOffersSuccess(specialOffersModel: specialOffersModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetSpecialOffersError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetSpecialOffersError());
    }
  }
//===============================================================

  Future<void> getStoreOfCategory({required String categoryId}) async {
    emit(GetStoreOfCategoryLoading());
    //TODO: change the getDataByToken to getData here
    final response = await DioHelper.getDataByToken(
      url: storesOfCategory + categoryId,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      storeOfCategoryModel = StoreOfCategoryModel.fromJson(response.data);
      emit(GetStoreOfCategorySuccess(
          storeOfCategoryModel: storeOfCategoryModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetStoreOfCategoryError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetStoreOfCategoryError());
    }
  }

//===============================================================

  Future<StoreModel?> getStoreById({required String storeId}) async {
    emit(GetStoreLoading());
    //TODO: change the getDataByToken to getData here
    final response = await DioHelper.getDataByToken(
      url: store + storeId,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      storeModel = StoreModel.fromJson(response.data);
      emit(GetStoreSuccess(storeModel: storeModel!));
      return storeModel!;
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetStoreError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetStoreError());
    }
  }

//===============================================================

  Future<ItemModel?> getItemById({required String itemId}) async {
    emit(GetItemLoading());
    final response = await DioHelper.getData(
      url: item + itemId,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      itemModel = ItemModel.fromJson(response.data);
      emit(GetItemSuccess(itemModel: itemModel!));
      return itemModel!;
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetItemError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetItemError());
    }
  }

//===============================================================
  Future<void> getStoreSubCategoriesById({required String id}) async {
    emit(GetStoreSubCategoriesByIdLoading());
    final response = await DioHelper.getData(
      url: storeSubCategoriesForCategory + id,
      query: {
        'lang': MagicRouter.currentContext!.locale.languageCode == 'en'
            ? 'en'
            : 'ar'
      },
    );
    try {
      storeSubCategoriesModel = StoreSubCategoriesModel.fromJson(response.data);
      emit(GetStoreSubCategoriesByIdSuccess(
          storeSubCategoriesModel: storeSubCategoriesModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetStoreSubCategoriesByIdError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetStoreSubCategoriesByIdError());
    }
  }

//===============================================================
  Future<void> signOut() async {
    emit(LogoutLoadingState());
    final response = await DioHelper.getDataByToken(url: logout);
    try {
      logoutModel = LogoutModel.fromJson(response.data);
      await CacheHelper.signOut();
      emit(LogoutSuccessState());
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(LogoutErrorState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(LogoutErrorState());
    }
  }
}
