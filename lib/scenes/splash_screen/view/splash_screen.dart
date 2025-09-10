import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../dto/ads_item.dart';
import '../../../dto/update_version.dart';
import '../../../l10n/l10n_extension.dart';
import '../../../routes/app_routes.dart';
import '../../../utilities/app_helper.dart';
import '../../../utilities/display_alert.dart';
import '../../base/base_state.dart';
import '../view_model/ads_items_cubit.dart';
import '../view_model/update_version_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UpdateVersionCubit>().fetchUpdateVersion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateVersionCubit, BaseState>(
      listener: (context, state) {
        if (state.isFailure) {
          var version = state.data;
          if (version != null) {
            _showUpdateVersionDialog(version);
          } else {
            DisplayAlert.showGeneralSnackBar(
              context: context,
              content: state.error,
            );
          }
        } else if (state.isSuccess) {
          context.read<AdsItemsCubit>().fetchAdsItems();
        }
      },
      child: BlocListener<AdsItemsCubit, BaseState>(
        listener: (context, state) {
          if (state.isSuccess) {
            var items = state.data as List<AdsItem>;
            AppRoutes.pushReplacement(
              context,
              AppRoutes.landing,
              arguments: items,
            );
          } else if (state.isFailure) {
            DisplayAlert.showGeneralSnackBar(
              context: context,
              content: state.error,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SvgPicture.network("https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/jsonatom.svg"),
          ),
        ),
        // ),
      ),
    );
  }

  _showUpdateVersionDialog(UpdateVersion version) {
    DisplayAlert.showGeneralDialog(
      context: context,
      title: S.of(context)!.update_available,
      content: S
          .of(context)!
          .update_description('${version.versionName}(${version.versionCode})'),
      isHideCancelBtn: version.isForce,
      isCancelable: !version.isForce,
      onConfirm: () {
        var url = Platform.isAndroid ? version.androidUrl : version.iosUrl;
        AppHelper.redirectUrl(url: url ?? '');
      },
    );
  }
}
