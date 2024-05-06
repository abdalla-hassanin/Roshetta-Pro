
import 'package:roshetta_pro/features/patient/domain/entities/drug_entity.dart';

class DrugModel extends DrugEntity {
  DrugModel({
    required super.drugName,
    required super.drugQty,
    required super.drugType,
    required super.durationOfUse,
    required super.timeOfUse,
    required super.note,
  });


  factory DrugModel.fromMap(Map<String, dynamic> map) {
    return DrugModel(
      drugName: map['drugName'] ,
      drugQty: map['drugQty'] ,
      drugType: map['drugType'] ,
      durationOfUse: map['durationOfUse'] ,
      timeOfUse: map['timeOfUse'] ,
      note: map['note'] ,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'drugName': drugName,
      'drugQty': drugQty,
      'drugType': drugType,
      'durationOfUse': durationOfUse,
      'timeOfUse': timeOfUse,
      'note': note,
    };
  }

}
