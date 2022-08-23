import 'package:floor/floor.dart';

@Entity(tableName: 'favorite')
class FavoriteEntity {

  @PrimaryKey(autoGenerate: true)
  final int? code;
  final String name;
  final bool isSelected;
  final int identificationCode;

  FavoriteEntity(this.code, this.name, this.isSelected,this.identificationCode);
  
}
