import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_core/saasfork_core.dart';
import 'package:saasfork_design_system/themes/layouts/layout_builder.dart';
import 'package:saasfork_design_system/themes/wrappers/notification_wrapper.dart';
import 'package:saasfork_design_system/themes/wrappers/seo_wrapper.dart';

class SFDefaultLayout extends ConsumerWidget {
  final SFLayoutBuilder builder;
  final EdgeInsets contentPadding;
  final SFSEOModel? seoModel;

  const SFDefaultLayout({
    required this.builder,
    this.seoModel,
    this.contentPadding = const EdgeInsets.all(16.0),
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationWrapper(child: _buildExtendedLayout(context, ref));
  }

  Widget _buildExtendedLayout(BuildContext context, WidgetRef ref) {
    Widget layout = Scaffold(
      appBar:
          builder.headerBuilder != null
              ? PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: builder.headerBuilder!(context, ref),
              )
              : null,
      drawer:
          builder.drawerBuilder != null
              ? Drawer(child: builder.drawerBuilder!(context, ref))
              : null,

      body: Stack(
        fit: StackFit.expand,
        children: [
          builder.contentBuilder(context, ref),

          if (builder.footerBuilder != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: builder.footerBuilder!(context, ref),
            ),
        ],
      ),
    );

    return SFSeoWrapper(seoModel: seoModel, child: layout);
  }
}
