import 'dart:async';
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

@riverpod
class iconRotate extends _$iconRotate {
  @override
  double build() => 1.0;
}

@riverpod
class DetailProduct extends _$DetailProduct {
  @override
  String build() => 'none';
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

// @riverpod
// Stream<DocumentSnapshot<Map<String, dynamic>>?> userData(UserDataRef ref) {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final user = ref.watch(userProvider);
//   final userId = user?.uid;

//   if(userId != null) {
//     return _firestore.collection('users').doc(userId).snapshots();
//   } else {
//     return Stream.value(null);
//   }
// }

// @riverpod
// String userName(UserNameRef ref) {
//   final userData = ref.watch(userDataProvider);
//     return userData.when(
//       data: (d) => d!=null?d['userName']:"NoName",
//       loading: () => 'loading',
//       error: (_, __) => 'Error',
//     );
// }

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
    final user = ref.watch(userProvider);
    if (user == null) {
      return const CircularProgressIndicator();
    } else {
      return ProviderScope(
        overrides: [
          userIdProvider.overrideWithValue(user.uid),
        ],
        child: child,
      );
    }
  }
}
