// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_design_system/foundations/models/profile_model.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

class SFProfileView extends ConsumerStatefulWidget {
  final ProfileFormData additionalData;
  final ProfileModel? profileModel;
  final Future Function(ProfileModel) onSubmit;
  final List<Widget> children;

  const SFProfileView({
    super.key,
    required this.additionalData,
    this.profileModel,
    required this.onSubmit,
    this.children = const [],
  });

  @override
  ConsumerState<SFProfileView> createState() => _SFProfileViewState();
}

class _SFProfileViewState extends ConsumerState<SFProfileView>
    with SignalsMixin {
  late final _isLoading = createSignal<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.lg,
      children: [
        SFProfileForm(
          isLoading: _isLoading.value,
          additionalData: widget.additionalData.toMap(),
          profileModel: widget.profileModel,
          onSubmit: (profileData) async {
            final typedValues = ProfileModel.fromMap(profileData);

            _isLoading.value = true;

            await widget.onSubmit(typedValues);

            _isLoading.value = false;
          },
        ),
        if (widget.children.isNotEmpty) ...widget.children,
      ],
    );
  }
}
