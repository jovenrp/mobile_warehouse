import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_model.dart';

import 'pack_tickets_model.dart';

part 'pack_tickets_response.g.dart';

@JsonSerializable()
class PackTicketsResponse {
  const PackTicketsResponse({
    this.error,
    this.message,
    this.packTicketsModel,
  });

  factory PackTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$PackTicketsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PackTicketsResponseToJson(this);

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'getReceiveTickets')
  final List<PackTicketsModel>? packTicketsModel;
}
