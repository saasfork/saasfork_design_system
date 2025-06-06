import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/form_utils.dart';

class SFForgotPasswordForm extends StatefulWidget {
  final ComponentSize size;
  final double spacing;
  final Map<String, dynamic> additionalData;
  final Function(Map<String, dynamic>)? onSubmit;

  const SFForgotPasswordForm({
    super.key,
    this.onSubmit,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.sm,
    this.additionalData = const {
      'label_email': 'Email',
      'placeholder_email': 'Enter your email',
      'error_email_invalid': 'Please enter a valid email.',
      'forgot_password_button': 'Submit',
    },
  });

  @override
  State<SFForgotPasswordForm> createState() => _SFForgotPasswordFormState();
}

class _SFForgotPasswordFormState extends State<SFForgotPasswordForm> {
  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
  });

  late final FocusNode _emailFocusNode;
  late final FocusNode _buttonNode;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _buttonNode = FocusNode();
    _emailController = TextEditingController(text: form.control('email').value);

    _emailController.addListener(() {
      form.control('email').value = _emailController.text;
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _buttonNode.dispose();
    _emailController.dispose();
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
              _fieldFocusChange(context, _emailFocusNode, _buttonNode);
            },
            textInputAction: TextInputAction.done,
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
        SFMainButton(
          focusNode: _buttonNode,
          label: widget.additionalData['forgot_password_button'] ?? '',
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
