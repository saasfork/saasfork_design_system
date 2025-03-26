import 'package:file_picker/file_picker.dart';

enum ExpectedFileType {
  imageJpeg('image/jpeg', ['jpg', 'jpeg'], FileType.image),
  imagePng('image/png', ['png'], FileType.image),
  imageGif('image/gif', ['gif'], FileType.image);

  final String mimeType;
  final List<String> extensions;
  final FileType fileType;

  const ExpectedFileType(this.mimeType, this.extensions, this.fileType);

  bool matchesMimeType(String fileMimeType) {
    return fileMimeType == mimeType;
  }

  String get description {
    switch (this) {
      case ExpectedFileType.imageJpeg:
        return 'JPEG';
      case ExpectedFileType.imagePng:
        return 'PNG';
      case ExpectedFileType.imageGif:
        return 'GIF';
    }
  }
}
