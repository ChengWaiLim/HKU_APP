import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hku_app/Enums/DeliveryType.dart';
import 'package:hku_app/Model/LocalPhoto.dart';
import 'package:hku_app/Model/OrderInterface.dart';
import 'package:hku_app/Util/BaseDataBase.dart';
import 'package:hku_app/Util/BaseModel.dart';
import 'package:hku_app/Util/Global.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Chemical_Waste_Order.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class Chemical_Waste_Order extends BaseModel with OrderInterface{
  @HiveField(0)
  int ID;
  @HiveField(1)
  int ID_department;
  @HiveField(2)
  String department_code;
  @HiveField(3)
  String department_name;
  @HiveField(4)
  String ref_no;
  @HiveField(5)
  String location;
  @HiveField(6)
  @JsonKey(fromJson: BaseModel.fromJsonDateTime, toJson: BaseModel.toJsonDateTime)
  DateTime po_date;
  @HiveField(7)
  String requested_by;
  @HiveField(8)
  String name_one;
  @HiveField(9)
  String name_two;
  @HiveField(10)
  String telephone_no;
  @HiveField(11)
  String remarks;
  @HiveField(12)
  int status;
  @HiveField(13)
  String dn_file;

  Chemical_Waste_Order(
      {int this.ID,
      int this.ID_department,
      String this.department_code,
      String this.department_name,
      String this.ref_no,
      String this.location,
      DateTime this.po_date,
      String this.requested_by,
      String this.name_one,
      String this.name_two,
      String this.telephone_no,
      String this.remarks,
      int this.status,
      String this.dn_file}) {}

  @override
  int getID() => this.ID;

  @override
  String getBuilding() => this.location;

  @override
  String getDepartmentName() => this.department_name;

  @override
  String getRefNo()  => this.ref_no;

  @override
  DeliveryType getType() => DeliveryType.ChemicalWaste;

  @override
  String getAccountNumber()=> "";

  @override
  String getDepartmentCode() => this.department_code;

  @override
  DateTime getPODate() => this.po_date;

  @override
  String getRequestedBy() => this.requested_by;

  @override
  String getTelephone() => this.telephone_no;

  @override
  Future<List<File>> getDNLocal() async {
    try{
      List<String> stringList = BaseDataBase().getAll<LocalPhoto>().firstWhere((element) => element.ref_no == this.getRefNo()).photoList;
      List<File> result = [];
      for(int i = 0; i < stringList.length; i++){
        if(stringList[i] != null)
          result.add(await Global.createFileFromString(stringList[i], "jpg"));
        else
          result.add(null);
      }
      return result;
    }catch(e){
      LocalPhoto localPhoto = new LocalPhoto(ID: LocalPhoto.getHighestID(), ref_no: this.getRefNo(), photoList:  [null, null, null], orderID: this.ID, type: DeliveryType.ChemicalWaste.value);
      await BaseDataBase().add<LocalPhoto>(localPhoto);
      List<File> result = [];
      for(int i = 0; i < localPhoto.photoList.length; i++){
        result.add(await Global.createFileFromString(localPhoto.photoList[i], "jpg"));
      }
      return result;
    }
  }

  @override
  Future<void> updatePhotoList(List<File> fileList) async{
    try{
      LocalPhoto localPhoto = BaseDataBase().getAll<LocalPhoto>().firstWhere((element) => element.ref_no == this.getRefNo());
      localPhoto.photoList = fileList.map((e){
        if(e == null)
          return null;
        return base64.encode(e.readAsBytesSync());
      }).toList();
      await BaseDataBase().save(localPhoto);
    }catch(e){
      print(e);
    }
  }

  @override
  Future<void> deleteLocalPhoto() async{
    LocalPhoto localPhoto = BaseDataBase().getAll<LocalPhoto>().firstWhere((element) => element.ref_no == this.getRefNo());
    await BaseDataBase().delete<LocalPhoto>(localPhoto);
  }

  factory Chemical_Waste_Order.fromJson(Map<String, dynamic> json) => _$Chemical_Waste_OrderFromJson(json);
  Map<String, dynamic> toJson() => _$Chemical_Waste_OrderToJson(this);
}
