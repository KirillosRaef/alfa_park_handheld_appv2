// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      ticketId: (json['ticket_id'] as num).toInt(),
      ticketTypeId: (json['ticket_type_id'] as num).toInt(),
      ticketCode: json['ticket_code'] as String,
      ticketTitle: json['ticket_title'] as String,
      ticketNote: json['ticket_note'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'ticketId': instance.ticketId,
      'ticketTypeId': instance.ticketTypeId,
      'ticketCode': instance.ticketCode,
      'ticketTitle': instance.ticketTitle,
      'ticketNote': instance.ticketNote,
      'amount': instance.amount,
    };
