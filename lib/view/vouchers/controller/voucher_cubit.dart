// ignore_for_file: implementation_imports

import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../core/dioHelper/dio_helper.dart';
import '../../../core/router/router.dart';
import '../model/voucher_model.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(VoucherInitial());
  static VoucherCubit get(context) => BlocProvider.of(context);
//===============================================================
  VoucherModel? allVoucherModel;
  VoucherModel? activeVoucherModel;
  VoucherModel? usedVoucherModel;
  VoucherModel? expiredVoucherModel;
//===============================================================
  Future<void> getAllVouchers() async {
    emit(AllVoucherLoading());
    final response = await DioHelper.getDataByToken(url: allVoucher, query: {
      'lang':
          MagicRouter.currentContext!.locale.languageCode == 'en' ? 'en' : 'ar'
    });
    try {
      allVoucherModel = VoucherModel.fromJson(response.data);
      emit(AllVoucherSuccess(voucherModel: allVoucherModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(AllVoucherError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(AllVoucherError());
    }
  }

  //===============================================================
  Future<void> getActiveVouchers() async {
    emit(ActiveVoucherLoading());
    final response = await DioHelper.getDataByToken(url: activeVoucher, query: {
      'lang':
          MagicRouter.currentContext!.locale.languageCode == 'en' ? 'en' : 'ar'
    });
    try {
      activeVoucherModel = VoucherModel.fromJson(response.data);
      emit(ActiveVoucherSuccess(voucherModel: activeVoucherModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(ActiveVoucherError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(ActiveVoucherError());
    }
  }

  //===============================================================
  Future<void> getUsedVouchers() async {
    emit(UsedVoucherLoading());
    final response = await DioHelper.getDataByToken(url: usedVoucher, query: {
      'lang':
          MagicRouter.currentContext!.locale.languageCode == 'en' ? 'en' : 'ar'
    });
    try {
      usedVoucherModel = VoucherModel.fromJson(response.data);
      emit(ActiveVoucherSuccess(voucherModel: usedVoucherModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(UsedVoucherError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(UsedVoucherError());
    }
  }

  //===============================================================
  Future<void> getExpiredVouchers() async {
    emit(ExpiredVoucherLoading());
    final response =
        await DioHelper.getDataByToken(url: expiredVoucher, query: {
      'lang':
          MagicRouter.currentContext!.locale.languageCode == 'en' ? 'en' : 'ar'
    });
    try {
      expiredVoucherModel = VoucherModel.fromJson(response.data);
      emit(ActiveVoucherSuccess(voucherModel: expiredVoucherModel!));
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(ExpiredVoucherError());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(ExpiredVoucherError());
    }
  }
}
