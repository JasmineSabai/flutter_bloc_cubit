import 'package:equatable/equatable.dart';

import '../../constants/app_enum.dart';


class BaseState<T> extends Equatable {
  final NetworkStatus status;
  final T? data;
  final String? error;

  const BaseState({
    this.status = NetworkStatus.initial,
    this.data,
    this.error,
  });

  bool get isLoading => status == NetworkStatus.loading;
  bool get isSuccess => status == NetworkStatus.success;
  bool get isFailure => status == NetworkStatus.failure;

  BaseState<T> copyWith({
    NetworkStatus? status,
    T? data,
    String? error,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error
    );
  }

  @override
  List<Object?> get props => [status, data, error];

}
