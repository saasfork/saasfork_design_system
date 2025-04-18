import 'package:flutter_seo/flutter_seo.dart';

class SEOHelper {
  static void setMetadata({
    String title = '',
    String description = '',
    List<String> keywords = const [],
    String imageUrl = '',
    String url = '',
  }) {
    HeadTagUtil.setTitle(title);
    HeadTagUtil.setHead(
      title: title,
      description: description,
      keywords: keywords,
      imageUrl: imageUrl,
      url: url,
    );
  }
}
