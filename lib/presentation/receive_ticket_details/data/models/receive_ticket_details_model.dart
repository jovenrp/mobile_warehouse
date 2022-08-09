import 'package:json_annotation/json_annotation.dart';

part 'receive_ticket_details_model.g.dart';

@JsonSerializable()
class ReceiveTicketDetailsModel {
  ReceiveTicketDetailsModel(
      {this.id,
      this.lineNum,
      this.status,
      this.containerId,
      this.containerCode,
      this.itemId,
      this.sku,
      this.itemNum,
      this.itemName,
      this.userId,
      this.loginName,
      this.fullName,
      this.lotNum,
      this.isLotTracked,
      this.isComplete,
      this.isUnder,
      this.isOver,
      this.qtyReceived,
      this.qtyOrder,
      this.uom,
      this.qtyUnit,
      this.isChecked = false,
      this.isFiltered = false,
      this.isVisible = false,
      this.pickedItem});

  factory ReceiveTicketDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiveTicketDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiveTicketDetailsModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'lineNum')
  final String? lineNum;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'containerId')
  final String? containerId;

  @JsonKey(name: 'containerCode')
  final String? containerCode;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'itemNum')
  final String? itemNum;

  @JsonKey(name: 'itemName')
  final String? itemName;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'loginName')
  final String? loginName;

  @JsonKey(name: 'fullName')
  final String? fullName;

  @JsonKey(name: 'lotNum')
  final String? lotNum;

  @JsonKey(name: 'isLotTracked')
  final String? isLotTracked;

  @JsonKey(name: 'isComplete')
  String? isComplete;

  @JsonKey(name: 'isUnder')
  String? isUnder;

  @JsonKey(name: 'isOver')
  String? isOver;

  @JsonKey(name: 'qtyRcvd')
  String? qtyReceived;

  @JsonKey(name: 'qtyOrd')
  final String? qtyOrder;

  @JsonKey(name: 'uom')
  final String? uom;

  @JsonKey(name: 'qtyUnit')
  final String? qtyUnit;

  @JsonKey(name: 'isChecked', defaultValue: false)
  bool? isChecked;

  @JsonKey(name: 'isFiltered', defaultValue: false)
  bool? isFiltered;

  @JsonKey(name: 'isVisible', defaultValue: false)
  bool? isVisible;

  @JsonKey(name: 'pickedItem')
  String? pickedItem;

  bool setIsChecked(bool value) {
    isChecked = value;
    return isChecked ?? false;
  }

  bool setIsFiltered(bool value) {
    isFiltered = value;
    return isFiltered ?? false;
  }

  bool setIsVisible(bool value) {
    isVisible = value;
    return isVisible ?? false;
  }

  void setPickedItem(String? value) {
    qtyReceived = value;
  }

  void setQtyPicked(String? value) {
    qtyReceived = value;
  }

  void setStatus(String? value) {
    status = value;
  }

  void setIsOver(String? value) {
    isOver = value;
  }

  void setIsUnder(String? value) {
    isUnder = value;
  }

  void setIsComplete(String? value) {
    isComplete = value;
  }
}
