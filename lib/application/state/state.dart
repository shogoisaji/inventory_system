import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'state.g.dart';

@riverpod
class StockType extends _$StockType {
  @override
  int build() => 0;
}

///
/// FirebaseのユーザーをAsyncValue型で管理するプロバイダー
///
@riverpod
Stream<User?> userChanges(UserChangesRef ref) {
  // Firebaseからユーザーの変化を教えてもらう
  return FirebaseAuth.instance.authStateChanges();
}

///
/// ユーザー
///
@riverpod
User? user(UserRef ref) {
  final userChanges = ref.watch(userChangesProvider);
  return userChanges.when(
    loading: () => null,
    error: (_, __) => null,
    data: (d) => d,
  );
}

///
/// サインイン中かどうか
///
@riverpod
bool signedIn(SignedInRef ref) {
  final user = ref.watch(userProvider);
  return user != null;
}

///
/// ユーザーID
///
@riverpod
String userId(UserIdRef ref) {
  throw 'スコープ内の画面でしか使えません';
}

/// ---------------------------------------------------------
/// ユーザーIDを使えるスコープ    >> router/user_id_scope.dart
/// ---------------------------------------------------------
class UserIdScope extends ConsumerWidget {
  const UserIdScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// サインインしているユーザーの情報
    final user = ref.watch(userProvider);
    if (user == null) {
      // ユーザーが見つからないとき グルグル
      return const CircularProgressIndicator();
    } else {
      // ユーザーが見つかったとき
      return ProviderScope(
        // ユーザーIDを上書き
        overrides: [
          userIdProvider.overrideWithValue(user.uid),
        ],
        child: child,
      );
    }
  }
}
