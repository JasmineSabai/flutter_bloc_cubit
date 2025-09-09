import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_enum.dart';
import '../../constants/response_result.dart';
import 'base_state.dart';
import 'model/base_response.dart';

class BaseCubit<T> extends Cubit<BaseState<T>> {
  BaseCubit() : super(const BaseState());

  void emitLoading() => emit(state.copyWith(status: NetworkStatus.loading));

  void emitDataSuccess(T data) =>
      emit(BaseState(status: NetworkStatus.success, data: data));

  void emitDataFailure(T? data, String error) =>
      emit(BaseState(status: NetworkStatus.failure, data: data, error: error));

  void emitApiSuccess(BaseResponse<T> response) =>
      emit(BaseState(status: NetworkStatus.success, data: response.data));

  void emitApiFailure(String error) =>
      emit(BaseState(status: NetworkStatus.failure, error: error));

  void emitTokenExpired(String error) =>
      emit(BaseState(status: NetworkStatus.failure, error: error));

  void handleResponse(BaseResponse<T> response) {
    if (response.responseCode == ResponseResult.success.code) {
      emitApiSuccess(response);
    } else if (response.responseCode == ResponseResult.tokenExpired.code) {
      emitTokenExpired(response.responseMessage);
    } else {
      emitApiFailure(response.responseMessage);
    }
  }
}
