// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  int get ticketId => throw _privateConstructorUsedError;
  int get ticketTypeId => throw _privateConstructorUsedError;
  String get ticketCode => throw _privateConstructorUsedError;
  String get ticketTitle => throw _privateConstructorUsedError;
  String get ticketNote => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {int ticketId,
      int ticketTypeId,
      String ticketCode,
      String ticketTitle,
      String ticketNote,
      double amount});
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = null,
    Object? ticketTypeId = null,
    Object? ticketCode = null,
    Object? ticketTitle = null,
    Object? ticketNote = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      ticketId: null == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as int,
      ticketTypeId: null == ticketTypeId
          ? _value.ticketTypeId
          : ticketTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      ticketCode: null == ticketCode
          ? _value.ticketCode
          : ticketCode // ignore: cast_nullable_to_non_nullable
              as String,
      ticketTitle: null == ticketTitle
          ? _value.ticketTitle
          : ticketTitle // ignore: cast_nullable_to_non_nullable
              as String,
      ticketNote: null == ticketNote
          ? _value.ticketNote
          : ticketNote // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
          _$PaymentImpl value, $Res Function(_$PaymentImpl) then) =
      __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int ticketId,
      int ticketTypeId,
      String ticketCode,
      String ticketTitle,
      String ticketNote,
      double amount});
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
      _$PaymentImpl _value, $Res Function(_$PaymentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = null,
    Object? ticketTypeId = null,
    Object? ticketCode = null,
    Object? ticketTitle = null,
    Object? ticketNote = null,
    Object? amount = null,
  }) {
    return _then(_$PaymentImpl(
      ticketId: null == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as int,
      ticketTypeId: null == ticketTypeId
          ? _value.ticketTypeId
          : ticketTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      ticketCode: null == ticketCode
          ? _value.ticketCode
          : ticketCode // ignore: cast_nullable_to_non_nullable
              as String,
      ticketTitle: null == ticketTitle
          ? _value.ticketTitle
          : ticketTitle // ignore: cast_nullable_to_non_nullable
              as String,
      ticketNote: null == ticketNote
          ? _value.ticketNote
          : ticketNote // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentImpl implements _Payment {
  const _$PaymentImpl(
      {required this.ticketId,
      required this.ticketTypeId,
      required this.ticketCode,
      required this.ticketTitle,
      required this.ticketNote,
      required this.amount});

  factory _$PaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentImplFromJson(json);

  @override
  final int ticketId;
  @override
  final int ticketTypeId;
  @override
  final String ticketCode;
  @override
  final String ticketTitle;
  @override
  final String ticketNote;
  @override
  final double amount;

  @override
  String toString() {
    return 'Payment(ticketId: $ticketId, ticketTypeId: $ticketTypeId, ticketCode: $ticketCode, ticketTitle: $ticketTitle, ticketNote: $ticketNote, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            (identical(other.ticketTypeId, ticketTypeId) ||
                other.ticketTypeId == ticketTypeId) &&
            (identical(other.ticketCode, ticketCode) ||
                other.ticketCode == ticketCode) &&
            (identical(other.ticketTitle, ticketTitle) ||
                other.ticketTitle == ticketTitle) &&
            (identical(other.ticketNote, ticketNote) ||
                other.ticketNote == ticketNote) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ticketId, ticketTypeId,
      ticketCode, ticketTitle, ticketNote, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentImplToJson(
      this,
    );
  }
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {required final int ticketId,
      required final int ticketTypeId,
      required final String ticketCode,
      required final String ticketTitle,
      required final String ticketNote,
      required final double amount}) = _$PaymentImpl;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$PaymentImpl.fromJson;

  @override
  int get ticketId;
  @override
  int get ticketTypeId;
  @override
  String get ticketCode;
  @override
  String get ticketTitle;
  @override
  String get ticketNote;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
