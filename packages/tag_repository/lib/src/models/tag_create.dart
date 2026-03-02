import 'package:tag_remote/tag_remote.dart';

class TagCreate {
  TagCreate({required this.label, required this.color, required this.type});

  TagCreateDto toDto() => TagCreateDto(label: label, color: color, type: type);

  final String label;
  final TagColor color;
  final TagType type;
}
