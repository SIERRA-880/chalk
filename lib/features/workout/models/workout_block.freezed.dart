// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutBlock {

 String get id; BlockType get type; List<ExerciseSet> get sets;
/// Create a copy of WorkoutBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutBlockCopyWith<WorkoutBlock> get copyWith => _$WorkoutBlockCopyWithImpl<WorkoutBlock>(this as WorkoutBlock, _$identity);

  /// Serializes this WorkoutBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.sets, sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(sets));

@override
String toString() {
  return 'WorkoutBlock(id: $id, type: $type, sets: $sets)';
}


}

/// @nodoc
abstract mixin class $WorkoutBlockCopyWith<$Res>  {
  factory $WorkoutBlockCopyWith(WorkoutBlock value, $Res Function(WorkoutBlock) _then) = _$WorkoutBlockCopyWithImpl;
@useResult
$Res call({
 String id, BlockType type, List<ExerciseSet> sets
});




}
/// @nodoc
class _$WorkoutBlockCopyWithImpl<$Res>
    implements $WorkoutBlockCopyWith<$Res> {
  _$WorkoutBlockCopyWithImpl(this._self, this._then);

  final WorkoutBlock _self;
  final $Res Function(WorkoutBlock) _then;

/// Create a copy of WorkoutBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? sets = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSet>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutBlock].
extension WorkoutBlockPatterns on WorkoutBlock {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutBlock() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutBlock value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutBlock():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutBlock value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutBlock() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  BlockType type,  List<ExerciseSet> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutBlock() when $default != null:
return $default(_that.id,_that.type,_that.sets);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  BlockType type,  List<ExerciseSet> sets)  $default,) {final _that = this;
switch (_that) {
case _WorkoutBlock():
return $default(_that.id,_that.type,_that.sets);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  BlockType type,  List<ExerciseSet> sets)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutBlock() when $default != null:
return $default(_that.id,_that.type,_that.sets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutBlock implements WorkoutBlock {
  const _WorkoutBlock({required this.id, required this.type, final  List<ExerciseSet> sets = const <ExerciseSet>[]}): _sets = sets;
  factory _WorkoutBlock.fromJson(Map<String, dynamic> json) => _$WorkoutBlockFromJson(json);

@override final  String id;
@override final  BlockType type;
 final  List<ExerciseSet> _sets;
@override@JsonKey() List<ExerciseSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of WorkoutBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutBlockCopyWith<_WorkoutBlock> get copyWith => __$WorkoutBlockCopyWithImpl<_WorkoutBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._sets, _sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_sets));

@override
String toString() {
  return 'WorkoutBlock(id: $id, type: $type, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$WorkoutBlockCopyWith<$Res> implements $WorkoutBlockCopyWith<$Res> {
  factory _$WorkoutBlockCopyWith(_WorkoutBlock value, $Res Function(_WorkoutBlock) _then) = __$WorkoutBlockCopyWithImpl;
@override @useResult
$Res call({
 String id, BlockType type, List<ExerciseSet> sets
});




}
/// @nodoc
class __$WorkoutBlockCopyWithImpl<$Res>
    implements _$WorkoutBlockCopyWith<$Res> {
  __$WorkoutBlockCopyWithImpl(this._self, this._then);

  final _WorkoutBlock _self;
  final $Res Function(_WorkoutBlock) _then;

/// Create a copy of WorkoutBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? sets = null,}) {
  return _then(_WorkoutBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSet>,
  ));
}


}

// dart format on
