import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../scenes/landing/view_model/landing_cubit.dart';
import '../scenes/login/repositories/login_repository.dart';
import '../scenes/login/view_model/login_cubit.dart';
import '../scenes/login/view_model/login_google_cubit.dart';
import '../scenes/splash_screen/repositories/splash_repository.dart';
import '../scenes/splash_screen/view_model/ads_items_cubit.dart';
import '../scenes/splash_screen/view_model/update_version_cubit.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (_) => UpdateVersionCubit(context.read<SplashRepository>()),
        ),
        BlocProvider(
          create: (_) => AdsItemsCubit(context.read<SplashRepository>()),
        ),
        BlocProvider(create: (_) => LandingCubit()),
        BlocProvider(create: (_) => LoginCubit(context.read<LoginRepository>())),
        BlocProvider(create: (_) => LoginGoogleCubit(context.read<LoginRepository>())),
      ],
      child: child,
    );
  }
}
