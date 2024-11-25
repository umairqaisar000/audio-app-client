// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livekit_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$livekitRoomNotifierHash() =>
    r'8152c930628ac754dc1ff4217d39699e711aad06';

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

/// See also [livekitRoomNotifier].
@ProviderFor(livekitRoomNotifier)
const livekitRoomNotifierProvider = LivekitRoomNotifierFamily();

/// See also [livekitRoomNotifier].
class LivekitRoomNotifierFamily extends Family<Room?> {
  /// See also [livekitRoomNotifier].
  const LivekitRoomNotifierFamily();

  /// See also [livekitRoomNotifier].
  LivekitRoomNotifierProvider call(
    String roomId,
  ) {
    return LivekitRoomNotifierProvider(
      roomId,
    );
  }

  @override
  LivekitRoomNotifierProvider getProviderOverride(
    covariant LivekitRoomNotifierProvider provider,
  ) {
    return call(
      provider.roomId,
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
  String? get name => r'livekitRoomNotifierProvider';
}

/// See also [livekitRoomNotifier].
class LivekitRoomNotifierProvider extends AutoDisposeProvider<Room?> {
  /// See also [livekitRoomNotifier].
  LivekitRoomNotifierProvider(
    String roomId,
  ) : this._internal(
          (ref) => livekitRoomNotifier(
            ref as LivekitRoomNotifierRef,
            roomId,
          ),
          from: livekitRoomNotifierProvider,
          name: r'livekitRoomNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$livekitRoomNotifierHash,
          dependencies: LivekitRoomNotifierFamily._dependencies,
          allTransitiveDependencies:
              LivekitRoomNotifierFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  LivekitRoomNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  Override overrideWith(
    Room? Function(LivekitRoomNotifierRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LivekitRoomNotifierProvider._internal(
        (ref) => create(ref as LivekitRoomNotifierRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Room?> createElement() {
    return _LivekitRoomNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LivekitRoomNotifierProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LivekitRoomNotifierRef on AutoDisposeProviderRef<Room?> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _LivekitRoomNotifierProviderElement
    extends AutoDisposeProviderElement<Room?> with LivekitRoomNotifierRef {
  _LivekitRoomNotifierProviderElement(super.provider);

  @override
  String get roomId => (origin as LivekitRoomNotifierProvider).roomId;
}

String _$livekitRoomsNotifierHash() =>
    r'9452f20f9aec53857781ff4b94904532301fb755';

/// See also [LivekitRoomsNotifier].
@ProviderFor(LivekitRoomsNotifier)
final livekitRoomsNotifierProvider =
    NotifierProvider<LivekitRoomsNotifier, Map<String, Room>>.internal(
  LivekitRoomsNotifier.new,
  name: r'livekitRoomsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$livekitRoomsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LivekitRoomsNotifier = Notifier<Map<String, Room>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
