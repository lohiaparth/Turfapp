import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/auth_screen.dart';
import '../../features/auth/screens/profile_screen.dart';
import '../../features/discover/screens/discover_screen.dart';
import '../../features/discover/screens/turf_detail_screen.dart';
import '../../features/booking/screens/slot_picker_screen.dart';
import '../../features/booking/screens/booking_confirm_screen.dart';
import '../../features/booking/screens/my_bookings_screen.dart';
import '../../features/owner/screens/owner_dashboard_screen.dart';
import '../../features/owner/screens/add_edit_turf_screen.dart';
import '../../features/owner/screens/turf_bookings_screen.dart';
import '../../shared/models/models.dart';
import '../../core/theme/app_theme.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);
  final userAsync = ref.watch(currentUserProvider);

  return GoRouter(
    initialLocation: '/discover',
    redirect: (context, state) {
      final loggedIn = auth.valueOrNull != null;
      final isAuth = state.matchedLocation == '/auth';
      if (!loggedIn && !isAuth) return '/auth';
      if (loggedIn && isAuth) {
        // Route to correct home based on role
        final user = userAsync.valueOrNull;
        if (user != null && user.role == UserRole.owner) return '/owner';
        return '/discover';
      }
      return null;
    },
    routes: [
      // ── Auth ──────────────────────────────────────────────────────────────
      GoRoute(
        path: '/auth',
        builder: (_, __) => const AuthScreen(),
      ),

      // ── Player shell ─────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => _PlayerShell(child: child),
        routes: [
          GoRoute(
            path: '/discover',
            builder: (_, __) => const DiscoverScreen(),
            routes: [
              GoRoute(
                path: ':turfId',
                builder: (_, state) {
                  final turf = state.extra as TurfModel;
                  return TurfDetailScreen(turf: turf);
                },
                routes: [
                  GoRoute(
                    path: 'slots',
                    builder: (_, state) {
                      final turf = state.extra as TurfModel;
                      return SlotPickerScreen(turf: turf);
                    },
                  ),
                  GoRoute(
                    path: 'confirm',
                    builder: (_, state) {
                      final extra =
                          state.extra as Map<String, dynamic>;
                      return BookingConfirmScreen(
                        turf: extra['turf'] as TurfModel,
                        date: extra['date'] as String,
                        slot: extra['slot'] as BookingSlot,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/bookings',
            builder: (_, __) => const MyBookingsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),

      // ── Owner shell ──────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => _OwnerShell(child: child),
        routes: [
          GoRoute(
            path: '/owner',
            builder: (_, __) => const OwnerDashboardScreen(),
            routes: [
              GoRoute(
                path: 'add-turf',
                builder: (_, __) => const AddEditTurfScreen(),
              ),
              GoRoute(
                path: 'edit-turf',
                builder: (_, state) {
                  final turf = state.extra as TurfModel;
                  return AddEditTurfScreen(existingTurf: turf);
                },
              ),
              GoRoute(
                path: 'turf/:turfId/bookings',
                builder: (_, state) {
                  final turf = state.extra as TurfModel;
                  return TurfBookingsScreen(turf: turf);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/owner/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});

// ── Player bottom nav shell ───────────────────────────────────────────────────
class _PlayerShell extends ConsumerWidget {
  final Widget child;
  const _PlayerShell({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    int index = 0;
    if (location.startsWith('/bookings')) index = 1;
    if (location.startsWith('/profile')) index = 2;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) {
            switch (i) {
              case 0:
                context.go('/discover');
                break;
              case 1:
                context.go('/bookings');
                break;
              case 2:
                context.go('/profile');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// ── Owner bottom nav shell ────────────────────────────────────────────────────
class _OwnerShell extends ConsumerWidget {
  final Widget child;
  const _OwnerShell({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    int index = 0;
    if (location == '/owner/profile') index = 1;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) {
            switch (i) {
              case 0:
                context.go('/owner');
                break;
              case 1:
                context.go('/owner/profile');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'My Turfs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
