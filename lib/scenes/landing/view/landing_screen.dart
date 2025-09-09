import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../dto/ads_item.dart';
import '../../../l10n/l10n_extension.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_button.dart';
import '../../base/base_state.dart';
import '../view_model/landing_cubit.dart';
import 'landing_view.dart';

class LandingScreen extends StatefulWidget {
  final List<AdsItem> items;

  const LandingScreen({super.key, required this.items});

  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late PageController _controller;
  LandingCubit? landingCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LandingCubit>().startTimer();
    });
    _controller = PageController(viewportFraction: 1.0, keepPage: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Safely get the ancestor here and cache it
    landingCubit = context.read<LandingCubit>();
  }

  @override
  void dispose() {
    _controller.dispose();
    landingCubit?.close();
    super.dispose();
  }

  void _goToLoginPage() {
    AppRoutes.pushReplacement(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LandingCubit, BaseState>(
          listener: (context, state) {
            _controller.animateToPage(
              state.data,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
          builder: (context, state) {
            final cubit = context.read<LandingCubit>();
            cubit.setPageCount(widget.items.length);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                Flexible(
                  flex: 1,
                  child: PageView.builder(
                    controller: _controller,
                    clipBehavior: Clip.none,
                    itemCount: widget.items.length,
                    onPageChanged: (index) {
                      cubit.setPage(index);
                    },
                    itemBuilder: (_, index) {
                      return LandingView(
                        image: widget.items[index].image,
                        label: widget.items[index].label,
                        description: widget.items[index].description,
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                SmoothPageIndicator(
                  controller: _controller,
                  count: widget.items.length,
                  effect: const ExpandingDotsEffect(
                    dotWidth: 5,
                    dotHeight: 5,
                    activeDotColor: AppColors.information,
                    dotColor: AppColors.secondary,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    label: S.of(context)!.skip,
                    isLightColor: true,
                    onPressed: () => _goToLoginPage(),
                  ),
                ),
                SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}
