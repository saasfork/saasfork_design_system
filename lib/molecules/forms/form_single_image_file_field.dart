import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/forms/form_message.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_source.dart';

class SFFormSingleImageFilefield extends StatelessWidget {
  final Widget input;
  final String? hintMessage;
  final String? errorMessage;
  final bool isRequired;
  final XFile? imageFile;
  final double imageSize;
  final ComponentSize radius;
  final VoidCallback? onImageRemoved;

  const SFFormSingleImageFilefield({
    super.key,
    required this.input,
    this.hintMessage,
    this.errorMessage,
    this.isRequired = false,
    this.imageFile,
    this.imageSize = 80,
    this.radius = ComponentSize.md,
    this.onImageRemoved,
  });

  Widget _buildImageWidget() {
    final imageWidget = ImageSquare(
      imageFile: imageFile != null ? XFileImageSource(imageFile) : null,
      size: imageSize,
      radius: radius,
    );

    return imageFile != null && onImageRemoved != null
        ? RemovableContent(
          onPress: onImageRemoved,
          buttonColor: AppColors.red.s400,
          child: imageWidget,
        )
        : imageWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xl,
      children: [
        _buildImageWidget(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.sm,
          children: [
            input,
            SFFormMessage(
              errorMessage: errorMessage,
              hintMessage: isRequired ? "$hintMessage *" : hintMessage,
            ),
          ],
        ),
      ],
    );
  }
}
