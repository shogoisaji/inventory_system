// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userChangesHash() => r'4b418a07a9bb38d37b0f5fe2676bb7f58267eaeb';

///
/// FirebaseのユーザーをAsyncValue型で管理するプロバイダー
///
///
/// Copied from [userChanges].
@ProviderFor(userChanges)
final userChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  userChanges,
  name: r'userChangesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$userHash() => r'3cc9ecd667fcb1fd39e74d498ecab726c98cf46a';

///
/// ユーザー
///
///
/// Copied from [user].
@ProviderFor(user)
final userProvider = AutoDisposeProvider<User?>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeProviderRef<User?>;
String _$signedInHash() => r'ad977544c865550a5f87cfb21ad0a59169bcdd7b';

///
/// サインイン中かどうか
///
///
/// Copied from [signedIn].
@ProviderFor(signedIn)
final signedInProvider = AutoDisposeProvider<bool>.internal(
  signedIn,
  name: r'signedInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignedInRef = AutoDisposeProviderRef<bool>;
String _$userIdHash() => r'b04b6e432625c4a9d6c9643e7f6182a7c53ec8c2';

///
/// ユーザーID
///
///
/// Copied from [userId].
@ProviderFor(userId)
final userIdProvider = AutoDisposeProvider<String>.internal(
  userId,
  name: r'userIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserIdRef = AutoDisposeProviderRef<String>;
String _$userDataHash() => r'3e1ea1559ef4293bed2c29c5a99d296cd026f89e';

/// ユーザー名
///
/// Copied from [userData].
@ProviderFor(userData)
final userDataProvider =
    AutoDisposeStreamProvider<DocumentSnapshot<Object?>>.internal(
  userData,
  name: r'userDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserDataRef = AutoDisposeStreamProviderRef<DocumentSnapshot<Object?>>;
String _$userNameHash() => r'405db1dcc9764720dd6851eaa467c6c0dd443026';

/// See also [userName].
@ProviderFor(userName)
final userNameProvider = AutoDisposeProvider<String?>.internal(
  userName,
  name: r'userNameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserNameRef = AutoDisposeProviderRef<String?>;
String _$productDocumentHash() => r'2a3aa21b1a7c2ca8bb2f4fd2befb1319e0c8f8a5';

/// See also [ProductDocument].
@ProviderFor(ProductDocument)
final productDocumentProvider =
    AutoDisposeNotifierProvider<ProductDocument, String>.internal(
  ProductDocument.new,
  name: r'productDocumentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productDocumentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductDocument = AutoDisposeNotifier<String>;
String _$incrementDialogStateHash() =>
    r'da37992d5bae131a4a7de608431f3f0e55b7ed74';

/// See also [IncrementDialogState].
@ProviderFor(IncrementDialogState)
final incrementDialogStateProvider =
    AutoDisposeNotifierProvider<IncrementDialogState, bool>.internal(
  IncrementDialogState.new,
  name: r'incrementDialogStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$incrementDialogStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncrementDialogState = AutoDisposeNotifier<bool>;
String _$decrementDialogStateHash() =>
    r'f3f5b6e20a4d4f02d318e82f68483b00d658b7b6';

/// See also [DecrementDialogState].
@ProviderFor(DecrementDialogState)
final decrementDialogStateProvider =
    AutoDisposeNotifierProvider<DecrementDialogState, bool>.internal(
  DecrementDialogState.new,
  name: r'decrementDialogStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$decrementDialogStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DecrementDialogState = AutoDisposeNotifier<bool>;
String _$loadingStateHash() => r'c5ad5038b4e4a4ebcf07005df266898fef8c3f06';

/// See also [LoadingState].
@ProviderFor(LoadingState)
final loadingStateProvider =
    AutoDisposeNotifierProvider<LoadingState, bool>.internal(
  LoadingState.new,
  name: r'loadingStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loadingStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoadingState = AutoDisposeNotifier<bool>;
String _$productTypeHash() => r'd02386b8a4d069f31d878c90429d6ea5f3800c0d';

/// See also [ProductType].
@ProviderFor(ProductType)
final productTypeProvider =
    AutoDisposeNotifierProvider<ProductType, String>.internal(
  ProductType.new,
  name: r'productTypeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductType = AutoDisposeNotifier<String>;
String _$stockTypeHash() => r'29c5f7ccc2a2d73dcbef35e2f66d680cfa3e524b';

/// See also [StockType].
@ProviderFor(StockType)
final stockTypeProvider = AutoDisposeNotifierProvider<StockType, int>.internal(
  StockType.new,
  name: r'stockTypeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$stockTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StockType = AutoDisposeNotifier<int>;
String _$imageFileHash() => r'f6166db11721b8a7a762ac35be7a4aaeb3aaf8fa';

/// See also [ImageFile].
@ProviderFor(ImageFile)
final imageFileProvider =
    AutoDisposeNotifierProvider<ImageFile, File?>.internal(
  ImageFile.new,
  name: r'imageFileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$imageFileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImageFile = AutoDisposeNotifier<File?>;
String _$absorbPointerStateHash() =>
    r'200bbfc03fdd807b12dcef29451b96ec38bf7769';

/// See also [AbsorbPointerState].
@ProviderFor(AbsorbPointerState)
final absorbPointerStateProvider =
    AutoDisposeNotifierProvider<AbsorbPointerState, bool>.internal(
  AbsorbPointerState.new,
  name: r'absorbPointerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$absorbPointerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AbsorbPointerState = AutoDisposeNotifier<bool>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
