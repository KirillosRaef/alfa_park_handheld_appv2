// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketImpl _$$TicketImplFromJson(Map<String, dynamic> json) => _$TicketImpl(
      ticketTypeId: (json['ticket_type_id'] as num).toInt(),
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      printText: json['print_text'] as String,
    );

Map<String, dynamic> _$$TicketImplToJson(_$TicketImpl instance) =>
    <String, dynamic>{
      'ticketTypeId': instance.ticketTypeId,
      'nameEn': instance.nameEn,
      'nameAr': instance.nameAr,
      'printText': instance.printText,
    };
