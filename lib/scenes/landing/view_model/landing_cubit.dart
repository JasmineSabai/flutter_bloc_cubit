import 'dart:async';
import '../../base/base_cubit.dart';

class LandingCubit extends BaseCubit<int> {
  late int _pageCount;
  late Timer _timer;
  // final _sharedPreferenceService = SharedPreferenceService();

  LandingCubit() : super() {
    // Initial state data is null; emit 0 as current page
    // emit(state.copyWith(data: 0));
    emitDataSuccess(0);
  }

  bool get isFinalPage => (state.data ?? 0) >= _pageCount - 1;

  void setPageCount(int value) {
    _pageCount = value;
  }
  int get pageCount => _pageCount;

  void startTimer({int? index}) {
    _timer = Timer.periodic(Duration(seconds: 30), (_) {
      if (isFinalPage) {
        _timer.cancel();
      } else {
        if (_timer.isActive) {
          _timer.cancel();
        }
        startTimer();
        if (!isClosed) {
          // emit(state.copyWith(data: (state.data ?? 0) + 1));
          emitDataSuccess((state.data ?? 0) + 1);
        }
      }
    });
  }

  void nextPage() {
    if (!isFinalPage) {

      emitDataSuccess((state.data ?? 0) + 1);
      // emit(state.copyWith(data: (state.data ?? 0) + 1));
    }
  }

  void setPage(int index) {
    if (index >= 0 && index < pageCount) {
      // emit(state.copyWith(data: index));
      emitDataSuccess(index);
      startTimer(index: index);
    }
    ;
  }

  // Future<bool> get isOldUser => _sharedPreferenceService.loadBoolData(
  //   key: PreferenceDataName.isOldUser.name,
  // );

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
