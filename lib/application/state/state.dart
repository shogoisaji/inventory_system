import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'state.g.dart';

const List<String> productTypeList = <String>['部品', '文房具', '機器', '消耗品', '梱包材'];

// productName
@riverpod
class ProductDocument extends _$ProductDocument {
  @override
  String build() => "None";

  void changeDocument(String product) => state = product;
}

/// productData
@riverpod
Stream<DocumentSnapshot<Object>?> productFieldData(ProductFieldDataRef ref) {
  final productDocs = ref.watch(productDocumentProvider);
  final productRef =
      FirebaseFirestore.instance.collection('items').doc(productDocs);
  return productRef.snapshots();
}

/// productSnapshot
@riverpod
DocumentSnapshot<Object?>? productSnapshot(ProductSnapshotRef ref) {
  final snapshot = ref.watch(productFieldDataProvider);
  return snapshot.when(
    loading: () => null,
    error: (_, __) => null,
    data: (d) => d,
  );
}

// IncrementDialog
@riverpod
class IncrementDialogState extends _$IncrementDialogState {
  @override
  bool build() => false;

  void show() => state = true;

  void hide() => state = false;
}

// DecrementDialog
@riverpod
class DecrementDialogState extends _$DecrementDialogState {
  @override
  bool build() => false;

  void show() => state = true;

  void hide() => state = false;
}

// ローディング
@riverpod
class LoadingState extends _$LoadingState {
  @override
  bool build() => false;

  void show() => state = true;

  void hide() => state = false;
}

@riverpod
class ProductType extends _$ProductType {
  @override
  String build() => productTypeList[0];
}

@riverpod
class StockType extends _$StockType {
  @override
  int build() => 0;

  void changeType(int index) => state = index;
}

@riverpod
class DetailProduct extends _$DetailProduct {
  @override
  String build() => 'none';
}

@riverpod
class ImageFile extends _$ImageFile {
  @override
  File? build() => null;
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

/// ユーザー名
@riverpod
Stream<DocumentSnapshot> userData(UserDataRef ref) {
  final user = ref.watch(userProvider);
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('users').doc(user?.uid);
  return userRef.snapshots();
}

@riverpod
String? userName(UserNameRef ref) {
  final userData = ref.watch(userDataProvider);
  return userData.when(
    loading: () => null,
    error: (_, __) => null,
    data: (d) => d['name'],
  );
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
