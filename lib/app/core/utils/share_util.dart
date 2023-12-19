import 'package:logging/logging.dart';
import 'package:share_plus/share_plus.dart';

abstract interface class ShareUtil {
  Future<void> shareText(String text, {String? subject});

  Future<void> shareFile(
    String filePath, {
    String? text,
    String? subject,
    String? mimeType,
  });

  Future<void> shareImage(
    String imagePath, {
    String? text,
    String? subject,
    String? mimeType,
  });

  Future<void> shareUrl(
    String url, {
    String? subject,
  });

  Future<void> shareMultiple(
    List<String> paths, {
    String? text,
    String? subject,
    String? mimeType,
  });
}

class DefaultShareUtil implements ShareUtil {
  final logger = Logger('ShareUtil');

  @override
  Future<void> shareText(
    String text, {
    String? subject,
  }) async {
    try {
      await Share.share(text, subject: subject);
    } catch (e) {
      logger.severe('Error sharing text: $e');
    }
  }

  @override
  Future<void> shareFile(
    String filePath, {
    String? text,
    String? subject,
    String? mimeType,
  }) async {
    try {
      XFile file = XFile(filePath, mimeType: mimeType);

      await Share.shareXFiles(
        [file],
        text: text,
        subject: subject,
      );
    } catch (e) {
      logger.severe('Error sharing file: $e');
    }
  }

  @override
  Future<void> shareImage(
    String imagePath, {
    String? text,
    String? subject,
    String? mimeType,
  }) async {
    try {
      XFile imageFile = XFile(imagePath, mimeType: mimeType);
      await Share.shareXFiles(
        [imageFile],
        text: text,
        subject: subject,
      );
    } catch (e) {
      logger.severe('Error sharing image: $e');
    }
  }

  @override
  Future<void> shareUrl(
    String url, {
    String? subject,
  }) async {
    try {
      await Share.share(url, subject: subject);
    } catch (e) {
      logger.severe('Error sharing URL: $e');
    }
  }

  @override
  Future<void> shareMultiple(
    List<String> paths, {
    String? text,
    String? subject,
    String? mimeType,
  }) async {
    List<XFile> files = paths.map((e) => XFile(e)).toList();
    try {
      await Share.shareXFiles(
        files,
        text: text,
        subject: subject,
      );
    } catch (e) {
      logger.severe('Error sharing multiple files: $e');
    }
  }
}
