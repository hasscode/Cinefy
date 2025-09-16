import 'package:movie_app/movies/domain/entities/credit.dart';

class CreditModel extends Credit {
  CreditModel({required super.character, required super.originalName, required super.profileImage});


 factory CreditModel.fromJson(Map<String, dynamic> json) {
   return CreditModel(
profileImage: json['profile_path'],
     originalName: json['original_name'],
     character: json['character']
   );
 }
}
