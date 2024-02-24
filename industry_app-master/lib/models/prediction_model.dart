import 'package:json_annotation/json_annotation.dart';
part 'prediction_model.g.dart';
@JsonSerializable()
class PredictionModel {
  DateTime date;
  double predicted_weight;
  List<int> selected_dustbin_ids;
  List<int> selected_producers;
  List<String> selected_categories_name;

  PredictionModel(
      {required this.predicted_weight,
      required this.date,
      required this.selected_categories_name,
      required this.selected_dustbin_ids,
      required this.selected_producers});

  factory PredictionModel.fromJson(Map<String, dynamic> json) => _$PredictionModelFromJson(json);
}
