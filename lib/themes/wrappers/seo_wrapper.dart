import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_core/saasfork_core.dart';

// Import conditionnel
import 'package:saasfork_design_system/themes/wrappers/helpers/seo_helper.dart'
    if (dart.library.html) 'package:saasfork_design_system/utils/helpers/seo_helper_web.dart';

class SFSeoWrapper extends StatefulWidget {
  final Widget child;
  final SFSEOModel? seoModel;

  const SFSeoWrapper({super.key, required this.child, this.seoModel});

  @override
  State<SFSeoWrapper> createState() => _SFSeoWrapperState();
}

class _SFSeoWrapperState extends State<SFSeoWrapper> {
  @override
  void initState() {
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Utilise l'interface SEOHelper qui sera résolue conditionnellement
        SEOHelper.setMetadata(
          title: widget.seoModel?.title ?? '',
          description: widget.seoModel?.description ?? '',
          keywords: widget.seoModel?.keywords ?? [],
          imageUrl: widget.seoModel?.imageUrl ?? '',
          url: widget.seoModel?.url ?? '',
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
