// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardDataModel _$DashboardDataModelFromJson(Map<String, dynamic> json) {
  return _DashboardDataModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardDataModel {
  String get userName => throw _privateConstructorUsedError;
  List<AccountModel> get accounts => throw _privateConstructorUsedError;
  List<PaymentCardModel> get cards => throw _privateConstructorUsedError;
  List<RecentTransactionModel> get recentTransactions =>
      throw _privateConstructorUsedError;

  /// Serializes this DashboardDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardDataModelCopyWith<DashboardDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardDataModelCopyWith<$Res> {
  factory $DashboardDataModelCopyWith(
    DashboardDataModel value,
    $Res Function(DashboardDataModel) then,
  ) = _$DashboardDataModelCopyWithImpl<$Res, DashboardDataModel>;
  @useResult
  $Res call({
    String userName,
    List<AccountModel> accounts,
    List<PaymentCardModel> cards,
    List<RecentTransactionModel> recentTransactions,
  });
}

/// @nodoc
class _$DashboardDataModelCopyWithImpl<$Res, $Val extends DashboardDataModel>
    implements $DashboardDataModelCopyWith<$Res> {
  _$DashboardDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? accounts = null,
    Object? cards = null,
    Object? recentTransactions = null,
  }) {
    return _then(
      _value.copyWith(
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            accounts: null == accounts
                ? _value.accounts
                : accounts // ignore: cast_nullable_to_non_nullable
                      as List<AccountModel>,
            cards: null == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<PaymentCardModel>,
            recentTransactions: null == recentTransactions
                ? _value.recentTransactions
                : recentTransactions // ignore: cast_nullable_to_non_nullable
                      as List<RecentTransactionModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardDataModelImplCopyWith<$Res>
    implements $DashboardDataModelCopyWith<$Res> {
  factory _$$DashboardDataModelImplCopyWith(
    _$DashboardDataModelImpl value,
    $Res Function(_$DashboardDataModelImpl) then,
  ) = __$$DashboardDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userName,
    List<AccountModel> accounts,
    List<PaymentCardModel> cards,
    List<RecentTransactionModel> recentTransactions,
  });
}

/// @nodoc
class __$$DashboardDataModelImplCopyWithImpl<$Res>
    extends _$DashboardDataModelCopyWithImpl<$Res, _$DashboardDataModelImpl>
    implements _$$DashboardDataModelImplCopyWith<$Res> {
  __$$DashboardDataModelImplCopyWithImpl(
    _$DashboardDataModelImpl _value,
    $Res Function(_$DashboardDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? accounts = null,
    Object? cards = null,
    Object? recentTransactions = null,
  }) {
    return _then(
      _$DashboardDataModelImpl(
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        accounts: null == accounts
            ? _value._accounts
            : accounts // ignore: cast_nullable_to_non_nullable
                  as List<AccountModel>,
        cards: null == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<PaymentCardModel>,
        recentTransactions: null == recentTransactions
            ? _value._recentTransactions
            : recentTransactions // ignore: cast_nullable_to_non_nullable
                  as List<RecentTransactionModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardDataModelImpl extends _DashboardDataModel {
  const _$DashboardDataModelImpl({
    required this.userName,
    required final List<AccountModel> accounts,
    required final List<PaymentCardModel> cards,
    required final List<RecentTransactionModel> recentTransactions,
  }) : _accounts = accounts,
       _cards = cards,
       _recentTransactions = recentTransactions,
       super._();

  factory _$DashboardDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardDataModelImplFromJson(json);

  @override
  final String userName;
  final List<AccountModel> _accounts;
  @override
  List<AccountModel> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  final List<PaymentCardModel> _cards;
  @override
  List<PaymentCardModel> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  final List<RecentTransactionModel> _recentTransactions;
  @override
  List<RecentTransactionModel> get recentTransactions {
    if (_recentTransactions is EqualUnmodifiableListView)
      return _recentTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTransactions);
  }

  @override
  String toString() {
    return 'DashboardDataModel(userName: $userName, accounts: $accounts, cards: $cards, recentTransactions: $recentTransactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardDataModelImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            const DeepCollectionEquality().equals(
              other._recentTransactions,
              _recentTransactions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userName,
    const DeepCollectionEquality().hash(_accounts),
    const DeepCollectionEquality().hash(_cards),
    const DeepCollectionEquality().hash(_recentTransactions),
  );

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardDataModelImplCopyWith<_$DashboardDataModelImpl> get copyWith =>
      __$$DashboardDataModelImplCopyWithImpl<_$DashboardDataModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardDataModelImplToJson(this);
  }
}

abstract class _DashboardDataModel extends DashboardDataModel {
  const factory _DashboardDataModel({
    required final String userName,
    required final List<AccountModel> accounts,
    required final List<PaymentCardModel> cards,
    required final List<RecentTransactionModel> recentTransactions,
  }) = _$DashboardDataModelImpl;
  const _DashboardDataModel._() : super._();

  factory _DashboardDataModel.fromJson(Map<String, dynamic> json) =
      _$DashboardDataModelImpl.fromJson;

  @override
  String get userName;
  @override
  List<AccountModel> get accounts;
  @override
  List<PaymentCardModel> get cards;
  @override
  List<RecentTransactionModel> get recentTransactions;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardDataModelImplCopyWith<_$DashboardDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
