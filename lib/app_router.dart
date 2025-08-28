import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/scaffold_with_navbar.dart';
import 'package:testing_riverpod/ui/home/details/widget/note_details_screen.dart';
import 'package:testing_riverpod/ui/home/widget/home_screen.dart';
import 'package:testing_riverpod/ui/settings/widget/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'homeShell',
);
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(
  debugLabel: 'settingsShell',
);

class AppRoutes{
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
        StatefulShellBranch( //Home
          navigatorKey: _shellNavigatorHomeKey,
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.home,
              parentNavigatorKey: _shellNavigatorHomeKey,
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: AppRoutes.noteDetails,
                  name: AppRoutes.noteDetails,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state){
                    final id = state.pathParameters['id'];
                     return NoteDetailsScreen(id: id ?? "");
                     },
                  )
              ]
            ),
          ],
        ),

        StatefulShellBranch( //Settings
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
