import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../view_model/product_images_provider.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  DropzoneViewController? _dropzoneController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Navigate back to product main page
                  },
                  child: const Text('Products'),
                ),
                const Text(' > '),
                const Text(
                  'Add Product',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            const Text(
              'Add New Product',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 32,
                        color: Color(0xFF3B82F6),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildFormField('Product Name', 'Enter product name'),
                  const SizedBox(height: 16),
                  _buildFormField('Category', 'Select category'),
                  const SizedBox(height: 16),
                  _buildFormField('SKU', 'Enter SKU'),
                  const SizedBox(height: 16),
                  _buildFormField('Unit Price', 'Enter unit price'),
                  const SizedBox(height: 16),
                  _buildFormField('Stock Quantity', 'Enter available quantity'),
                  const SizedBox(height: 16),
                  _buildImagePickerSection(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final imagesProvider =
                              context.read<ProductImagesProvider>();
                          if (imagesProvider.images.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please upload at least one product image.',
                                ),
                              ),
                            );
                            return;
                          }

                          // TODO: Save product with images
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Save Product',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Reset form / navigate back
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePickerSection() {
    final imagesProvider = context.watch<ProductImagesProvider>();
    final images = imagesProvider.images;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Images *',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            if (kIsWeb)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: false,
                  child: DropzoneView(
                    operation: DragOperation.copy,
                    cursor: CursorType.grab,
                    onCreated: (ctrl) => _dropzoneController = ctrl,
                    onHover: () {
                      imagesProvider.setHover(true);
                    },
                    onLeave: () {
                      imagesProvider.setHover(false);
                    },
                    onDropFiles: (files) {
                      if (files == null) return;
                      imagesProvider.handleDropFiles(
                        context,
                        files,
                        _dropzoneController,
                      );
                    },
                    onError: (String? ev) {
                      if (!mounted || ev == null) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Drag & drop error: $ev')),
                      );
                    },
                  ),
                ),
              ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: imagesProvider.isDropHovered
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFFD1D5DB),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<ProductImagesProvider>()
                              .pickImages(context);
                        },
                        icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                        label: const Text('Upload Images'),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          kIsWeb
                              ? 'Click to upload or drag & drop one or multiple images (PNG, JPG, JPEG).'
                              : 'Upload one or multiple images (PNG, JPG, JPEG).',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (images.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: images.asMap().entries.map((entry) {
                        final index = entry.key;
                        final image = entry.value;
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                image.bytes,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: -6,
                              right: -6,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<ProductImagesProvider>()
                                      .removeAt(index);
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
