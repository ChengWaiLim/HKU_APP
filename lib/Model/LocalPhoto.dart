import 'package:hive/hive.dart';
import 'package:hku_app/Util/BaseDataBase.dart';
import 'package:hku_app/Util/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LocalPhoto.g.dart';
@JsonSerializable()
@HiveType(typeId: 9)
class LocalPhoto extends BaseModel {
  @HiveField(0)
  int ID;
  @HiveField(1)
  String type;
  @HiveField(2)
  List<String> photoList;
  @HiveField(3)
  int orderID;
  @HiveField(4)
  String ref_no;

  @override
  int getID() => this.ID;

  LocalPhoto({int this.ID,
    String this.type,
    List<String> this.photoList,
    int this.orderID,
    String this.ref_no,
  }) {}

  static int getHighestID(){
    int number = 0;
    BaseDataBase().getAll<LocalPhoto>().forEach((e){
      if(number <= e.ID)
        number = e.ID;
    });
    return number + 1;
  }

  factory LocalPhoto.fromJson(Map<String, dynamic> json) => _$LocalPhotoFromJson(json);
  Map<String, dynamic> toJson() => _$LocalPhotoToJson(this);
}
