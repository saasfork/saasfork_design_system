import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFAuthView extends StatefulWidget {
  final AuthFormData additionalData;
  final Function(LoginModel)? onLogin;
  final Function(RegisterModel)? onRegister;
  final Function(ForgotPasswordModel)? onForgotPassword;
  final Function? onGoogleConnect;
  final Function? onGithubConnect;

  const SFAuthView({
    super.key,
    required this.additionalData,
    this.onLogin,
    this.onRegister,
    this.onForgotPassword,
    this.onGoogleConnect,
    this.onGithubConnect,
  });

  @override
  State<SFAuthView> createState() => SFAuthViewState();
}

class SFAuthViewState extends State<SFAuthView> {
  final PageController _pageController = PageController();
  late AuthFormData formData;

  @override
  void initState() {
    super.initState();
    formData = widget.additionalData;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  RichText _richText({String? text, required String link, Function? onTap}) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          if (text != null) TextSpan(text: text),
          TextSpan(
            text: link,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
            recognizer:
                onTap != null
                    ? (TapGestureRecognizer()..onTap = () => onTap())
                    : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.md,
          children: [
            SFLoginForm(
              additionalData: formData.toMap(),
              onSubmit:
                  widget.onLogin != null
                      ? (loginData) {
                        final typedValues = LoginModel.fromMap(loginData);
                        widget.onLogin!(typedValues);
                      }
                      : null,
            ),
            Column(
              spacing: AppSpacing.xs,
              children: [
                _richText(
                  text:
                      formData.authNotAccount.text ??
                      'Don\'t have an account yet?',
                  link: formData.authNotAccount.link,
                  onTap: () {
                    _pageController.jumpToPage(1);
                  },
                ),
                _richText(
                  link: formData.authForgotPassword.link,
                  onTap: () {
                    _pageController.jumpToPage(2);
                  },
                ),
              ],
            ),
            if ((widget.onGithubConnect != null ||
                    widget.onGoogleConnect != null) &&
                formData.dividerText != null)
              SFDividerWithText(text: formData.dividerText!),
            if (widget.onGoogleConnect != null)
              SFSecondaryIconButton(
                icon: FontAwesomeIcons.google,
                label: 'Connexion avec Google',
                onPressed: () => widget.onGoogleConnect!(),
              ),
            if (widget.onGithubConnect != null)
              SFSecondaryIconButton(
                icon: FontAwesomeIcons.github,
                label: 'Connexion Github',
                onPressed: () => widget.onGithubConnect!(),
              ),
          ],
        ),
        Column(
          spacing: AppSpacing.md,
          children: [
            SFRegisterForm(
              additionalData: formData.toMap(),
              onSubmit:
                  widget.onRegister != null
                      ? (registerData) {
                        final typedValues = RegisterModel.fromMap(registerData);
                        widget.onRegister!(typedValues);
                      }
                      : null,
            ),
            _richText(
              text: formData.authAlreadyExists.text,
              link: formData.authAlreadyExists.link,
              onTap: () {
                _pageController.jumpToPage(0);
              },
            ),
          ],
        ),
        Column(
          spacing: AppSpacing.md,
          children: [
            SFForgotPasswordForm(
              additionalData: formData.toMap(),
              onSubmit:
                  widget.onForgotPassword != null
                      ? (forgotPasswordData) {
                        final typedValues = ForgotPasswordModel.fromMap(
                          forgotPasswordData,
                        );
                        widget.onForgotPassword!(typedValues);
                      }
                      : null,
            ),
            _richText(
              text: formData.authAlreadyExists.text,
              link: formData.authAlreadyExists.link,
              onTap: () {
                _pageController.jumpToPage(0);
              },
            ),
          ],
        ),
      ],
    );
  }
}
