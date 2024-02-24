
import 'package:json_annotation/json_annotation.dart';

part 'dustbin_model.g.dart';

@JsonSerializable()

class DustbinModel {
  String dustbin_name;
  String category_name;
  double total_capacity;
  double current_capacity;
  int current_depth;
  int dustbin_status;
  int id;
  DateTime created_at;


  DustbinModel(
      { required this.id,
        required this.created_at,
        required this.current_capacity,
        required this.category_name,
        required this.current_depth,
        required this.dustbin_name,
        required this.dustbin_status,
        required this.total_capacity,
      });
  factory DustbinModel.fromJson(Map<String, dynamic> json) => _$DustbinModelFromJson(json);
  Map<String, dynamic> toJson() => _$DustbinModelToJson(this);

}
List<DustbinModel> dustbinList=[
  // DustbinModel(battery: '20', capacity: '40', avgWeight: '5.5', dustBinName: 'Front Door', status: 1, dustbinId: "324"),
  // DustbinModel(battery: '20', capacity: '40', avgWeight: '5.5', dustBinName: 'Back Door', status: 0, dustbinId: "324")

];