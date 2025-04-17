import 'package:flutter/material.dart';
import 'package:flutter_seo/flutter_seo.dart';
import 'package:saasfork_core/saasfork_core.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HeadTagUtil.setTitle(widget.seoModel?.title ?? '');
      HeadTagUtil.setHead(
        title: widget.seoModel?.title ?? '',
        description: widget.seoModel?.description ?? '',
        keywords: widget.seoModel?.keywords ?? [],
        imageUrl: widget.seoModel?.imageUrl ?? '',
        url: widget.seoModel?.url ?? '',
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
