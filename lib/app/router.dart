
import 'package:go_router/go_router.dart';

import '../presentation/screens/login_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/add_item_screen.dart';
import '../presentation/screens/item_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
  path: '/items/new',
  builder: (context, state) => const AddItemScreen(),
),

GoRoute(
  path: '/items/:id',
  builder: (context, state) => const ItemDetailScreen(),
),

GoRoute(
  path: '/items/:id/edit',
  builder: (context, state) => const AddItemScreen(),
),
  ],
);
