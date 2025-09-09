import '../../../constants/app_enum.dart';
import '../../../dto/ads_item.dart';
import '../../base/base_cubit.dart';
import '../repositories/splash_repository.dart';

class AdsItemsCubit extends BaseCubit<List<AdsItem>> {
  final SplashRepository splashRepository;

  AdsItemsCubit(this.splashRepository) : super();

  Future<void> fetchAdsItems() async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      splashRepository.getAdsItems().then((items){
        items.sort((a, b) => a.id.compareTo(b.id));
        emitDataSuccess(items);
      });
    } catch (e) {
      emitDataFailure(null, e.toString());
    }
  }
}
