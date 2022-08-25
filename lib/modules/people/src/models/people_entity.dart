import 'package:floor/floor.dart';

@Entity(tableName: 'people')
class PeopleEntity {

  @PrimaryKey(autoGenerate: true)
  final int? code;
  final String name;
  final bool isSelected;

  PeopleEntity(this.code, this.name, this.isSelected);
  
}