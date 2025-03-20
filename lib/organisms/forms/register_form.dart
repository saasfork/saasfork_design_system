import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/form_utils.dart';

class SFRegisterForm extends StatefulWidget {
  final ComponentSize size;
  final double spacing;
  final Map<String, dynamic> additionalData;
  final Function(Map<String, dynamic>)? onSubmit;

  const SFRegisterForm({
    super.key,
    this.onSubmit,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.sm,
    this.additionalData = const {
      'label_email': 'Email',
      'placeholder_email': 'Enter your email',
      'error_email_invalid': 'Please enter a valid email.',
      'label_password': 'Password',
      'placeholder_password': 'Enter your password',
      'error_password_length': 'Password must be at least 6 characters long.',
      'register_button': 'Create account',
    },
  });

  @override
  State<SFRegisterForm> createState() => _SFRegisterFormState();
}

class _SFRegisterFormState extends State<SFRegisterForm> {
  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
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
              .any((validator) => validator == Validators.required),
          label: widget.additionalData['label_email'] ?? '',
          input: SFTextField(
            placeholder: widget.additionalData['placeholder_email'] ?? '',
            controller: _emailController,
            size: widget.size,
            isInError:
                form.control('email').touched && form.control('email').invalid,
          ),
          errorMessage:
              form.control('email').touched && form.control('email').invalid
                  ? widget.additionalData['error_email_invalid'] ?? ''
                  : null,
        ),
        SFFormfield(
          isRequired: form
              .control('password')
              .validators
              .any((validator) => validator == Validators.required),
          label: widget.additionalData['label_password'] ?? '',
          input: SFPasswordField(
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
          label: widget.additionalData['register_button'] ?? '',
          onPressed: () {
            if (FormUtils.isFormValid(form, setState: () => setState(() {}))) {
              widget.onSubmit?.call(form.value);
            }
          },
          size: widget.size,
        ),
      ],
    );
  }
}
