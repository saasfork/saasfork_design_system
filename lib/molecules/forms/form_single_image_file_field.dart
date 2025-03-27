import 'package:flutter/material.dart';
import 'package:saasfork_core/models/image_value.dart';
import 'package:saasfork_design_system/atoms/forms/form_message.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_source.dart';

class SFFormSingleImageFilefield extends StatelessWidget {
  final Widget input;
  final String? hintMessage;
  final String? errorMessage;
  final bool isRequired;
  final ImageValue? imageSource;
  final double imageSize;
  final ComponentSize radius;
  final VoidCallback? onImageRemoved;

  const SFFormSingleImageFilefield({
    super.key,
    required this.input,
    this.hintMessage,
    this.errorMessage,
    this.isRequired = false,
    this.imageSource,
    this.imageSize = 80,
    this.radius = ComponentSize.md,
    this.onImageRemoved,
  });

  Widget _buildImageWidget() {
    ImageSource? source;

    if (imageSource != null && imageSource!.isValid) {
      if (imageSource!.file != null) {
        source = XFileImageSource(imageSource!.file!);
      } else if (imageSource!.url != null) {
        source = UrlImageSource(imageSource!.url!);
      }
    }

    final imageWidget = ImageSquare(
      imageSource: source,
      size: imageSize,
      radius: radius,
    );

    return imageSource != null && imageSource!.isValid && onImageRemoved != null
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
