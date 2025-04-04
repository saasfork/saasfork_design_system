import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saasfork_design_system/foundations/models/profile_model.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/form_utils.dart';

class SFProfileForm extends StatefulWidget {
  final ComponentSize size;
  final double spacing;
  final Map<String, dynamic> additionalData;
  final ProfileModel? profileModel;
  final Function(Map<String, dynamic>)? onSubmit;
  final VoidCallback? onDelete;

  const SFProfileForm({
    super.key,
    this.onSubmit,
    this.onDelete,
    this.profileModel,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.sm,
    this.additionalData = const {
      'label_email': 'E-mail',
      'placeholder_email': 'Entrez votre email',
      'error_email_invalid': 'Adresse email invalide.',
      'label_username': 'Nom d\'utilisateur',
      'placeholder_username': 'Entrez votre nom d\'utilisateur',
      'error_username_required': 'Le nom d\'utilisateur est requis.',
      'save_button': 'Enregistrer',
    },
  });

  @override
  State<SFProfileForm> createState() => _SFProfileFormState();
}

class _SFProfileFormState extends State<SFProfileForm> {
  late FormGroup form;

  late TextEditingController _emailController;
  late TextEditingController _usernameController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _buttonNode;

  @override
  void initState() {
    super.initState();

    form = FormGroup({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
        value: widget.profileModel?.email,
      ),
      'username': FormControl<String>(
        validators: [Validators.required],
        value: widget.profileModel?.username,
      ),
    });

    _emailController = TextEditingController(text: form.control('email').value);
    _usernameController = TextEditingController(
      text: form.control('username').value,
    );

    _emailFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _buttonNode = FocusNode();

    _emailController.addListener(() {
      form.control('email').value = _emailController.text;
      form.control('email').updateValueAndValidity();
    });

    _usernameController.addListener(() {
      form.control('username').value = _usernameController.text;
      form.control('username').updateValueAndValidity();
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _buttonNode.dispose();
    _emailController.dispose();
    _usernameController.dispose();
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
              _fieldFocusChange(context, _emailFocusNode, _usernameFocusNode);
            },
            placeholder: widget.additionalData['placeholder_email'] ?? '',
            controller: _emailController,
            size: widget.size,
            isInError:
                form.control('email').touched && !form.control('email').valid,
          ),
          errorMessage:
              form.control('email').touched && !form.control('email').valid
                  ? widget.additionalData['error_email_invalid']
                  : null,
        ),
        SFFormfield(
          isRequired: form
              .control('username')
              .validators
              .any((validator) => validator is RequiredValidator),
          label: widget.additionalData['label_username'] ?? '',
          input: SFTextField(
            focusNode: _usernameFocusNode,
            onSubmitted: (value) {
              _fieldFocusChange(context, _usernameFocusNode, _buttonNode);
            },
            textInputAction: TextInputAction.done,
            placeholder: widget.additionalData['placeholder_username'] ?? '',
            controller: _usernameController,
            size: widget.size,
            isInError:
                form.control('username').touched &&
                !form.control('username').valid,
          ),
          errorMessage:
              form.control('username').touched &&
                      !form.control('username').valid
                  ? widget.additionalData['error_username_required'] ?? ''
                  : null,
        ),
        SFMainButton(
          focusNode: _buttonNode,
          label: widget.additionalData['save_button'] ?? '',
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
