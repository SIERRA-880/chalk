// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoutineExerciseRef {

 String get exerciseId; int get targetSets; int get targetReps;
/// Create a copy of RoutineExerciseRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineExerciseRefCopyWith<RoutineExerciseRef> get copyWith => _$RoutineExerciseRefCopyWithImpl<RoutineExerciseRef>(this as RoutineExerciseRef, _$identity);

  /// Serializes this RoutineExerciseRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineExerciseRef&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,targetSets,targetReps);

@override
String toString() {
  return 'RoutineExerciseRef(exerciseId: $exerciseId, targetSets: $targetSets, targetReps: $targetReps)';
}


}

/// @nodoc
abstract mixin class $RoutineExerciseRefCopyWith<$Res>  {
  factory $RoutineExerciseRefCopyWith(RoutineExerciseRef value, $Res Function(RoutineExerciseRef) _then) = _$RoutineExerciseRefCopyWithImpl;
@useResult
$Res call({
 String exerciseId, int targetSets, int targetReps
});




}
/// @nodoc
class _$RoutineExerciseRefCopyWithImpl<$Res>
    implements $RoutineExerciseRefCopyWith<$Res> {
  _$RoutineExerciseRefCopyWithImpl(this._self, this._then);

  final RoutineExerciseRef _self;
  final $Res Function(RoutineExerciseRef) _then;

/// Create a copy of RoutineExerciseRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseId = null,Object? targetSets = null,Object? targetReps = null,}) {
  return _then(_self.copyWith(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,targetSets: null == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int,targetReps: null == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineExerciseRef].
extension RoutineExerciseRefPatterns on RoutineExerciseRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineExerciseRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineExerciseRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineExerciseRef value)  $default,){
final _that = this;
switch (_that) {
case _RoutineExerciseRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineExerciseRef value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineExerciseRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseId,  int targetSets,  int targetReps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineExerciseRef() when $default != null:
return $default(_that.exerciseId,_that.targetSets,_that.targetReps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseId,  int targetSets,  int targetReps)  $default,) {final _that = this;
switch (_that) {
case _RoutineExerciseRef():
return $default(_that.exerciseId,_that.targetSets,_that.targetReps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseId,  int targetSets,  int targetReps)?  $default,) {final _that = this;
switch (_that) {
case _RoutineExerciseRef() when $default != null:
return $default(_that.exerciseId,_that.targetSets,_that.targetReps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineExerciseRef implements RoutineExerciseRef {
  const _RoutineExerciseRef({required this.exerciseId, this.targetSets = 3, this.targetReps = 8});
  factory _RoutineExerciseRef.fromJson(Map<String, dynamic> json) => _$RoutineExerciseRefFromJson(json);

@override final  String exerciseId;
@override@JsonKey() final  int targetSets;
@override@JsonKey() final  int targetReps;

/// Create a copy of RoutineExerciseRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineExerciseRefCopyWith<_RoutineExerciseRef> get copyWith => __$RoutineExerciseRefCopyWithImpl<_RoutineExerciseRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineExerciseRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineExerciseRef&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,targetSets,targetReps);

@override
String toString() {
  return 'RoutineExerciseRef(exerciseId: $exerciseId, targetSets: $targetSets, targetReps: $targetReps)';
}


}

/// @nodoc
abstract mixin class _$RoutineExerciseRefCopyWith<$Res> implements $RoutineExerciseRefCopyWith<$Res> {
  factory _$RoutineExerciseRefCopyWith(_RoutineExerciseRef value, $Res Function(_RoutineExerciseRef) _then) = __$RoutineExerciseRefCopyWithImpl;
@override @useResult
$Res call({
 String exerciseId, int targetSets, int targetReps
});




}
/// @nodoc
class __$RoutineExerciseRefCopyWithImpl<$Res>
    implements _$RoutineExerciseRefCopyWith<$Res> {
  __$RoutineExerciseRefCopyWithImpl(this._self, this._then);

  final _RoutineExerciseRef _self;
  final $Res Function(_RoutineExerciseRef) _then;

/// Create a copy of RoutineExerciseRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseId = null,Object? targetSets = null,Object? targetReps = null,}) {
  return _then(_RoutineExerciseRef(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,targetSets: null == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int,targetReps: null == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RoutineBlock {

 BlockType get type; List<RoutineExerciseRef> get exercises;
/// Create a copy of RoutineBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineBlockCopyWith<RoutineBlock> get copyWith => _$RoutineBlockCopyWithImpl<RoutineBlock>(this as RoutineBlock, _$identity);

  /// Serializes this RoutineBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineBlock&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'RoutineBlock(type: $type, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $RoutineBlockCopyWith<$Res>  {
  factory $RoutineBlockCopyWith(RoutineBlock value, $Res Function(RoutineBlock) _then) = _$RoutineBlockCopyWithImpl;
@useResult
$Res call({
 BlockType type, List<RoutineExerciseRef> exercises
});




}
/// @nodoc
class _$RoutineBlockCopyWithImpl<$Res>
    implements $RoutineBlockCopyWith<$Res> {
  _$RoutineBlockCopyWithImpl(this._self, this._then);

  final RoutineBlock _self;
  final $Res Function(RoutineBlock) _then;

/// Create a copy of RoutineBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<RoutineExerciseRef>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineBlock].
extension RoutineBlockPatterns on RoutineBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineBlock value)  $default,){
final _that = this;
switch (_that) {
case _RoutineBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineBlock value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlockType type,  List<RoutineExerciseRef> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineBlock() when $default != null:
return $default(_that.type,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlockType type,  List<RoutineExerciseRef> exercises)  $default,) {final _that = this;
switch (_that) {
case _RoutineBlock():
return $default(_that.type,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlockType type,  List<RoutineExerciseRef> exercises)?  $default,) {final _that = this;
switch (_that) {
case _RoutineBlock() when $default != null:
return $default(_that.type,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineBlock implements RoutineBlock {
  const _RoutineBlock({required this.type, final  List<RoutineExerciseRef> exercises = const <RoutineExerciseRef>[]}): _exercises = exercises;
  factory _RoutineBlock.fromJson(Map<String, dynamic> json) => _$RoutineBlockFromJson(json);

@override final  BlockType type;
 final  List<RoutineExerciseRef> _exercises;
@override@JsonKey() List<RoutineExerciseRef> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of RoutineBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineBlockCopyWith<_RoutineBlock> get copyWith => __$RoutineBlockCopyWithImpl<_RoutineBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineBlock&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'RoutineBlock(type: $type, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$RoutineBlockCopyWith<$Res> implements $RoutineBlockCopyWith<$Res> {
  factory _$RoutineBlockCopyWith(_RoutineBlock value, $Res Function(_RoutineBlock) _then) = __$RoutineBlockCopyWithImpl;
@override @useResult
$Res call({
 BlockType type, List<RoutineExerciseRef> exercises
});




}
/// @nodoc
class __$RoutineBlockCopyWithImpl<$Res>
    implements _$RoutineBlockCopyWith<$Res> {
  __$RoutineBlockCopyWithImpl(this._self, this._then);

  final _RoutineBlock _self;
  final $Res Function(_RoutineBlock) _then;

/// Create a copy of RoutineBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? exercises = null,}) {
  return _then(_RoutineBlock(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<RoutineExerciseRef>,
  ));
}


}


/// @nodoc
mixin _$Routine {

 String get id; String get name; List<RoutineBlock> get blocks;
/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineCopyWith<Routine> get copyWith => _$RoutineCopyWithImpl<Routine>(this as Routine, _$identity);

  /// Serializes this Routine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Routine&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.blocks, blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(blocks));

@override
String toString() {
  return 'Routine(id: $id, name: $name, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $RoutineCopyWith<$Res>  {
  factory $RoutineCopyWith(Routine value, $Res Function(Routine) _then) = _$RoutineCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<RoutineBlock> blocks
});




}
/// @nodoc
class _$RoutineCopyWithImpl<$Res>
    implements $RoutineCopyWith<$Res> {
  _$RoutineCopyWithImpl(this._self, this._then);

  final Routine _self;
  final $Res Function(Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? blocks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<RoutineBlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [Routine].
extension RoutinePatterns on Routine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Routine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Routine value)  $default,){
final _that = this;
switch (_that) {
case _Routine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Routine value)?  $default,){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<RoutineBlock> blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.name,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<RoutineBlock> blocks)  $default,) {final _that = this;
switch (_that) {
case _Routine():
return $default(_that.id,_that.name,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<RoutineBlock> blocks)?  $default,) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.name,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Routine implements Routine {
  const _Routine({required this.id, required this.name, final  List<RoutineBlock> blocks = const <RoutineBlock>[]}): _blocks = blocks;
  factory _Routine.fromJson(Map<String, dynamic> json) => _$RoutineFromJson(json);

@override final  String id;
@override final  String name;
 final  List<RoutineBlock> _blocks;
@override@JsonKey() List<RoutineBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}


/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineCopyWith<_Routine> get copyWith => __$RoutineCopyWithImpl<_Routine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Routine&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._blocks, _blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_blocks));

@override
String toString() {
  return 'Routine(id: $id, name: $name, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$RoutineCopyWith<$Res> implements $RoutineCopyWith<$Res> {
  factory _$RoutineCopyWith(_Routine value, $Res Function(_Routine) _then) = __$RoutineCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<RoutineBlock> blocks
});




}
/// @nodoc
class __$RoutineCopyWithImpl<$Res>
    implements _$RoutineCopyWith<$Res> {
  __$RoutineCopyWithImpl(this._self, this._then);

  final _Routine _self;
  final $Res Function(_Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? blocks = null,}) {
  return _then(_Routine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<RoutineBlock>,
  ));
}


}

// dart format on
