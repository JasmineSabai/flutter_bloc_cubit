import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/iconoir.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../l10n/l10n_extension.dart';
import '../../../theme/app_text_theme.dart';
import '../../../utilities/display_alert.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../base/base_state.dart';
import '../model/login_request.dart';
import '../view_model/login_cubit.dart';
import '../view_model/login_google_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              _headerLogoWidgets(),

              Expanded(flex: 1, child: _welcomeTextWidgets()),

              Expanded(flex: 5, child: _formNewUserWidgets()),
            ],
          ),
        ),
      ),
    );
  }

  _headerLogoWidgets() {
    return Column(
      children: [
        SvgPicture.network("https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/jsonatom.svg", width: 100),
      ],
    );
  }

  _welcomeTextWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context)!.welcome, style: AppTextTheme.title1),
        Text(S.of(context)!.welcomeDescription, style: AppTextTheme.body),
      ],
    );
  }

  _welcomeOldUserTextWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context)!.helloAgain, style: AppTextTheme.title1),
        Text(
          '${S.of(context)!.welcomeBackDescription} ${S.of(context)!.welcomeDescription.toLowerCase()}',
          style: AppTextTheme.body,
        ),
      ],
    );
  }

  _formNewUserWidgets() {
    return Column(
      children: [
        CustomTextField(
          label: S.of(context)!.email,
          controller: _emailController,
          hintText: S
              .of(context)!
              .enterYour(
                "${S.of(context)!.company} ${S.of(context)!.email.toLowerCase()}",
              ),
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: _passwordController,
          isPassword: true,
          label: S.of(context)!.password,
          hintText: S
              .of(context)!
              .enterYour(S.of(context)!.password.toLowerCase()),
        ),

        SizedBox(height: 20),
        /* BlocListener<LoginCubit, BaseState>(
          listener: (context, state) {
            debugPrint("state: $state");
            if (state.isSuccess) {
              DisplayAlert.showGeneralSnackBar(
                context: context,
                content: 'Success',
              );
            } else if (state.isFailure) {
              DisplayAlert.showGeneralSnackBar(
                context: context,
                content: state.error,
              );
            }
          },
          child: */
        CustomButton(
          label: S.of(context)!.login,
          onPressed: () {
            var request = LoginRequest(
              email: _emailController.text,
              password: _passwordController.text,
            );
            context.read<LoginCubit>().loginWithFirebaseAuthEmail(request);
          },
        ),

        // ),
        SizedBox(height: 20),
        Text(S.of(context)!.orLoginWith, style: AppTextTheme.body),
        SizedBox(height: 20),

        _loginOptionWidgets(),
      ],
    );
  }

  _loginOptionWidgets() {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _loginTypeWidget(
              iconString: Iconoir.face_id,
              label: S.of(context)!.biometric,
              onPressed: () {},
            ),
          ),
          SizedBox(width: 0.5),
          Expanded(
            child: _loginTypeWidget(
              iconString: Ri.microsoft_fill,
              label: S.of(context)!.microsoft,
              onPressed: () {},
            ),
          ),
          SizedBox(width: 0.5),
          Expanded(
            child: BlocListener<LoginGoogleCubit, BaseState>(
              listener: (context, state) {
                debugPrint("state: $state");
                if (state.isSuccess) {
                  DisplayAlert.showGeneralSnackBar(
                    context: context,
                    content: 'Success',
                  );
                } else if (state.isFailure) {
                  DisplayAlert.showGeneralSnackBar(
                    context: context,
                    content: state.error,
                  );
                }
              },
              child: _loginTypeWidget(
                iconString: Ri.google_line,
                label: S.of(context)!.google,
                onPressed: () {
                  context.read<LoginGoogleCubit>().loginWithGoogle();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _loginTypeWidget({
    required String iconString,
    required String label,
    VoidCallback? onPressed,
  }) {
    return Container(
      color: Colors.white,
      child: CustomTextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Iconify(iconString, color: AppColors.primary),
            SizedBox(width: 10),
            Text(label, style: AppTextTheme.body),
          ],
        ),
      ),
    );
  }
}
