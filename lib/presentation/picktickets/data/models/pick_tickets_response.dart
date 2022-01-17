import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';

part 'pick_tickets_response.g.dart';

@JsonSerializable()
class PickTicketsResponse {
  const PickTicketsResponse({
    this.pickTickets,
  });

  factory PickTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$PickTicketsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PickTicketsResponseToJson(this);

  @JsonKey(name: 'pickTickets')
  final List<PickTicketsItemModel>? pickTickets;
}
