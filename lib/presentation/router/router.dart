import 'package:flutter/material.dart';
import 'package:flutter_test_various/presentation/pages/account_page.dart';
import 'package:flutter_test_various/presentation/pages/test_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../application/state/state.dart';
import '../pages/detail_page.dart';
import '../pages/shipping_page.dart';
import '../pages/sign_in.dart';
import '../pages/stock_page.dart';
import '../pages/product_registraion_page.dart.dart';
part 'router.g.dart';

class PagePath {
  static const signIn = '/sign-in';
  static const productRegistration = '/productRegistration';
  static const shipping = '/shipping';
  static const stock = '/stock';
  static const account = '/account';
  static const detail = '/detail';
  static const test = '/test';
}

@riverpod
GoRouter router(RouterRef ref) {
  // パスと画面の組み合わせ
  final routes = [
    // サインイン画面
    GoRoute(
      path: PagePath.signIn,
      builder: (_, __) => SignInPage(),
    ),

    // ユーザーIDスコープで囲むためのシェル
    ShellRoute(
      builder: (_, __, child) => UserIdScope(child: child),
      routes: [
        // ホーム画面
        GoRoute(
          path: PagePath.productRegistration,
          builder: (_, __) => ProductRegistrationPage(),
        ),
        GoRoute(
          path: PagePath.shipping,
          builder: (_, __) => ShippingPage(),
        ),
        GoRoute(
          path: PagePath.stock,
          builder: (_, __) => StockPage(),
        ),
        GoRoute(
          path: PagePath.account,
          builder: (_, __) => const AccountPage(),
        ),
        GoRoute(
          path: PagePath.detail,
          builder: (_, __) => const DetailPage(),
        ),
        GoRoute(
          path: PagePath.test,
          builder: (_, __) => const TestPage(),
        ),
      ],
    ),
  ];
  // リダイレクト - 強制的に画面を変更する
  String? redirect(BuildContext context, GoRouterState state) {
    // 表示しようとしている画面
    final page = state.location;
    // サインインしているかどうか
    final signedIn = ref.read(signedInProvider);

    if (signedIn && page == PagePath.signIn) {
      // もうサインインしているのに サインイン画面を表示しようとしている --> ホーム画面へ
      return PagePath.stock;
    } else if (!signedIn) {
      // まだサインインしていない --> サインイン画面へ
      return PagePath.signIn;
    } else {
      return null;
    }
  }

  // リフレッシュリスナブル - Riverpod と GoRouter を連動させるコード
  // サインイン状態が切り替わったときに GoRouter が反応する
  final listenable = ValueNotifier<Object?>(null);
  ref.listen<Object?>(signedInProvider, (_, newState) {
    listenable.value = newState;
  });
  ref.onDispose(listenable.dispose);

  // GoRouterを作成
  return GoRouter(
    initialLocation: PagePath.signIn,
    routes: routes,
    redirect: redirect,
    refreshListenable: listenable,
  );
}

/// ---------------------------------------------------------
/// アプリ本体    >> router/app.dart
/// ---------------------------------------------------------
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 94, 100, 114),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
