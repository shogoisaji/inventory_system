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
String _$stockTypeHash() => r'd1defb54c091d09bd1684eb7a469420bc9033249';

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
String _$detailProductHash() => r'5f9b211b37d20f6a34a9aeabb75c8618419eb694';

/// See also [DetailProduct].
@ProviderFor(DetailProduct)
final detailProductProvider =
    AutoDisposeNotifierProvider<DetailProduct, String>.internal(
  DetailProduct.new,
  name: r'detailProductProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$detailProductHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DetailProduct = AutoDisposeNotifier<String>;
String _$imageFileHash() => r'74809ddb6fe8f15e7dc08e4b339c093e235f52b6';

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
