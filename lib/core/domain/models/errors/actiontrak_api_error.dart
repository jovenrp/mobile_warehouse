import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_warehouse/generated/i18n.dart';

import 'api_error_data.dto.dart';

part 'actiontrak_api_error.g.dart';

@JsonSerializable()
class ActionTRAKApiError {
  const ActionTRAKApiError({
    required this.code,
    required this.message,
    required this.parameter,
    this.data,
  });

  const ActionTRAKApiError.unknown()
      : code = ActionTRAKApiErrorCode.api000,
        message = 'Unknown error',
        parameter = '',
        data = null;

  factory ActionTRAKApiError.fromJson(Map<String, dynamic> json) =>
      _$ActionTRAKApiErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ActionTRAKApiErrorToJson(this);

  @JsonKey(name: 'code')
  final ActionTRAKApiErrorCode? code;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'parameter')
  final String? parameter;

  @JsonKey(name: 'data')
  final ApiErrorDataDto? data;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActionTRAKApiError &&
        other.code == code &&
        other.message == message &&
        other.parameter == parameter &&
        other.data == data;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        message.hashCode ^
        parameter.hashCode ^
        data.hashCode;
  }
}

enum ActionTRAKApiErrorCode {
  /// Add Documentation for this error (when it happens)
  @JsonValue('API000')
  api000,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API001')
  api001,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API002')
  api002,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API003')
  api003,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API004')
  api004,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API005')
  api005,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API006')
  api006,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API007')
  api007,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API008')
  api008,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API009')
  api009,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API010')
  api010,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API011')
  api011,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API012')
  api012,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API013')
  api013,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API014')
  api014,

  /// Add Documentation for this error (when it happens)
  /// message: Service Number not found, parameter: serviceNumber
  @JsonValue('API015')
  api015,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API016')
  api016,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API017')
  api017,

  /// 'Service Number is unverified, parameter: unverified'
  @JsonValue('API018')
  api018,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API019')
  api019,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API020')
  api020,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API021')
  api021,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API022')
  api022,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API023')
  api023,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API024')
  api024,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API025')
  api025,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API026')
  api026,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API027')
  api027,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API028')
  api028,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API029')
  api029,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API030')
  api030,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API031')
  api031,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API032')
  api032,

  /// message: Contains non-numeric characters, parameter: serviceNumber}
  @JsonValue('API033')
  api033,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API034')
  api034,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API035')
  api035,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API036')
  api036,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API037')
  api037,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API038')
  api038,

  /// message: Expired verification code, parameter: otpCode
  @JsonValue('API039')
  api039,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API040')
  api040,

  /// Add Documentation for this error (when it happens)
  /// message: Invalid verification code, parameter: otpCode
  @JsonValue('API041')
  api041,

  /// message: Blocked account, parameter: pin
  /// {timeBlock: 5, timesWrongPIN: 3, timeRecovery: 1614143385, unlockDuration: 300000}
  @JsonValue('API042')
  api042,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API043')
  api043,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API044')
  api044,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API045')
  api045,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API046')
  api046,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API047')
  api047,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API048')
  api048,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API049')
  api049,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API050')
  api050,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API051')
  api051,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API052')
  api052,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API053')
  api053,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API054')
  api054,

  /// message: Service Number is updated profile, parameter: updatedProfile
  @JsonValue('API055')
  api055,

  /// message: Service Number is verified, parameter: verified}
  @JsonValue('API056')
  api056,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API057')
  api057,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API058')
  api058,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API059')
  api059,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API060')
  api060,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API061')
  api061,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API062')
  api062,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API063')
  api063,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API064')
  api064,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API065')
  api065,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API066')
  api066,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API067')
  api067,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API068')
  api068,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API069')
  api069,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API070')
  api070,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API071')
  api071,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API072')
  api072,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API073')
  api073,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API074')
  api074,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API075')
  api075,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API076')
  api076,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API077')
  api077,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API078')
  api078,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API079')
  api079,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API080')
  api080,

  /// Add Documentation for this error (when it happens)
  /// message: Service Number is exist, parameter: serviceNumber
  @JsonValue('API081')
  api081,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API082')
  api082,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API083')
  api083,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API084')
  api084,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API085')
  api085,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API086')
  api086,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API087')
  api087,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API088')
  api088,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API089')
  api089,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API090')
  api090,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API091')
  api091,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API092')
  api092,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API093')
  api093,

  /// message: Pin is invalid, parameter: pin
  /// data: {timesWrongPin: 1, timesRemainInputPin: 2}
  @JsonValue('API094')
  api094,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API095')
  api095,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API096')
  api096,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API097')
  api097,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API098')
  api098,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API099')
  api099,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API100')
  api100,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API101')
  api101,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API102')
  api102,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API103')
  api103,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API104')
  api104,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API105')
  api105,

  /// Add Documentation for this error (when it happens)
  /// message: Maximum Input OTP, parameter: otpCode
  @JsonValue('API106')
  api106,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API107')
  api107,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API108')
  api108,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API109')
  api109,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API110')
  api110,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API111')
  api111,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API112')
  api112,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API113')
  api113,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API114')
  api114,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API115')
  api115,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API116')
  api116,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API117')
  api117,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API118')
  api118,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API119')
  api119,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API120')
  api120,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API121')
  api121,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API122')
  api122,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API123')
  api123,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API124')
  api124,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API125')
  api125,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API126')
  api126,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API127')
  api127,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API128')
  api128,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API129')
  api129,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API130')
  api130,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API131')
  api131,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API132')
  api132,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API133')
  api133,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API134')
  api134,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API135')
  api135,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API136')
  api136,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API137')
  api137,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API138')
  api138,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API139')
  api139,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API141')
  api141,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API142')
  api142,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API143')
  api143,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API144')
  api144,

  /// message: "Seem you have changed the Pin. Please login again, thank you"
  @JsonValue('API145')
  api145,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API146')
  api146,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API147')
  api147,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API148')
  api148,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API149')
  api149,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API150')
  api150,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API151')
  api151,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API152')
  api152,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API155')
  api155,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API156')
  api156,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API177')
  api177,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API178')
  api178,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API179')
  api179,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API180')
  api180,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API181')
  api181,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API182')
  api182,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API183')
  api183,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API184')
  api184,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API185')
  api185,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API186')
  api186,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API187')
  api187,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API188')
  api188,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API189')
  api189,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API190')
  api190,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API191')
  api191,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API192')
  api192,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API193')
  api193,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API194')
  api194,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API195')
  api195,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API196')
  api196,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API197')
  api197,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API198')
  api198,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API199')
  api199,

  // Already subscribed to UNLI
  @JsonValue('API202')
  api202,

  /// Event Code is Required
  @JsonValue('API205')
  api205,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API206')
  api206,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API219')
  api219,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API220')
  api220,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API225')
  api225,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API226')
  api226,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API227')
  api227,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API228')
  api228,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API94')
  api94,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API224')
  api224,

  /// Add Documentation for this error (when it happens)
  @JsonValue('API426')
  api426,

  /// Add Documentation for this error (when it happens)
  @JsonValue('CONNECTION_ERROR_ON_AUTO_ACTION')
  connectionErrorOnAutoAction,

  /// Add Documentation for this error (when it happens)
  @JsonValue('CONNECTION_ERROR_ON_DEMAND_ACTION')
  connectionErrorOnDemandAction,

  /// Add Documentation for this error (when it happens)
  @JsonValue('TIMEOUT_ERROR_ON_DEMAND_ACTION')
  timeoutErrorOnDemandAction,

  /// Add Documentation for this error (when it happens)
  @JsonValue('TIMEOUT_ERROR_ON_AUTO_ACTION')
  timeoutErrorOnAutoAction,

  /// Add Documentation for this error (when it happens)
  @JsonValue('LIMITED_CONNECTION_ERROR_ON_DEMAND_ACTION')
  limitedConnectionErrorOnDemandAction,

  /// Add Documentation for this error (when it happens)
  @JsonValue('LIMITED_CONNECTION_ERROR_ON_AUTO_ACTION')
  limitedConnectionErrorOnAutoAction,
}

extension ActionTRAKApiErrorCodeX on ActionTRAKApiErrorCode {
  String? get rawValue => _values[this];

  static final Map<ActionTRAKApiErrorCode, String> _values =
      <ActionTRAKApiErrorCode, String>{
    ActionTRAKApiErrorCode.api000: 'API000',
    ActionTRAKApiErrorCode.api001: 'API001',
    ActionTRAKApiErrorCode.api002: 'API002',
    ActionTRAKApiErrorCode.api003: 'API003',
    ActionTRAKApiErrorCode.api004: 'API004',
    ActionTRAKApiErrorCode.api005: 'API005',
    ActionTRAKApiErrorCode.api006: 'API006',
    ActionTRAKApiErrorCode.api007: 'API007',
    ActionTRAKApiErrorCode.api008: 'API008',
    ActionTRAKApiErrorCode.api009: 'API009',
    ActionTRAKApiErrorCode.api010: 'API010',
    ActionTRAKApiErrorCode.api011: 'API011',
    ActionTRAKApiErrorCode.api012: 'API012',
    ActionTRAKApiErrorCode.api013: 'API013',
    ActionTRAKApiErrorCode.api014: 'API014',
    ActionTRAKApiErrorCode.api015: 'API015',
    ActionTRAKApiErrorCode.api016: 'API016',
    ActionTRAKApiErrorCode.api017: 'API017',
    ActionTRAKApiErrorCode.api018: 'API018',
    ActionTRAKApiErrorCode.api019: 'API019',
    ActionTRAKApiErrorCode.api020: 'API020',
    ActionTRAKApiErrorCode.api021: 'API021',
    ActionTRAKApiErrorCode.api022: 'API022',
    ActionTRAKApiErrorCode.api023: 'API023',
    ActionTRAKApiErrorCode.api024: 'API024',
    ActionTRAKApiErrorCode.api025: 'API025',
    ActionTRAKApiErrorCode.api026: 'API026',
    ActionTRAKApiErrorCode.api027: 'API027',
    ActionTRAKApiErrorCode.api028: 'API028',
    ActionTRAKApiErrorCode.api029: 'API029',
    ActionTRAKApiErrorCode.api030: 'API030',
    ActionTRAKApiErrorCode.api031: 'API031',
    ActionTRAKApiErrorCode.api032: 'API032',
    ActionTRAKApiErrorCode.api033: 'API033',
    ActionTRAKApiErrorCode.api034: 'API034',
    ActionTRAKApiErrorCode.api035: 'API035',
    ActionTRAKApiErrorCode.api036: 'API036',
    ActionTRAKApiErrorCode.api037: 'API037',
    ActionTRAKApiErrorCode.api038: 'API038',
    ActionTRAKApiErrorCode.api039: 'API039',
    ActionTRAKApiErrorCode.api040: 'API040',
    ActionTRAKApiErrorCode.api041: 'API041',
    ActionTRAKApiErrorCode.api042: 'API042',
    ActionTRAKApiErrorCode.api043: 'API043',
    ActionTRAKApiErrorCode.api044: 'API044',
    ActionTRAKApiErrorCode.api045: 'API045',
    ActionTRAKApiErrorCode.api046: 'API046',
    ActionTRAKApiErrorCode.api047: 'API047',
    ActionTRAKApiErrorCode.api048: 'API048',
    ActionTRAKApiErrorCode.api049: 'API049',
    ActionTRAKApiErrorCode.api050: 'API050',
    ActionTRAKApiErrorCode.api051: 'API051',
    ActionTRAKApiErrorCode.api052: 'API052',
    ActionTRAKApiErrorCode.api053: 'API053',
    ActionTRAKApiErrorCode.api054: 'API054',
    ActionTRAKApiErrorCode.api055: 'API055',
    ActionTRAKApiErrorCode.api056: 'API056',
    ActionTRAKApiErrorCode.api057: 'API057',
    ActionTRAKApiErrorCode.api058: 'API058',
    ActionTRAKApiErrorCode.api059: 'API059',
    ActionTRAKApiErrorCode.api060: 'API060',
    ActionTRAKApiErrorCode.api061: 'API061',
    ActionTRAKApiErrorCode.api062: 'API062',
    ActionTRAKApiErrorCode.api063: 'API063',
    ActionTRAKApiErrorCode.api064: 'API064',
    ActionTRAKApiErrorCode.api065: 'API065',
    ActionTRAKApiErrorCode.api066: 'API066',
    ActionTRAKApiErrorCode.api067: 'API067',
    ActionTRAKApiErrorCode.api068: 'API068',
    ActionTRAKApiErrorCode.api069: 'API069',
    ActionTRAKApiErrorCode.api070: 'API070',
    ActionTRAKApiErrorCode.api071: 'API071',
    ActionTRAKApiErrorCode.api072: 'API072',
    ActionTRAKApiErrorCode.api073: 'API073',
    ActionTRAKApiErrorCode.api074: 'API074',
    ActionTRAKApiErrorCode.api075: 'API075',
    ActionTRAKApiErrorCode.api076: 'API076',
    ActionTRAKApiErrorCode.api077: 'API077',
    ActionTRAKApiErrorCode.api078: 'API078',
    ActionTRAKApiErrorCode.api079: 'API079',
    ActionTRAKApiErrorCode.api080: 'API080',
    ActionTRAKApiErrorCode.api081: 'API081',
    ActionTRAKApiErrorCode.api082: 'API082',
    ActionTRAKApiErrorCode.api083: 'API083',
    ActionTRAKApiErrorCode.api084: 'API084',
    ActionTRAKApiErrorCode.api085: 'API085',
    ActionTRAKApiErrorCode.api086: 'API086',
    ActionTRAKApiErrorCode.api087: 'API087',
    ActionTRAKApiErrorCode.api088: 'API088',
    ActionTRAKApiErrorCode.api089: 'API089',
    ActionTRAKApiErrorCode.api090: 'API090',
    ActionTRAKApiErrorCode.api091: 'API091',
    ActionTRAKApiErrorCode.api092: 'API092',
    ActionTRAKApiErrorCode.api093: 'API093',
    ActionTRAKApiErrorCode.api094: 'API094',
    ActionTRAKApiErrorCode.api095: 'API095',
    ActionTRAKApiErrorCode.api096: 'API096',
    ActionTRAKApiErrorCode.api097: 'API097',
    ActionTRAKApiErrorCode.api098: 'API098',
    ActionTRAKApiErrorCode.api099: 'API099',
    ActionTRAKApiErrorCode.api100: 'API100',
    ActionTRAKApiErrorCode.api101: 'API101',
    ActionTRAKApiErrorCode.api102: 'API102',
    ActionTRAKApiErrorCode.api103: 'API103',
    ActionTRAKApiErrorCode.api104: 'API104',
    ActionTRAKApiErrorCode.api105: 'API105',
    ActionTRAKApiErrorCode.api106: 'API106',
    ActionTRAKApiErrorCode.api107: 'API107',
    ActionTRAKApiErrorCode.api108: 'API108',
    ActionTRAKApiErrorCode.api109: 'API109',
    ActionTRAKApiErrorCode.api110: 'API110',
    ActionTRAKApiErrorCode.api111: 'API111',
    ActionTRAKApiErrorCode.api112: 'API112',
    ActionTRAKApiErrorCode.api113: 'API113',
    ActionTRAKApiErrorCode.api114: 'API114',
    ActionTRAKApiErrorCode.api115: 'API115',
    ActionTRAKApiErrorCode.api116: 'API116',
    ActionTRAKApiErrorCode.api117: 'API117',
    ActionTRAKApiErrorCode.api118: 'API118',
    ActionTRAKApiErrorCode.api119: 'API119',
    ActionTRAKApiErrorCode.api120: 'API120',
    ActionTRAKApiErrorCode.api121: 'API121',
    ActionTRAKApiErrorCode.api122: 'API122',
    ActionTRAKApiErrorCode.api123: 'API123',
    ActionTRAKApiErrorCode.api124: 'API124',
    ActionTRAKApiErrorCode.api125: 'API125',
    ActionTRAKApiErrorCode.api126: 'API126',
    ActionTRAKApiErrorCode.api127: 'API127',
    ActionTRAKApiErrorCode.api128: 'API128',
    ActionTRAKApiErrorCode.api129: 'API129',
    ActionTRAKApiErrorCode.api130: 'API130',
    ActionTRAKApiErrorCode.api131: 'API131',
    ActionTRAKApiErrorCode.api132: 'API132',
    ActionTRAKApiErrorCode.api133: 'API133',
    ActionTRAKApiErrorCode.api134: 'API134',
    ActionTRAKApiErrorCode.api135: 'API135',
    ActionTRAKApiErrorCode.api136: 'API136',
    ActionTRAKApiErrorCode.api137: 'API137',
    ActionTRAKApiErrorCode.api138: 'API138',
    ActionTRAKApiErrorCode.api139: 'API139',
    ActionTRAKApiErrorCode.api141: 'API141',
    ActionTRAKApiErrorCode.api142: 'API142',
    ActionTRAKApiErrorCode.api143: 'API143',
    ActionTRAKApiErrorCode.api144: 'API144',
    ActionTRAKApiErrorCode.api145: 'API145',
    ActionTRAKApiErrorCode.api146: 'API146',
    ActionTRAKApiErrorCode.api147: 'API147',
    ActionTRAKApiErrorCode.api148: 'API148',
    ActionTRAKApiErrorCode.api149: 'API149',
    ActionTRAKApiErrorCode.api150: 'API150',
    ActionTRAKApiErrorCode.api151: 'API151',
    ActionTRAKApiErrorCode.api152: 'API152',
    ActionTRAKApiErrorCode.api155: 'API155',
    ActionTRAKApiErrorCode.api156: 'API156',
    ActionTRAKApiErrorCode.api177: 'API177',
    ActionTRAKApiErrorCode.api178: 'API178',
    ActionTRAKApiErrorCode.api179: 'API179',
    ActionTRAKApiErrorCode.api180: 'API180',
    ActionTRAKApiErrorCode.api181: 'API181',
    ActionTRAKApiErrorCode.api182: 'API182',
    ActionTRAKApiErrorCode.api183: 'API183',
    ActionTRAKApiErrorCode.api184: 'API184',
    ActionTRAKApiErrorCode.api185: 'API185',
    ActionTRAKApiErrorCode.api186: 'API186',
    ActionTRAKApiErrorCode.api187: 'API187',
    ActionTRAKApiErrorCode.api188: 'API188',
    ActionTRAKApiErrorCode.api189: 'API189',
    ActionTRAKApiErrorCode.api190: 'API190',
    ActionTRAKApiErrorCode.api191: 'API191',
    ActionTRAKApiErrorCode.api192: 'API192',
    ActionTRAKApiErrorCode.api193: 'API193',
    ActionTRAKApiErrorCode.api194: 'API194',
    ActionTRAKApiErrorCode.api195: 'API195',
    ActionTRAKApiErrorCode.api196: 'API196',
    ActionTRAKApiErrorCode.api197: 'API197',
    ActionTRAKApiErrorCode.api198: 'API198',
    ActionTRAKApiErrorCode.api199: 'API199',
    ActionTRAKApiErrorCode.api202: 'API202',
    ActionTRAKApiErrorCode.api205: 'API205',
    ActionTRAKApiErrorCode.api206: 'API206',
    ActionTRAKApiErrorCode.api219: 'API219',
    ActionTRAKApiErrorCode.api220: 'API220',
    ActionTRAKApiErrorCode.api225: 'API225',
    ActionTRAKApiErrorCode.api226: 'API226',
    ActionTRAKApiErrorCode.api227: 'API227',
    ActionTRAKApiErrorCode.api228: 'API228',
    ActionTRAKApiErrorCode.api94: 'API94',
    ActionTRAKApiErrorCode.api224: 'API224',
    ActionTRAKApiErrorCode.api426: 'API426',
    ActionTRAKApiErrorCode.connectionErrorOnAutoAction:
        'CONNECTION_ERROR_ON_AUTO_ACTION',
    ActionTRAKApiErrorCode.connectionErrorOnDemandAction:
        'CONNECTION_ERROR_ON_DEMAND_ACTION',
    ActionTRAKApiErrorCode.timeoutErrorOnDemandAction:
        'TIMEOUT_ERROR_ON_DEMAND_ACTION',
    ActionTRAKApiErrorCode.timeoutErrorOnAutoAction:
        'TIMEOUT_ERROR_ON_AUTO_ACTION',
    ActionTRAKApiErrorCode.limitedConnectionErrorOnDemandAction:
        'LIMITED_CONNECTION_ERROR_ON_DEMAND_ACTION',
    ActionTRAKApiErrorCode.limitedConnectionErrorOnAutoAction:
        'LIMITED_CONNECTION_ERROR_ON_AUTO_ACTION',
  };
}

extension ActionTRAKApiErrorCodeMessage on ActionTRAKApiErrorCode {
  String? message(BuildContext context) {
    return <String, String>{
      'API000': I18n.of(context).error_messages__api_000,
      'API001': I18n.of(context).error_messages__api_001,
      'API002': I18n.of(context).error_messages__api_002,
      'API003': I18n.of(context).error_messages__api_003,
      'API004': I18n.of(context).error_messages__api_004,
      'API005': I18n.of(context).error_messages__api_005,
      'API006': I18n.of(context).error_messages__api_006,
      'API007': I18n.of(context).error_messages__api_007,
      'API008': I18n.of(context).error_messages__api_008,
      'API009': I18n.of(context).error_messages__api_009,
      'API010': I18n.of(context).error_messages__api_010,
      'API011': I18n.of(context).error_messages__api_011,
      'API012': I18n.of(context).error_messages__api_012,
      'API013': I18n.of(context).error_messages__api_013,
      'API014': I18n.of(context).error_messages__api_014,
      'API015': I18n.of(context).error_messages__api_015,
      'API016': I18n.of(context).error_messages__api_016,
      'API017': I18n.of(context).error_messages__api_017,
      'API018': I18n.of(context).error_messages__api_018,
      'API019': I18n.of(context).error_messages__api_019,
      'API020': I18n.of(context).error_messages__api_020,
      'API021': I18n.of(context).error_messages__api_021,
      'API022': I18n.of(context).error_messages__api_022,
      'API023': I18n.of(context).error_messages__api_023,
      'API024': I18n.of(context).error_messages__api_024,
      'API025': I18n.of(context).error_messages__api_025,
      'API026': I18n.of(context).error_messages__api_026,
      'API027': I18n.of(context).error_messages__api_027,
      'API028': I18n.of(context).error_messages__api_028,
      'API029': I18n.of(context).error_messages__api_029,
      'API030': I18n.of(context).error_messages__api_030,
      'API031': I18n.of(context).error_messages__api_031,
      'API032': I18n.of(context).error_messages__api_032,
      'API033': I18n.of(context).error_messages__api_033,
      'API034': I18n.of(context).error_messages__api_034,
      'API035': I18n.of(context).error_messages__api_035,
      'API036': I18n.of(context).error_messages__api_036,
      'API037': I18n.of(context).error_messages__api_037,
      'API038': I18n.of(context).error_messages__api_038,
      'API039': I18n.of(context).error_messages__api_039,
      'API040': I18n.of(context).error_messages__api_040,
      'API041': I18n.of(context).error_messages__api_041,
      'API042': I18n.of(context).error_messages__api_042,
      'API043': I18n.of(context).error_messages__api_043,
      'API044': I18n.of(context).error_messages__api_044,
      'API045': I18n.of(context).error_messages__api_045,
      'API046': I18n.of(context).error_messages__api_046,
      'API047': I18n.of(context).error_messages__api_047,
      'API048': I18n.of(context).error_messages__api_048,
      'API049': I18n.of(context).error_messages__api_049,
      'API050': I18n.of(context).error_messages__api_050,
      'API051': I18n.of(context).error_messages__api_051,
      'API052': I18n.of(context).error_messages__api_052,
      'API053': I18n.of(context).error_messages__api_053,
      'API054': I18n.of(context).error_messages__api_054__supporting_text,
      'API055': I18n.of(context).error_messages__api_055,
      'API056': I18n.of(context).error_messages__api_056,
      'API057': I18n.of(context).error_messages__api_057,
      'API058': I18n.of(context).error_messages__api_058,
      'API059': I18n.of(context).error_messages__api_059,
      'API060': I18n.of(context).error_messages__api_060,
      'API061': I18n.of(context).error_messages__api_061,
      'API062': I18n.of(context).error_messages__api_062,
      'API063': I18n.of(context).error_messages__api_063,
      'API064': I18n.of(context).error_messages__api_064,
      'API065': I18n.of(context).error_messages__api_065,
      'API066': I18n.of(context).error_messages__api_066,
      'API067': I18n.of(context).error_messages__api_067,
      'API068': I18n.of(context).error_messages__api_068,
      'API069': I18n.of(context).error_messages__api_069,
      'API070': I18n.of(context).error_messages__api_070,
      'API071': I18n.of(context).error_messages__api_071,
      'API072': I18n.of(context).error_messages__api_072,
      'API073': I18n.of(context).error_messages__api_073,
      'API074': I18n.of(context).error_messages__api_074,
      'API075': I18n.of(context).error_messages__api_075,
      'API076': I18n.of(context).error_messages__api_076,
      'API077': I18n.of(context).error_messages__api_077,
      'API078': I18n.of(context).error_messages__api_078,
      'API079': I18n.of(context).error_messages__api_079,
      'API080': I18n.of(context).error_messages__api_080,
      'API081': I18n.of(context).error_messages__api_081,
      'API082': I18n.of(context).error_messages__api_082,
      'API083': I18n.of(context).error_messages__api_083,
      'API084': I18n.of(context).error_messages__api_084,
      'API085': I18n.of(context).error_messages__api_085,
      'API086': I18n.of(context).error_messages__api_086,
      'API087': I18n.of(context).error_messages__api_087,
      'API088': I18n.of(context).error_messages__api_088,
      'API089': I18n.of(context).error_messages__api_089,
      'API090': I18n.of(context).error_messages__api_090,
      'API091': I18n.of(context).error_messages__api_091,
      'API092': I18n.of(context).error_messages__api_092,
      'API093': I18n.of(context).error_messages__api_093,
      'API094': I18n.of(context).error_messages__api_094,
      'API095': I18n.of(context).error_messages__api_095,
      'API096': I18n.of(context).error_messages__api_096,
      'API097': I18n.of(context).error_messages__api_097,
      'API098': I18n.of(context).error_messages__api_098,
      'API099': I18n.of(context).error_messages__api_099,
      'API100': I18n.of(context).error_messages__api_100,
      'API101': I18n.of(context).error_messages__api_101,
      'API102': I18n.of(context).error_messages__api_102,
      'API103': I18n.of(context).error_messages__api_103,
      'API104': I18n.of(context).error_messages__api_104,
      'API105': I18n.of(context).error_messages__api_105,
      'API106': I18n.of(context).error_messages__api_106,
      'API107': I18n.of(context).error_messages__api_107,
      'API108': I18n.of(context).error_messages__api_108,
      'API109': I18n.of(context).error_messages__api_109,
      'API110': I18n.of(context).error_messages__api_110,
      'API111': I18n.of(context).error_messages__api_111,
      'API112': I18n.of(context).error_messages__api_112,
      'API113': I18n.of(context).error_messages__api_113,
      'API114': I18n.of(context).error_messages__api_114,
      'API115': I18n.of(context).error_messages__api_115,
      'API116': I18n.of(context).error_messages__api_116,
      'API117': I18n.of(context).error_messages__api_117,
      'API118': I18n.of(context).error_messages__api_118,
      'API119': I18n.of(context).error_messages__api_119,
      'API120': I18n.of(context).error_messages__api_120,
      'API121': I18n.of(context).error_messages__api_121,
      'API122': I18n.of(context).error_messages__api_122,
      'API123': I18n.of(context).error_messages__api_123,
      'API124': I18n.of(context).error_messages__api_124,
      'API125': I18n.of(context).error_messages__api_125,
      'API126': I18n.of(context).error_messages__api_126,
      'API127': I18n.of(context).error_messages__api_127,
      'API128': I18n.of(context).error_messages__api_128,
      'API129': I18n.of(context).error_messages__api_129,
      'API130': I18n.of(context).error_messages__api_130,
      'API131': I18n.of(context).error_messages__api_131,
      'API132': I18n.of(context).error_messages__api_132,
      'API133': I18n.of(context).error_messages__api_133,
      'API134': I18n.of(context).error_messages__api_134,
      'API135': I18n.of(context).error_messages__api_135,
      'API136': I18n.of(context).error_messages__api_136,
      'API137':
          I18n.of(context).pin_lock__recovery_email_sent_many_time__message,
      'API138': I18n.of(context).error_messages__api_138__supporting_text,
      'API139': I18n.of(context).error_messages__api_139,
      'API141': I18n.of(context).error_messages__api_141,
      'API142': I18n.of(context).error_messages__api_142,
      'API143': I18n.of(context).error_messages__api_143,
      'API144': I18n.of(context).error_messages__api_144,
      'API145': I18n.of(context).error_messages__api_145,
      'API146': I18n.of(context).error_messages__api_146,
      'API147': I18n.of(context).error_messages__api_147,
      'API148': I18n.of(context).error_messages__api_148,
      'API149': I18n.of(context).error_messages__api_149,
      'API150': I18n.of(context).error_messages__api_150,
      'API151': I18n.of(context).error_messages__api_151,
      'API152': I18n.of(context).error_messages__api_152,
      // TODO(bao.hd): error_messages__api_155__messages is a function, giving it the exact parameter
      // 'API155': I18n.of(context).error_messages__api_155__messages,
      'API156': I18n.of(context).error_messages__api_156,
      // TODO(bao.hd): error_messages__api_177__messages is a function, giving it the exact parameter
      // 'API177': I18n.of(context).error_messages__api_177__messages,
      'API178': I18n.of(context).error_messages__api_178__messages,
      'API180': I18n.of(context).error_messages__api_180__messages,
      'API182': I18n.of(context).error_messages__api_182__messages,
      'API184': I18n.of(context).error_messages__api_184__messages,
      'API186': I18n.of(context).error_messages__api_186__messages,
      'API188': I18n.of(context).error_messages__api_188__messages,
      // 'API190': I18n.of(context).error_messages__api_190__messages,
      'API193': I18n.of(context).error_messages__api_193__messages,
      'API194': I18n.of(context).error_messages__api_194__messages,
      'API195': I18n.of(context).error_messages__api_195__messages,
      'API196': I18n.of(context).error_messages__api_196__messages,
      'API197': I18n.of(context).error_messages__api_197__messages,
      'API198': I18n.of(context).error_messages__api_198__messages,
      'API199': I18n.of(context).error_messages__api_199__messages,
      'API202': I18n.of(context).error_messages__api_202__messages,
      'API219': I18n.of(context).error_messages__api_202__messages,
      'API220': I18n.of(context).error_messages__api_202__messages,
      'API225': I18n.of(context).error_messages__api_225,
      'API226': I18n.of(context).error_messages__api_226,
      'API227': I18n.of(context).error_messages__api_227,
      'API228': I18n.of(context).error_messages__api_228,
      'API224': I18n.of(context).error_messages__api_224,
      'API426': I18n.of(context).error_messages__api_426,
    }[this];
  }
}
