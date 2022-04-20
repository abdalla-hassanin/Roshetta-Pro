class DrugModel {
  DrugModel({
    required this.drugName,
    required this.drugQty,
    required this.drugType,
    required this.durationOfUse,
    required this.timeOfUse,
    required this.note,
  });
  late final String drugName;
  late final String drugQty;
  late final String drugType;
  late final String durationOfUse;
  late final String timeOfUse;
  late final String note;

  DrugModel.fromJson(Map<String, dynamic> json){
    drugName = json['drugName'];
    drugQty = json['drugQty'];
    drugType = json['drugType'];
    durationOfUse = json['durationOfUse'];
    timeOfUse = json['timeOfUse'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['drugName'] = drugName;
    _data['drugQty'] = drugQty;
    _data['drugType'] = drugType;
    _data['durationOfUse'] = durationOfUse;
    _data['timeOfUse'] = timeOfUse;
    _data['note'] = note;
    return _data;
  }
}
