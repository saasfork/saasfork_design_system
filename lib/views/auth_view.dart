import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

class SFAuthView extends StatefulWidget {
  final AuthFormData additionalData;
  final Future Function(LoginModel)? onLogin;
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

class SFAuthViewState extends State<SFAuthView> with SignalsMixin {
  late final _isLoading = createSignal<bool>(false);
  final PageController _pageController = PageController();
  late AuthFormData formData;
  int _currentPageIndex = 0;

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

  void _setPage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
  }

  Widget _buildLoginPage() => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.md,
      children: [
        SFLoginForm(
          isLoading: _isLoading.value,
          additionalData: formData.toMap(),
          onSubmit:
              widget.onLogin != null
                  ? (loginData) async {
                    final typedValues = LoginModel.fromMap(loginData);
                    _isLoading.value = true;
                    await widget.onLogin!(typedValues);
                    _isLoading.value = false;
                  }
                  : null,
        ),
        Column(
          spacing: AppSpacing.sm,
          children: [
            _richText(
              text:
                  formData.authNotAccount.text ?? 'Don\'t have an account yet?',
              link: formData.authNotAccount.link,
              onTap: () {
                _setPage(1);
              },
            ),
            _richText(
              link: formData.authForgotPassword.link,
              onTap: () {
                _setPage(2);
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
  );

  Widget _buildRegisterPage() => SingleChildScrollView(
    child: Column(
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
            _setPage(0);
          },
        ),
      ],
    ),
  );

  Widget _buildForgotPasswordPage() => SingleChildScrollView(
    child: Column(
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
            _setPage(0);
          },
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: ValueNotifier<int>(_currentPageIndex),
      builder: (context, pageIndex, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return IntrinsicHeight(
              child: IndexedStack(
                index: pageIndex,
                children: [
                  _buildLoginPage(),
                  _buildRegisterPage(),
                  _buildForgotPasswordPage(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
