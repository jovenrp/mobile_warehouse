import 'package:json_annotation/json_annotation.dart';

part 'pick_tickets_details_model.g.dart';

@JsonSerializable()
class PickTicketDetailsModel {
  PickTicketDetailsModel({
    this.id,
    this.pickTicketId,
    this.lineNum,
    this.num,
    this.seq,
    this.itemId,
    this.sku,
    this.description,
    this.qtyOrd,
    this.uom,
    this.unitQty,
    this.qtyPick,
    this.qtyPicked,
    this.location,
    this.locId,
    this.locCode,
    this.note,
    this.complete,
    this.partial,
    this.status,
    this.createdTime,
    this.modifiedTime,
    this.isChecked = false,
    this.isFiltered = false,
    this.isVisible = false,
    this.pickedItem,
  });

  factory PickTicketDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PickTicketDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PickTicketDetailsModelToJson(this);

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'pickTicketId')
  final String? pickTicketId;

  @JsonKey(name: 'lineNum')
  final String? lineNum;

  @JsonKey(name: 'num')
  final String? num;

  @JsonKey(name: 'seq')
  final String? seq;

  @JsonKey(name: 'itemId')
  final String? itemId;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'qtyOrd')
  final String? qtyOrd;

  @JsonKey(name: 'uom')
  final String? uom;

  @JsonKey(name: 'unitQty')
  final String? unitQty;

  @JsonKey(name: 'qtyPick')
  String? qtyPick;

  @JsonKey(name: 'qtyPicked')
  String? qtyPicked;

  @JsonKey(name: 'location')
  String? location;

  @JsonKey(name: 'locId')
  final String? locId;

  @JsonKey(name: 'locCode')
  final String? locCode;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'complete')
  final String? complete;

  @JsonKey(name: 'partial')
  final String? partial;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'createdTime')
  final String? createdTime;

  @JsonKey(name: 'modifiedTime')
  final String? modifiedTime;

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
    pickedItem = value;
  }

  void setQtyPicked(String? value) {
    qtyPicked = value;
  }

  void setQtyPick(String? value) {
    qtyPick = value;
  }

  void setLocation(String? value) {
    location = value;
  }

  void setStatus(String? value) {
    status = value;
  }
}
