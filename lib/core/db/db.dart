import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../features/workout/models/enums.dart';
import '../../features/workout/models/exercise.dart';
import '../../features/workout/models/exercise_set.dart';
import '../../features/workout/models/routine.dart';
import '../../features/workout/models/user_config.dart';
import '../../features/workout/models/workout_block.dart';
import '../../features/workout/models/workout_session.dart';

class Db {
  Db._();
  static final Db instance = Db._();

  Future<Database>? _openFuture;

  Future<Database> _open() => _openFuture ??= _doOpen();

  Future<Database> _doOpen() async {
    final dir = await getDatabasesPath();
    return openDatabase(
      p.join(dir, 'gym_companion.db'),
      version: 3,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON;');
      },
      onUpgrade: (db, oldVersion, _) async {
        if (oldVersion < 3) {
          // Colonnes absentes si onCreate n'était pas à jour (versions 1 ou 2)
          try { await db.execute('ALTER TABLE user_config ADD COLUMN body_weight_kg REAL'); } catch (_) {}
          try { await db.execute('ALTER TABLE user_config ADD COLUMN age INTEGER'); } catch (_) {}
        }
      },
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE exercises (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT,
            target_muscle TEXT,
            is_unilateral INTEGER NOT NULL,
            tracking_type TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE sessions (
            id TEXT PRIMARY KEY,
            date INTEGER NOT NULL,
            session_rpe INTEGER NOT NULL,
            duration_minutes INTEGER NOT NULL
          )
        ''');
        await db.execute('CREATE INDEX idx_sessions_date ON sessions(date)');
        await db.execute('''
          CREATE TABLE blocks (
            id TEXT PRIMARY KEY,
            session_id TEXT NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
            type TEXT NOT NULL,
            order_index INTEGER NOT NULL
          )
        ''');
        await db.execute('CREATE INDEX idx_blocks_session ON blocks(session_id)');
        await db.execute('''
          CREATE TABLE sets (
            id TEXT PRIMARY KEY,
            block_id TEXT NOT NULL REFERENCES blocks(id) ON DELETE CASCADE,
            exercise_id TEXT NOT NULL REFERENCES exercises(id),
            weight REAL,
            reps INTEGER,
            duration_seconds INTEGER,
            is_true_1rm INTEGER NOT NULL,
            order_index INTEGER NOT NULL
          )
        ''');
        await db.execute('CREATE INDEX idx_sets_exercise ON sets(exercise_id)');
        await db.execute('CREATE INDEX idx_sets_block ON sets(block_id)');
        await db.execute('''
          CREATE TABLE user_config (
            id TEXT PRIMARY KEY,
            global_objectives TEXT,
            body_weight_kg REAL,
            age INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE routines (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE routine_exercises (
            id TEXT PRIMARY KEY,
            routine_id TEXT NOT NULL REFERENCES routines(id) ON DELETE CASCADE,
            block_type TEXT NOT NULL,
            exercise_id TEXT NOT NULL REFERENCES exercises(id),
            target_sets INTEGER NOT NULL,
            target_reps INTEGER NOT NULL,
            order_index INTEGER NOT NULL
          )
        ''');
        await db.execute(
            'CREATE INDEX idx_routine_exercises_routine ON routine_exercises(routine_id)');
      },
    );
  }

  // ---------- Exercises ----------

  Future<void> upsertExercise(Exercise e) async {
    final db = await _open();
    await db.insert(
      'exercises',
      {
        'id': e.id,
        'name': e.name,
        'description': e.description,
        'target_muscle': e.targetMuscle,
        'is_unilateral': e.isUnilateral ? 1 : 0,
        'tracking_type': e.trackingType.name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteExercise(String id) async {
    final db = await _open();
    await db.delete('exercises', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Exercise>> allExercises() async {
    final db = await _open();
    final rows = await db.query('exercises');
    return rows.map(_rowToExercise).toList();
  }

  Exercise _rowToExercise(Map<String, Object?> r) => Exercise(
        id: r['id'] as String,
        name: r['name'] as String,
        description: r['description'] as String?,
        targetMuscle: r['target_muscle'] as String?,
        isUnilateral: (r['is_unilateral'] as int) == 1,
        trackingType: TrackingType.values
            .firstWhere((t) => t.name == r['tracking_type'] as String),
      );

  // ---------- Sessions ----------

  Future<void> insertSession(WorkoutSession s) async {
    final db = await _open();
    await db.transaction((txn) async {
      await txn.insert('sessions', {
        'id': s.id,
        'date': s.date.millisecondsSinceEpoch,
        'session_rpe': s.sessionRPE,
        'duration_minutes': s.durationMinutes,
      });
      for (var bi = 0; bi < s.blocks.length; bi++) {
        final b = s.blocks[bi];
        await txn.insert('blocks', {
          'id': b.id,
          'session_id': s.id,
          'type': b.type.name,
          'order_index': bi,
        });
        for (var si = 0; si < b.sets.length; si++) {
          final st = b.sets[si];
          await txn.insert('sets', {
            'id': st.id,
            'block_id': b.id,
            'exercise_id': st.exerciseId,
            'weight': st.weight,
            'reps': st.reps,
            'duration_seconds': st.durationSeconds,
            'is_true_1rm': st.isTrue1RM ? 1 : 0,
            'order_index': si,
          });
        }
      }
    });
  }

  Future<List<WorkoutSession>> allSessions() => sessionsBetween(
        DateTime.fromMillisecondsSinceEpoch(0),
        DateTime.now().add(const Duration(days: 1)),
      );

  Future<List<WorkoutSession>> sessionsBetween(DateTime from, DateTime to) async {
    final db = await _open();
    final sessRows = await db.query(
      'sessions',
      where: 'date >= ? AND date < ?',
      whereArgs: [from.millisecondsSinceEpoch, to.millisecondsSinceEpoch],
      orderBy: 'date DESC',
    );
    if (sessRows.isEmpty) return const [];
    final sessIds = sessRows.map((r) => r['id'] as String).toList();
    final placeholders = List.filled(sessIds.length, '?').join(',');
    final blockRows = await db.query(
      'blocks',
      where: 'session_id IN ($placeholders)',
      whereArgs: sessIds,
      orderBy: 'order_index ASC',
    );
    final blockIds = blockRows.map((r) => r['id'] as String).toList();
    final setRows = blockIds.isEmpty
        ? const <Map<String, Object?>>[]
        : await db.query(
            'sets',
            where:
                'block_id IN (${List.filled(blockIds.length, '?').join(',')})',
            whereArgs: blockIds,
            orderBy: 'order_index ASC',
          );

    final setsByBlock = <String, List<ExerciseSet>>{};
    for (final r in setRows) {
      setsByBlock
          .putIfAbsent(r['block_id'] as String, () => [])
          .add(_rowToSet(r));
    }
    final blocksBySession = <String, List<WorkoutBlock>>{};
    for (final r in blockRows) {
      final id = r['id'] as String;
      blocksBySession.putIfAbsent(r['session_id'] as String, () => []).add(
            WorkoutBlock(
              id: id,
              type: BlockType.values
                  .firstWhere((t) => t.name == r['type'] as String),
              sets: setsByBlock[id] ?? const [],
            ),
          );
    }
    return sessRows.map((r) {
      final id = r['id'] as String;
      return WorkoutSession(
        id: id,
        date: DateTime.fromMillisecondsSinceEpoch(r['date'] as int),
        blocks: blocksBySession[id] ?? const [],
        sessionRPE: r['session_rpe'] as int,
        durationMinutes: r['duration_minutes'] as int,
      );
    }).toList();
  }

  Future<void> deleteSession(String id) async {
    final db = await _open();
    await db.delete('sessions', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ExerciseSet>> setsForExercise(String exerciseId) async {
    final db = await _open();
    final rows = await db.query(
      'sets',
      where: 'exercise_id = ?',
      whereArgs: [exerciseId],
    );
    return rows.map(_rowToSet).toList();
  }

  ExerciseSet _rowToSet(Map<String, Object?> r) => ExerciseSet(
        id: r['id'] as String,
        exerciseId: r['exercise_id'] as String,
        weight: (r['weight'] as num?)?.toDouble(),
        reps: r['reps'] as int?,
        durationSeconds: r['duration_seconds'] as int?,
        isTrue1RM: (r['is_true_1rm'] as int) == 1,
      );

  // ---------- UserConfig ----------

  Future<UserConfig?> getUserConfig() async {
    final db = await _open();
    final rows = await db.query('user_config', limit: 1);
    if (rows.isEmpty) return null;
    final r = rows.first;
    return UserConfig(
      id: r['id'] as String,
      globalObjectives: (r['global_objectives'] as String?) ?? '',
      bodyWeightKg: (r['body_weight_kg'] as num?)?.toDouble(),
      age: r['age'] as int?,
    );
  }

  Future<void> saveUserConfig(UserConfig c) async {
    final db = await _open();
    await db.insert(
      'user_config',
      {
        'id': c.id,
        'global_objectives': c.globalObjectives,
        'body_weight_kg': c.bodyWeightKg,
        'age': c.age,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ---------- Routines ----------

  Future<void> insertRoutine(Routine r) async {
    final db = await _open();
    await db.transaction((txn) async {
      await txn.insert(
        'routines',
        {'id': r.id, 'name': r.name},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await txn.delete('routine_exercises',
          where: 'routine_id = ?', whereArgs: [r.id]);
      var orderIndex = 0;
      for (final block in r.blocks) {
        for (final ref in block.exercises) {
          await txn.insert('routine_exercises', {
            'id': 'rex_${r.id}_${orderIndex.toString()}',
            'routine_id': r.id,
            'block_type': block.type.name,
            'exercise_id': ref.exerciseId,
            'target_sets': ref.targetSets,
            'target_reps': ref.targetReps,
            'order_index': orderIndex,
          });
          orderIndex++;
        }
      }
    });
  }

  Future<void> deleteRoutine(String id) async {
    final db = await _open();
    await db.delete('routines', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Routine>> allRoutines() async {
    final db = await _open();
    final rows = await db.query('routines', orderBy: 'name ASC');
    if (rows.isEmpty) return const [];
    final refRows = await db.query(
      'routine_exercises',
      orderBy: 'order_index ASC',
    );
    final refsByRoutine = <String, Map<BlockType, List<RoutineExerciseRef>>>{};
    for (final r in refRows) {
      final routineId = r['routine_id'] as String;
      final blockType = BlockType.values
          .firstWhere((t) => t.name == r['block_type'] as String);
      refsByRoutine
          .putIfAbsent(routineId, () => {})
          .putIfAbsent(blockType, () => [])
          .add(RoutineExerciseRef(
            exerciseId: r['exercise_id'] as String,
            targetSets: r['target_sets'] as int,
            targetReps: r['target_reps'] as int,
          ));
    }
    return rows.map((r) {
      final id = r['id'] as String;
      final byBlock = refsByRoutine[id] ?? const {};
      return Routine(
        id: id,
        name: r['name'] as String,
        blocks: BlockType.values
            .map((t) =>
                RoutineBlock(type: t, exercises: byBlock[t] ?? const []))
            .toList(),
      );
    }).toList();
  }

  /// Pour le chart 1RM : ((date de session, weight, reps)) de chaque set d'un exo.
  Future<List<({DateTime date, double weight, int reps})>>
      setHistoryWithDatesForExercise(String exerciseId) async {
    final db = await _open();
    final rows = await db.rawQuery('''
      SELECT s.weight AS weight, s.reps AS reps, sess.date AS date
      FROM sets s
      JOIN blocks b ON b.id = s.block_id
      JOIN sessions sess ON sess.id = b.session_id
      WHERE s.exercise_id = ? AND s.weight IS NOT NULL AND s.reps IS NOT NULL AND s.reps > 0
      ORDER BY sess.date ASC
    ''', [exerciseId]);
    return rows
        .map((r) => (
              date: DateTime.fromMillisecondsSinceEpoch(r['date'] as int),
              weight: (r['weight'] as num).toDouble(),
              reps: r['reps'] as int,
            ))
        .toList();
  }
}
