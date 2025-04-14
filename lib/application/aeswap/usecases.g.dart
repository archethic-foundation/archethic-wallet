// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usecases.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addLiquidityCaseHash() => r'df6f7e560fe94ec2340cd9018846184b1641b10d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [addLiquidityCase].
@ProviderFor(addLiquidityCase)
const addLiquidityCaseProvider = AddLiquidityCaseFamily();

/// See also [addLiquidityCase].
class AddLiquidityCaseFamily extends Family<AddLiquidityCase> {
  /// See also [addLiquidityCase].
  const AddLiquidityCaseFamily();

  /// See also [addLiquidityCase].
  AddLiquidityCaseProvider call(
    int blockchainTxVersion,
  ) {
    return AddLiquidityCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  AddLiquidityCaseProvider getProviderOverride(
    covariant AddLiquidityCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addLiquidityCaseProvider';
}

/// See also [addLiquidityCase].
class AddLiquidityCaseProvider extends AutoDisposeProvider<AddLiquidityCase> {
  /// See also [addLiquidityCase].
  AddLiquidityCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => addLiquidityCase(
            ref as AddLiquidityCaseRef,
            blockchainTxVersion,
          ),
          from: addLiquidityCaseProvider,
          name: r'addLiquidityCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addLiquidityCaseHash,
          dependencies: AddLiquidityCaseFamily._dependencies,
          allTransitiveDependencies:
              AddLiquidityCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  AddLiquidityCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    AddLiquidityCase Function(AddLiquidityCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddLiquidityCaseProvider._internal(
        (ref) => create(ref as AddLiquidityCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AddLiquidityCase> createElement() {
    return _AddLiquidityCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddLiquidityCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddLiquidityCaseRef on AutoDisposeProviderRef<AddLiquidityCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _AddLiquidityCaseProviderElement
    extends AutoDisposeProviderElement<AddLiquidityCase>
    with AddLiquidityCaseRef {
  _AddLiquidityCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as AddLiquidityCaseProvider).blockchainTxVersion;
}

String _$claimFarmLockCaseHash() => r'ec60ef9d8a9c38bcc6293b1e6172d7f6edbfaad5';

/// See also [claimFarmLockCase].
@ProviderFor(claimFarmLockCase)
const claimFarmLockCaseProvider = ClaimFarmLockCaseFamily();

/// See also [claimFarmLockCase].
class ClaimFarmLockCaseFamily extends Family<ClaimFarmLockCase> {
  /// See also [claimFarmLockCase].
  const ClaimFarmLockCaseFamily();

  /// See also [claimFarmLockCase].
  ClaimFarmLockCaseProvider call(
    int blockchainTxVersion,
  ) {
    return ClaimFarmLockCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  ClaimFarmLockCaseProvider getProviderOverride(
    covariant ClaimFarmLockCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'claimFarmLockCaseProvider';
}

/// See also [claimFarmLockCase].
class ClaimFarmLockCaseProvider extends AutoDisposeProvider<ClaimFarmLockCase> {
  /// See also [claimFarmLockCase].
  ClaimFarmLockCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => claimFarmLockCase(
            ref as ClaimFarmLockCaseRef,
            blockchainTxVersion,
          ),
          from: claimFarmLockCaseProvider,
          name: r'claimFarmLockCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$claimFarmLockCaseHash,
          dependencies: ClaimFarmLockCaseFamily._dependencies,
          allTransitiveDependencies:
              ClaimFarmLockCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  ClaimFarmLockCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    ClaimFarmLockCase Function(ClaimFarmLockCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClaimFarmLockCaseProvider._internal(
        (ref) => create(ref as ClaimFarmLockCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ClaimFarmLockCase> createElement() {
    return _ClaimFarmLockCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClaimFarmLockCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClaimFarmLockCaseRef on AutoDisposeProviderRef<ClaimFarmLockCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _ClaimFarmLockCaseProviderElement
    extends AutoDisposeProviderElement<ClaimFarmLockCase>
    with ClaimFarmLockCaseRef {
  _ClaimFarmLockCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as ClaimFarmLockCaseProvider).blockchainTxVersion;
}

String _$depositFarmLockCaseHash() =>
    r'd7e1a6e6835bed55f47fcbe922487fb44d4fd49f';

/// See also [depositFarmLockCase].
@ProviderFor(depositFarmLockCase)
const depositFarmLockCaseProvider = DepositFarmLockCaseFamily();

/// See also [depositFarmLockCase].
class DepositFarmLockCaseFamily extends Family<DepositFarmLockCase> {
  /// See also [depositFarmLockCase].
  const DepositFarmLockCaseFamily();

  /// See also [depositFarmLockCase].
  DepositFarmLockCaseProvider call(
    int blockchainTxVersion,
  ) {
    return DepositFarmLockCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  DepositFarmLockCaseProvider getProviderOverride(
    covariant DepositFarmLockCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'depositFarmLockCaseProvider';
}

/// See also [depositFarmLockCase].
class DepositFarmLockCaseProvider
    extends AutoDisposeProvider<DepositFarmLockCase> {
  /// See also [depositFarmLockCase].
  DepositFarmLockCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => depositFarmLockCase(
            ref as DepositFarmLockCaseRef,
            blockchainTxVersion,
          ),
          from: depositFarmLockCaseProvider,
          name: r'depositFarmLockCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$depositFarmLockCaseHash,
          dependencies: DepositFarmLockCaseFamily._dependencies,
          allTransitiveDependencies:
              DepositFarmLockCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  DepositFarmLockCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    DepositFarmLockCase Function(DepositFarmLockCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DepositFarmLockCaseProvider._internal(
        (ref) => create(ref as DepositFarmLockCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DepositFarmLockCase> createElement() {
    return _DepositFarmLockCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DepositFarmLockCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DepositFarmLockCaseRef on AutoDisposeProviderRef<DepositFarmLockCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _DepositFarmLockCaseProviderElement
    extends AutoDisposeProviderElement<DepositFarmLockCase>
    with DepositFarmLockCaseRef {
  _DepositFarmLockCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as DepositFarmLockCaseProvider).blockchainTxVersion;
}

String _$levelUpFarmLockCaseHash() =>
    r'59f34a1f018f0da1fc40fcd39406088d829260f8';

/// See also [levelUpFarmLockCase].
@ProviderFor(levelUpFarmLockCase)
const levelUpFarmLockCaseProvider = LevelUpFarmLockCaseFamily();

/// See also [levelUpFarmLockCase].
class LevelUpFarmLockCaseFamily extends Family<LevelUpFarmLockCase> {
  /// See also [levelUpFarmLockCase].
  const LevelUpFarmLockCaseFamily();

  /// See also [levelUpFarmLockCase].
  LevelUpFarmLockCaseProvider call(
    int blockchainTxVersion,
  ) {
    return LevelUpFarmLockCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  LevelUpFarmLockCaseProvider getProviderOverride(
    covariant LevelUpFarmLockCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'levelUpFarmLockCaseProvider';
}

/// See also [levelUpFarmLockCase].
class LevelUpFarmLockCaseProvider
    extends AutoDisposeProvider<LevelUpFarmLockCase> {
  /// See also [levelUpFarmLockCase].
  LevelUpFarmLockCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => levelUpFarmLockCase(
            ref as LevelUpFarmLockCaseRef,
            blockchainTxVersion,
          ),
          from: levelUpFarmLockCaseProvider,
          name: r'levelUpFarmLockCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$levelUpFarmLockCaseHash,
          dependencies: LevelUpFarmLockCaseFamily._dependencies,
          allTransitiveDependencies:
              LevelUpFarmLockCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  LevelUpFarmLockCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    LevelUpFarmLockCase Function(LevelUpFarmLockCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LevelUpFarmLockCaseProvider._internal(
        (ref) => create(ref as LevelUpFarmLockCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<LevelUpFarmLockCase> createElement() {
    return _LevelUpFarmLockCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LevelUpFarmLockCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LevelUpFarmLockCaseRef on AutoDisposeProviderRef<LevelUpFarmLockCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _LevelUpFarmLockCaseProviderElement
    extends AutoDisposeProviderElement<LevelUpFarmLockCase>
    with LevelUpFarmLockCaseRef {
  _LevelUpFarmLockCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as LevelUpFarmLockCaseProvider).blockchainTxVersion;
}

String _$removeLiquidityCaseHash() =>
    r'8f4540f204d38471aca1a1aea7a39661f03af23c';

/// See also [removeLiquidityCase].
@ProviderFor(removeLiquidityCase)
const removeLiquidityCaseProvider = RemoveLiquidityCaseFamily();

/// See also [removeLiquidityCase].
class RemoveLiquidityCaseFamily extends Family<RemoveLiquidityCase> {
  /// See also [removeLiquidityCase].
  const RemoveLiquidityCaseFamily();

  /// See also [removeLiquidityCase].
  RemoveLiquidityCaseProvider call(
    int blockchainTxVersion,
  ) {
    return RemoveLiquidityCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  RemoveLiquidityCaseProvider getProviderOverride(
    covariant RemoveLiquidityCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'removeLiquidityCaseProvider';
}

/// See also [removeLiquidityCase].
class RemoveLiquidityCaseProvider
    extends AutoDisposeProvider<RemoveLiquidityCase> {
  /// See also [removeLiquidityCase].
  RemoveLiquidityCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => removeLiquidityCase(
            ref as RemoveLiquidityCaseRef,
            blockchainTxVersion,
          ),
          from: removeLiquidityCaseProvider,
          name: r'removeLiquidityCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeLiquidityCaseHash,
          dependencies: RemoveLiquidityCaseFamily._dependencies,
          allTransitiveDependencies:
              RemoveLiquidityCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  RemoveLiquidityCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    RemoveLiquidityCase Function(RemoveLiquidityCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveLiquidityCaseProvider._internal(
        (ref) => create(ref as RemoveLiquidityCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<RemoveLiquidityCase> createElement() {
    return _RemoveLiquidityCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveLiquidityCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemoveLiquidityCaseRef on AutoDisposeProviderRef<RemoveLiquidityCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _RemoveLiquidityCaseProviderElement
    extends AutoDisposeProviderElement<RemoveLiquidityCase>
    with RemoveLiquidityCaseRef {
  _RemoveLiquidityCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as RemoveLiquidityCaseProvider).blockchainTxVersion;
}

String _$swapCaseHash() => r'bd73fd410daf6719d710dc0e5a2f65abc2fc0cf8';

/// See also [swapCase].
@ProviderFor(swapCase)
const swapCaseProvider = SwapCaseFamily();

/// See also [swapCase].
class SwapCaseFamily extends Family<SwapCase> {
  /// See also [swapCase].
  const SwapCaseFamily();

  /// See also [swapCase].
  SwapCaseProvider call(
    int blockchainTxVersion,
  ) {
    return SwapCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  SwapCaseProvider getProviderOverride(
    covariant SwapCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'swapCaseProvider';
}

/// See also [swapCase].
class SwapCaseProvider extends AutoDisposeProvider<SwapCase> {
  /// See also [swapCase].
  SwapCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => swapCase(
            ref as SwapCaseRef,
            blockchainTxVersion,
          ),
          from: swapCaseProvider,
          name: r'swapCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$swapCaseHash,
          dependencies: SwapCaseFamily._dependencies,
          allTransitiveDependencies: SwapCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  SwapCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    SwapCase Function(SwapCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SwapCaseProvider._internal(
        (ref) => create(ref as SwapCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<SwapCase> createElement() {
    return _SwapCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SwapCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SwapCaseRef on AutoDisposeProviderRef<SwapCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _SwapCaseProviderElement extends AutoDisposeProviderElement<SwapCase>
    with SwapCaseRef {
  _SwapCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as SwapCaseProvider).blockchainTxVersion;
}

String _$withdrawFarmLockCaseHash() =>
    r'9d6d8827ea62d8fa1f6a74e86bede4fb8a054546';

/// See also [withdrawFarmLockCase].
@ProviderFor(withdrawFarmLockCase)
const withdrawFarmLockCaseProvider = WithdrawFarmLockCaseFamily();

/// See also [withdrawFarmLockCase].
class WithdrawFarmLockCaseFamily extends Family<WithdrawFarmLockCase> {
  /// See also [withdrawFarmLockCase].
  const WithdrawFarmLockCaseFamily();

  /// See also [withdrawFarmLockCase].
  WithdrawFarmLockCaseProvider call(
    int blockchainTxVersion,
  ) {
    return WithdrawFarmLockCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  WithdrawFarmLockCaseProvider getProviderOverride(
    covariant WithdrawFarmLockCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'withdrawFarmLockCaseProvider';
}

/// See also [withdrawFarmLockCase].
class WithdrawFarmLockCaseProvider
    extends AutoDisposeProvider<WithdrawFarmLockCase> {
  /// See also [withdrawFarmLockCase].
  WithdrawFarmLockCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => withdrawFarmLockCase(
            ref as WithdrawFarmLockCaseRef,
            blockchainTxVersion,
          ),
          from: withdrawFarmLockCaseProvider,
          name: r'withdrawFarmLockCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$withdrawFarmLockCaseHash,
          dependencies: WithdrawFarmLockCaseFamily._dependencies,
          allTransitiveDependencies:
              WithdrawFarmLockCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  WithdrawFarmLockCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    WithdrawFarmLockCase Function(WithdrawFarmLockCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WithdrawFarmLockCaseProvider._internal(
        (ref) => create(ref as WithdrawFarmLockCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<WithdrawFarmLockCase> createElement() {
    return _WithdrawFarmLockCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WithdrawFarmLockCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WithdrawFarmLockCaseRef on AutoDisposeProviderRef<WithdrawFarmLockCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _WithdrawFarmLockCaseProviderElement
    extends AutoDisposeProviderElement<WithdrawFarmLockCase>
    with WithdrawFarmLockCaseRef {
  _WithdrawFarmLockCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as WithdrawFarmLockCaseProvider).blockchainTxVersion;
}

String _$addFundsBeginnerCaseHash() =>
    r'533ea5ed0c963865ae16e75322c4cf7ee05cce9a';

/// See also [addFundsBeginnerCase].
@ProviderFor(addFundsBeginnerCase)
const addFundsBeginnerCaseProvider = AddFundsBeginnerCaseFamily();

/// See also [addFundsBeginnerCase].
class AddFundsBeginnerCaseFamily extends Family<AddFundsBeginnerCase> {
  /// See also [addFundsBeginnerCase].
  const AddFundsBeginnerCaseFamily();

  /// See also [addFundsBeginnerCase].
  AddFundsBeginnerCaseProvider call(
    int blockchainTxVersion,
  ) {
    return AddFundsBeginnerCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  AddFundsBeginnerCaseProvider getProviderOverride(
    covariant AddFundsBeginnerCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addFundsBeginnerCaseProvider';
}

/// See also [addFundsBeginnerCase].
class AddFundsBeginnerCaseProvider
    extends AutoDisposeProvider<AddFundsBeginnerCase> {
  /// See also [addFundsBeginnerCase].
  AddFundsBeginnerCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => addFundsBeginnerCase(
            ref as AddFundsBeginnerCaseRef,
            blockchainTxVersion,
          ),
          from: addFundsBeginnerCaseProvider,
          name: r'addFundsBeginnerCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addFundsBeginnerCaseHash,
          dependencies: AddFundsBeginnerCaseFamily._dependencies,
          allTransitiveDependencies:
              AddFundsBeginnerCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  AddFundsBeginnerCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    AddFundsBeginnerCase Function(AddFundsBeginnerCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddFundsBeginnerCaseProvider._internal(
        (ref) => create(ref as AddFundsBeginnerCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AddFundsBeginnerCase> createElement() {
    return _AddFundsBeginnerCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddFundsBeginnerCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddFundsBeginnerCaseRef on AutoDisposeProviderRef<AddFundsBeginnerCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _AddFundsBeginnerCaseProviderElement
    extends AutoDisposeProviderElement<AddFundsBeginnerCase>
    with AddFundsBeginnerCaseRef {
  _AddFundsBeginnerCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as AddFundsBeginnerCaseProvider).blockchainTxVersion;
}

String _$withdrawFundsBeginnerCaseHash() =>
    r'7dc6e811b8b1e580c938ade3623ad7176866dc74';

/// See also [withdrawFundsBeginnerCase].
@ProviderFor(withdrawFundsBeginnerCase)
const withdrawFundsBeginnerCaseProvider = WithdrawFundsBeginnerCaseFamily();

/// See also [withdrawFundsBeginnerCase].
class WithdrawFundsBeginnerCaseFamily
    extends Family<WithdrawFundsBeginnerCase> {
  /// See also [withdrawFundsBeginnerCase].
  const WithdrawFundsBeginnerCaseFamily();

  /// See also [withdrawFundsBeginnerCase].
  WithdrawFundsBeginnerCaseProvider call(
    int blockchainTxVersion,
  ) {
    return WithdrawFundsBeginnerCaseProvider(
      blockchainTxVersion,
    );
  }

  @override
  WithdrawFundsBeginnerCaseProvider getProviderOverride(
    covariant WithdrawFundsBeginnerCaseProvider provider,
  ) {
    return call(
      provider.blockchainTxVersion,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'withdrawFundsBeginnerCaseProvider';
}

/// See also [withdrawFundsBeginnerCase].
class WithdrawFundsBeginnerCaseProvider
    extends AutoDisposeProvider<WithdrawFundsBeginnerCase> {
  /// See also [withdrawFundsBeginnerCase].
  WithdrawFundsBeginnerCaseProvider(
    int blockchainTxVersion,
  ) : this._internal(
          (ref) => withdrawFundsBeginnerCase(
            ref as WithdrawFundsBeginnerCaseRef,
            blockchainTxVersion,
          ),
          from: withdrawFundsBeginnerCaseProvider,
          name: r'withdrawFundsBeginnerCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$withdrawFundsBeginnerCaseHash,
          dependencies: WithdrawFundsBeginnerCaseFamily._dependencies,
          allTransitiveDependencies:
              WithdrawFundsBeginnerCaseFamily._allTransitiveDependencies,
          blockchainTxVersion: blockchainTxVersion,
        );

  WithdrawFundsBeginnerCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.blockchainTxVersion,
  }) : super.internal();

  final int blockchainTxVersion;

  @override
  Override overrideWith(
    WithdrawFundsBeginnerCase Function(WithdrawFundsBeginnerCaseRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WithdrawFundsBeginnerCaseProvider._internal(
        (ref) => create(ref as WithdrawFundsBeginnerCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        blockchainTxVersion: blockchainTxVersion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<WithdrawFundsBeginnerCase> createElement() {
    return _WithdrawFundsBeginnerCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WithdrawFundsBeginnerCaseProvider &&
        other.blockchainTxVersion == blockchainTxVersion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, blockchainTxVersion.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WithdrawFundsBeginnerCaseRef
    on AutoDisposeProviderRef<WithdrawFundsBeginnerCase> {
  /// The parameter `blockchainTxVersion` of this provider.
  int get blockchainTxVersion;
}

class _WithdrawFundsBeginnerCaseProviderElement
    extends AutoDisposeProviderElement<WithdrawFundsBeginnerCase>
    with WithdrawFundsBeginnerCaseRef {
  _WithdrawFundsBeginnerCaseProviderElement(super.provider);

  @override
  int get blockchainTxVersion =>
      (origin as WithdrawFundsBeginnerCaseProvider).blockchainTxVersion;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
