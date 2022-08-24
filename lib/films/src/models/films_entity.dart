import 'package:floor/floor.dart';

@Entity(tableName: 'films')
class FilmsEntity {

  @PrimaryKey(autoGenerate: true)
  final int? code;
  final String name;
  final bool isSelected;

  FilmsEntity(this.code, this.name, this.isSelected);
  
}