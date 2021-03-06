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

part 'Dangerous_Goods_Order.g.dart';
@JsonSerializable()
@HiveType(typeId: 2)
class Dangerous_Goods_Order extends BaseModel with OrderInterface {
  @HiveField(0)
  int ID;
  @HiveField(1)
  String department_code;
  @HiveField(2)
  String department_name;
  @HiveField(3)
  String ac_name;
  @HiveField(4)
  int ID_department;
  @HiveField(5)
  int hospital_price;
  @HiveField(6)
  String ref_no;
  @HiveField(7)
  @JsonKey(fromJson: BaseModel.fromJsonDateTime, toJson: BaseModel.toJsonDateTime)
  DateTime po_date;
  @HiveField(8)
  String requested_by;
  @HiveField(9)
  String telephone_no;
  @HiveField(10)
  int ID_account;
  @HiveField(11)
  String ac_no;
  @HiveField(12)
  String user;
  @HiveField(13)
  String building;
  @HiveField(14)
  String issued_by;
  @HiveField(15)
  int voucher;
  @HiveField(16)
  String remarks;
  @HiveField(17)
  int status;
  @HiveField(18)
  String dn_file;


  Dangerous_Goods_Order(
      {int this.ID,
      String this.department_code,
      String this.department_name,
      String this.ac_name,
      int this.ID_department,
      int this.hospital_price,
      String this.ref_no,
      DateTime this.po_date,
      String this.requested_by,
      String this.telephone_no,
      int this.ID_account,
      String this.ac_no,
      String this.user,
      String this.building,
      String this.issued_by,
      int this.voucher,
      String this.remarks,
      int this.status,
      String this.dn_file}) {}
  @override
  int getID() => this.ID;

  @override
  String getBuilding() => this.building;

  @override
  String getDepartmentName() => this.department_name;

  @override
  String getRefNo() => this.ref_no;
  
  @override
  DeliveryType getType() => DeliveryType.DangerousGoods;

  @override
  String getAccountNumber() => this.ac_no;

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
      LocalPhoto localPhoto = new LocalPhoto(ID: LocalPhoto.getHighestID(), ref_no: this.getRefNo(), photoList:  [null, null, null], orderID: this.ID, type: DeliveryType.DangerousGoods.value);
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
      await localPhoto.save();
    }catch(e){
      print(e);
    }
  }

  @override
  Future<void> deleteLocalPhoto() async{
    LocalPhoto localPhoto = BaseDataBase().getAll<LocalPhoto>().firstWhere((element) => element.ref_no == this.getRefNo());
    await BaseDataBase().delete<LocalPhoto>(localPhoto);
  }

  factory Dangerous_Goods_Order.fromJson(Map<String, dynamic> json) => _$Dangerous_Goods_OrderFromJson(json);
  Map<String, dynamic> toJson() => _$Dangerous_Goods_OrderToJson(this);
}
