import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';

class ImagePickerSheet extends StatelessWidget {
  const ImagePickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(8, 0, 8, 50),
      child: Column(
        mainAxisSize: .min,
        children: [
          ListTile(
            title: const Text('Choose from gallery'),
            trailing: const Icon(Icons.photo),
            onTap: () => _pickImage(
              context: context,
              source: .gallery,
              onImageSelected: (imgPath) {
                context.read<PartDetailsBloc>().add(
                  ImageSelected(deviceImgPath: imgPath),
                );
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: const Text('Take photo'),
            trailing: const Icon(Icons.camera_alt),
            onTap: () => _pickImage(
              context: context,
              source: .camera,
              onImageSelected: (imgPath) {
                context.read<PartDetailsBloc>().add(
                  ImageSelected(deviceImgPath: imgPath),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage({
    required BuildContext context,
    required ImageSource source,
    required void Function(String imgPath) onImageSelected,
  }) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (file == null) return;
    onImageSelected(file.path);
  }
}
