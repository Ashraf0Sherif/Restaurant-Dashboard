// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrdersState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Receipt> receipts) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Receipt> receipts)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Receipt> receipts)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OrdersInitial value) initial,
    required TResult Function(OrdersLoading value) loading,
    required TResult Function(OrdersLoaded value) loaded,
    required TResult Function(OrdersError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OrdersInitial value)? initial,
    TResult? Function(OrdersLoading value)? loading,
    TResult? Function(OrdersLoaded value)? loaded,
    TResult? Function(OrdersError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OrdersInitial value)? initial,
    TResult Function(OrdersLoading value)? loading,
    TResult Function(OrdersLoaded value)? loaded,
    TResult Function(OrdersError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersStateCopyWith<$Res> {
  factory $OrdersStateCopyWith(
          OrdersState value, $Res Function(OrdersState) then) =
      _$OrdersStateCopyWithImpl<$Res, OrdersState>;
}

/// @nodoc
class _$OrdersStateCopyWithImpl<$Res, $Val extends OrdersState>
    implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OrdersInitialImplCopyWith<$Res> {
  factory _$$OrdersInitialImplCopyWith(
          _$OrdersInitialImpl value, $Res Function(_$OrdersInitialImpl) then) =
      __$$OrdersInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrdersInitialImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersInitialImpl>
    implements _$$OrdersInitialImplCopyWith<$Res> {
  __$$OrdersInitialImplCopyWithImpl(
      _$OrdersInitialImpl _value, $Res Function(_$OrdersInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrdersInitialImpl implements _OrdersInitial {
  const _$OrdersInitialImpl();

  @override
  String toString() {
    return 'OrdersState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OrdersInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Receipt> receipts) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Receipt> receipts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Receipt> receipts)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OrdersInitial value) initial,
    required TResult Function(OrdersLoading value) loading,
    required TResult Function(OrdersLoaded value) loaded,
    required TResult Function(OrdersError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OrdersInitial value)? initial,
    TResult? Function(OrdersLoading value)? loading,
    TResult? Function(OrdersLoaded value)? loaded,
    TResult? Function(OrdersError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OrdersInitial value)? initial,
    TResult Function(OrdersLoading value)? loading,
    TResult Function(OrdersLoaded value)? loaded,
    TResult Function(OrdersError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _OrdersInitial implements OrdersState {
  const factory _OrdersInitial() = _$OrdersInitialImpl;
}

/// @nodoc
abstract class _$$OrdersLoadingImplCopyWith<$Res> {
  factory _$$OrdersLoadingImplCopyWith(
          _$OrdersLoadingImpl value, $Res Function(_$OrdersLoadingImpl) then) =
      __$$OrdersLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrdersLoadingImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersLoadingImpl>
    implements _$$OrdersLoadingImplCopyWith<$Res> {
  __$$OrdersLoadingImplCopyWithImpl(
      _$OrdersLoadingImpl _value, $Res Function(_$OrdersLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrdersLoadingImpl implements OrdersLoading {
  const _$OrdersLoadingImpl();

  @override
  String toString() {
    return 'OrdersState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OrdersLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Receipt> receipts) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Receipt> receipts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Receipt> receipts)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OrdersInitial value) initial,
    required TResult Function(OrdersLoading value) loading,
    required TResult Function(OrdersLoaded value) loaded,
    required TResult Function(OrdersError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OrdersInitial value)? initial,
    TResult? Function(OrdersLoading value)? loading,
    TResult? Function(OrdersLoaded value)? loaded,
    TResult? Function(OrdersError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OrdersInitial value)? initial,
    TResult Function(OrdersLoading value)? loading,
    TResult Function(OrdersLoaded value)? loaded,
    TResult Function(OrdersError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OrdersLoading implements OrdersState {
  const factory OrdersLoading() = _$OrdersLoadingImpl;
}

/// @nodoc
abstract class _$$OrdersLoadedImplCopyWith<$Res> {
  factory _$$OrdersLoadedImplCopyWith(
          _$OrdersLoadedImpl value, $Res Function(_$OrdersLoadedImpl) then) =
      __$$OrdersLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Receipt> receipts});
}

/// @nodoc
class __$$OrdersLoadedImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersLoadedImpl>
    implements _$$OrdersLoadedImplCopyWith<$Res> {
  __$$OrdersLoadedImplCopyWithImpl(
      _$OrdersLoadedImpl _value, $Res Function(_$OrdersLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receipts = null,
  }) {
    return _then(_$OrdersLoadedImpl(
      receipts: null == receipts
          ? _value._receipts
          : receipts // ignore: cast_nullable_to_non_nullable
              as List<Receipt>,
    ));
  }
}

/// @nodoc

class _$OrdersLoadedImpl implements OrdersLoaded {
  const _$OrdersLoadedImpl({required final List<Receipt> receipts})
      : _receipts = receipts;

  final List<Receipt> _receipts;
  @override
  List<Receipt> get receipts {
    if (_receipts is EqualUnmodifiableListView) return _receipts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receipts);
  }

  @override
  String toString() {
    return 'OrdersState.loaded(receipts: $receipts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersLoadedImpl &&
            const DeepCollectionEquality().equals(other._receipts, _receipts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_receipts));

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersLoadedImplCopyWith<_$OrdersLoadedImpl> get copyWith =>
      __$$OrdersLoadedImplCopyWithImpl<_$OrdersLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Receipt> receipts) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(receipts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Receipt> receipts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(receipts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Receipt> receipts)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(receipts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OrdersInitial value) initial,
    required TResult Function(OrdersLoading value) loading,
    required TResult Function(OrdersLoaded value) loaded,
    required TResult Function(OrdersError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OrdersInitial value)? initial,
    TResult? Function(OrdersLoading value)? loading,
    TResult? Function(OrdersLoaded value)? loaded,
    TResult? Function(OrdersError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OrdersInitial value)? initial,
    TResult Function(OrdersLoading value)? loading,
    TResult Function(OrdersLoaded value)? loaded,
    TResult Function(OrdersError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OrdersLoaded implements OrdersState {
  const factory OrdersLoaded({required final List<Receipt> receipts}) =
      _$OrdersLoadedImpl;

  List<Receipt> get receipts;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrdersLoadedImplCopyWith<_$OrdersLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrdersErrorImplCopyWith<$Res> {
  factory _$$OrdersErrorImplCopyWith(
          _$OrdersErrorImpl value, $Res Function(_$OrdersErrorImpl) then) =
      __$$OrdersErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$OrdersErrorImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersErrorImpl>
    implements _$$OrdersErrorImplCopyWith<$Res> {
  __$$OrdersErrorImplCopyWithImpl(
      _$OrdersErrorImpl _value, $Res Function(_$OrdersErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$OrdersErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OrdersErrorImpl implements OrdersError {
  const _$OrdersErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'OrdersState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersErrorImplCopyWith<_$OrdersErrorImpl> get copyWith =>
      __$$OrdersErrorImplCopyWithImpl<_$OrdersErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Receipt> receipts) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Receipt> receipts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Receipt> receipts)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OrdersInitial value) initial,
    required TResult Function(OrdersLoading value) loading,
    required TResult Function(OrdersLoaded value) loaded,
    required TResult Function(OrdersError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OrdersInitial value)? initial,
    TResult? Function(OrdersLoading value)? loading,
    TResult? Function(OrdersLoaded value)? loaded,
    TResult? Function(OrdersError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OrdersInitial value)? initial,
    TResult Function(OrdersLoading value)? loading,
    TResult Function(OrdersLoaded value)? loaded,
    TResult Function(OrdersError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OrdersError implements OrdersState {
  const factory OrdersError({required final String message}) =
      _$OrdersErrorImpl;

  String get message;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrdersErrorImplCopyWith<_$OrdersErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
