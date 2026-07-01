import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/create/screens/create_menu_screen.dart';
import '../features/create/screens/exercise_form_screen.dart';
import '../features/create/screens/routine_form_screen.dart';
import '../features/dashboard/screens/ai_analysis_screen.dart';
import '../features/dashboard/screens/api_key_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/settings/screens/user_config_screen.dart';
import '../features/workout/models/exercise.dart';
import '../features/workout/models/routine.dart';
import '../features/workout/models/workout_session.dart';
import '../features/workout/screens/active_session_screen.dart';
import '../features/workout/screens/history_screen.dart';
import '../features/workout/screens/routines_list_screen.dart';
import '../features/workout/screens/session_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/workout',
  routes: [
    GoRoute(
      path: '/settings',
      builder: (_, _) => const UserConfigScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) => _ShellScaffold(navShell: navShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/workout',
            builder: (_, _) => const RoutinesListScreen(),
            routes: [
              GoRoute(
                path: 'active',
                builder: (_, state) =>
                    ActiveSessionScreen(routine: state.extra! as Routine),
              ),
              GoRoute(
                path: 'edit-routine',
                builder: (_, state) =>
                    RoutineFormScreen(routine: state.extra as Routine),
              ),
              GoRoute(
                path: 'history',
                builder: (_, _) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (_, state) => SessionDetailScreen(
                        session: state.extra! as WorkoutSession),
                  ),
                ],
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/create',
            builder: (_, _) => const CreateMenuScreen(),
            routes: [
              GoRoute(
                path: 'exercise',
                builder: (_, state) =>
                    ExerciseFormScreen(exercise: state.extra as Exercise?),
              ),
              GoRoute(
                path: 'routine',
                builder: (_, _) => const RoutineFormScreen(),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, _) => const DashboardScreen(),
            routes: [
              GoRoute(
                path: 'api-key',
                builder: (_, _) => const ApiKeyScreen(),
              ),
              GoRoute(
                path: 'ai-analysis',
                builder: (_, _) => const AiAnalysisScreen(),
              ),
            ],
          ),
        ]),
      ],
    ),
  ],
);

class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold({required this.navShell});

  final StatefulNavigationShell navShell;

  static const _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.fitness_center), label: 'Workout'),
    BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Création'),
    BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Dashboard'),
  ];

  static const _titles = ['Workout', 'Création', 'Dashboard & IA'];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_titles[navShell.currentIndex]),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
        body: navShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navShell.currentIndex,
          destinations: _items
              .map((i) => NavigationDestination(icon: i.icon, label: i.label!))
              .toList(),
          onDestinationSelected: (i) =>
              navShell.goBranch(i, initialLocation: i == navShell.currentIndex),
        ),
      );
}
