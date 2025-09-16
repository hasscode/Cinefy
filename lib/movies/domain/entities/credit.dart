import 'package:equatable/equatable.dart';

class Credit extends Equatable {
  final String originalName;
  final String character;
   String? profileImage;
   Credit({required this.character, required this.originalName,  required this.profileImage});
  @override
  List<Object?> get props => [originalName, profileImage, character];
}
