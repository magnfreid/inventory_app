import 'package:tag_remote/tag_remote.dart';

class TagCreate {
  TagCreate({required this.label, required this.color});

  TagCreateDto toDto() => TagCreateDto(label: label, color: color);

  final String label;
  final TagColor color;
}
