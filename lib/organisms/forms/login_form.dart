import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/form_utils.dart';

class SFLoginForm extends StatefulWidget {
  final ComponentSize size;
  final double spacing;
  final Map<String, dynamic> additionalData;
  final Function(Map<String, dynamic>)? onSubmit;

  const SFLoginForm({
    super.key,
    this.onSubmit,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.sm,
    this.additionalData = const {
      'label_email': 'E-mail',
      'placeholder_email': 'Enter your email',
      'error_email_invalid': 'Invalid email address.',
      'label_password': 'Password',
      'placeholder_password': 'Enter your password',
      'error_password_length': 'Password must be at least 6 characters.',
      'login_button': 'Login',
    },
  });

  @override
  State<SFLoginForm> createState() => _SFLoginFormState();
}

class _SFLoginFormState extends State<SFLoginForm> {
  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _buttonNode;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _buttonNode = FocusNode();

    _emailController = TextEditingController(text: form.control('email').value);
    _passwordController = TextEditingController(
      text: form.control('password').value,
    );

    _emailController.addListener(() {
      form.control('email').value = _emailController.text;
    });

    _passwordController.addListener(() {
      form.control('password').value = _passwordController.text;
    });
  }

  @override
  void dispose() {
    // Libérer les ressources
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _buttonNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: widget.spacing,
      children: [
        SFFormfield(
          isRequired: form
              .control('email')
              .validators
              .any((validator) => validator is RequiredValidator),
          label: widget.additionalData['label_email'] ?? '',
          input: SFTextField(
            focusNode: _emailFocusNode,
            autofocus: true,
            onSubmitted: (value) {
              _fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
            },
            placeholder: widget.additionalData['placeholder_email'] ?? '',
            controller: _emailController,
            size: widget.size,
            isInError:
                form.control('email').touched && form.control('email').invalid,
          ),
          errorMessage:
              form.control('email').touched && form.control('email').invalid
                  ? widget.additionalData['error_email_invalid']
                  : null,
        ),
        SFFormfield(
          isRequired: form
              .control('password')
              .validators
              .any((validator) => validator is RequiredValidator),
          label: widget.additionalData['label_password'] ?? '',
          input: SFPasswordField(
            focusNode: _passwordFocusNode,
            onSubmitted: (value) {
              _fieldFocusChange(context, _passwordFocusNode, _buttonNode);
            },
            textInputAction: TextInputAction.done,
            placeholder: widget.additionalData['placeholder_password'] ?? '',
            controller: _passwordController,
            size: widget.size,
            isInError:
                form.control('password').touched &&
                form.control('password').invalid,
          ),
          errorMessage:
              form.control('password').touched &&
                      form.control('password').invalid
                  ? widget.additionalData['error_password_length'] ?? ''
                  : null,
        ),
        SFMainButton(
          focusNode: _buttonNode,
          label: widget.additionalData['login_button'] ?? 'Login',
          size: widget.size,
          onPressed: () {
            if (FormUtils.isFormValid(form, setState: () => setState(() {}))) {
              widget.onSubmit?.call(form.value);
            }
          },
        ),
      ],
    );
  }
}
