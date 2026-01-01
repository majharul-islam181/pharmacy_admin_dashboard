
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class ProductImage {
  final String name;
  final Uint8List bytes;

  ProductImage({required this.name, required this.bytes});
}

class ProductImagesProvider extends ChangeNotifier {
  final List<ProductImage> _images = [];
  bool _isDropHovered = false;

  List<ProductImage> get images => List.unmodifiable(_images);
  bool get isDropHovered => _isDropHovered;

  void setHover(bool value) {
    if (_isDropHovered == value) return;
    _isDropHovered = value;
    notifyListeners();
  }

  void removeAt(int index) {
    if (index < 0 || index >= _images.length) return;
    _images.removeAt(index);
    notifyListeners();
  }

  Future<void> pickImages(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );

      if (result == null) return;

      _images
        ..clear()
        ..addAll(
          result.files.where((file) => file.bytes != null).map(
                (file) => ProductImage(
                  name: file.name,
                  bytes: file.bytes!,
                ),
              ),
        );
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Image picker is not available on this platform: $e',
          ),
        ),
      );
    }
  }

  Future<void> handleDropFiles(
    BuildContext context,
    List<DropzoneFileInterface> files,
    DropzoneViewController? controller,
  ) async {
    if (!kIsWeb || controller == null) return;

    final List<ProductImage> dropped = [];

    for (final file in files) {
      final mime = await controller.getFileMIME(file);
      if (!mime.startsWith('image/')) continue;

      final name = await controller.getFilename(file);
      final data = await controller.getFileData(file);
      dropped.add(ProductImage(name: name, bytes: data));
    }

    if (dropped.isEmpty) return;

    _isDropHovered = false;
    _images
      ..clear()
      ..addAll(dropped);
    notifyListeners();
  }
}
