// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/models/profile_model.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFProfileView extends StatelessWidget {
  final ProfileFormData additionalData;
  final ProfileModel? profileModel;
  final Function(ProfileModel) onSubmit;
  final List<Widget> children;

  const SFProfileView({
    super.key,
    required this.additionalData,
    this.profileModel,
    required this.onSubmit,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.lg,
      children: [
        SFProfileForm(
          additionalData: additionalData.toMap(),
          profileModel: profileModel,
          onSubmit: (profileData) {
            final typedValues = ProfileModel.fromMap(profileData);
            onSubmit(typedValues);
          },
        ),
        if (children.isNotEmpty) ...children,
      ],
    );
  }
}
