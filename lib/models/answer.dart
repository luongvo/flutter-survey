import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final String id;
  final String text;
  final int displayOrder;
  final String displayType;

  Answer({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.displayType,
  });

  @override
  List<Object?> get props => [id, text, displayOrder, displayType];
}
