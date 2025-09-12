import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/core/di/locators.dart';
import 'package:testing_riverpod/scaffold_with_navbar.dart';
import 'package:testing_riverpod/ui/notes/details/note_details_bloc.dart';
import 'package:testing_riverpod/ui/notes/details/note_details_event.dart';
import 'package:testing_riverpod/ui/notes/details/widget/note_details_screen.dart';
import 'package:testing_riverpod/ui/notes/notes_bloc.dart';
import 'package:testing_riverpod/ui/notes/notes_event.dart';
import 'package:testing_riverpod/ui/notes/widget/notes_screen.dart';
import 'package:testing_riverpod/ui/settings/widget/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'homeShell',
);
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(
  debugLabel: 'settingsShell',
);

class AppRoutes {
  static const String home = '/home';
  static const String noteDetails = 'details/:id';
  static const String settings = '/settings';
}

final router = GoRouter(
  initialLocation: AppRoutes.home,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavbar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          //Home
          navigatorKey: _shellNavigatorHomeKey,
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.home,
              parentNavigatorKey: _shellNavigatorHomeKey,
              builder: (context, state) => BlocProvider<NotesBloc>(
                create: (context) =>
                    NotesBloc(locator(), locator())
                      ..add(FetchNotes()),
                child: NotesScreen(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.noteDetails,
                  name: AppRoutes.noteDetails,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    return BlocProvider<NoteDetailsBloc>(
                      create: (context) =>
                          NoteDetailsBloc(locator(), locator())
                            ..add(GetNote(id ?? "-1")),
                      child: NoteDetailsScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          //Settings
          navigatorKey: _shellNavigatorSettingsKey,
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.settings,
              name: AppRoutes.settings,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
