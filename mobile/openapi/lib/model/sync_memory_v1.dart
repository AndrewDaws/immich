//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SyncMemoryV1 {
  /// Returns a new [SyncMemoryV1] instance.
  SyncMemoryV1({
    required this.createdAt,
    required this.data,
    required this.deletedAt,
    required this.hideAt,
    required this.id,
    required this.isSaved,
    required this.memoryAt,
    required this.ownerId,
    required this.seenAt,
    required this.showAt,
    required this.type,
    required this.updatedAt,
  });

  DateTime createdAt;

  Object data;

  DateTime? deletedAt;

  DateTime? hideAt;

  String id;

  bool isSaved;

  DateTime memoryAt;

  String ownerId;

  DateTime? seenAt;

  DateTime? showAt;

  MemoryType type;

  DateTime updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SyncMemoryV1 &&
    other.createdAt == createdAt &&
    other.data == data &&
    other.deletedAt == deletedAt &&
    other.hideAt == hideAt &&
    other.id == id &&
    other.isSaved == isSaved &&
    other.memoryAt == memoryAt &&
    other.ownerId == ownerId &&
    other.seenAt == seenAt &&
    other.showAt == showAt &&
    other.type == type &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (createdAt.hashCode) +
    (data.hashCode) +
    (deletedAt == null ? 0 : deletedAt!.hashCode) +
    (hideAt == null ? 0 : hideAt!.hashCode) +
    (id.hashCode) +
    (isSaved.hashCode) +
    (memoryAt.hashCode) +
    (ownerId.hashCode) +
    (seenAt == null ? 0 : seenAt!.hashCode) +
    (showAt == null ? 0 : showAt!.hashCode) +
    (type.hashCode) +
    (updatedAt.hashCode);

  @override
  String toString() => 'SyncMemoryV1[createdAt=$createdAt, data=$data, deletedAt=$deletedAt, hideAt=$hideAt, id=$id, isSaved=$isSaved, memoryAt=$memoryAt, ownerId=$ownerId, seenAt=$seenAt, showAt=$showAt, type=$type, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'createdAt'] = this.createdAt.toUtc().toIso8601String();
      json[r'data'] = this.data;
    if (this.deletedAt != null) {
      json[r'deletedAt'] = this.deletedAt!.toUtc().toIso8601String();
    } else {
    //  json[r'deletedAt'] = null;
    }
    if (this.hideAt != null) {
      json[r'hideAt'] = this.hideAt!.toUtc().toIso8601String();
    } else {
    //  json[r'hideAt'] = null;
    }
      json[r'id'] = this.id;
      json[r'isSaved'] = this.isSaved;
      json[r'memoryAt'] = this.memoryAt.toUtc().toIso8601String();
      json[r'ownerId'] = this.ownerId;
    if (this.seenAt != null) {
      json[r'seenAt'] = this.seenAt!.toUtc().toIso8601String();
    } else {
    //  json[r'seenAt'] = null;
    }
    if (this.showAt != null) {
      json[r'showAt'] = this.showAt!.toUtc().toIso8601String();
    } else {
    //  json[r'showAt'] = null;
    }
      json[r'type'] = this.type;
      json[r'updatedAt'] = this.updatedAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [SyncMemoryV1] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SyncMemoryV1? fromJson(dynamic value) {
    upgradeDto(value, "SyncMemoryV1");
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      return SyncMemoryV1(
        createdAt: mapDateTime(json, r'createdAt', r'')!,
        data: mapValueOfType<Object>(json, r'data')!,
        deletedAt: mapDateTime(json, r'deletedAt', r''),
        hideAt: mapDateTime(json, r'hideAt', r''),
        id: mapValueOfType<String>(json, r'id')!,
        isSaved: mapValueOfType<bool>(json, r'isSaved')!,
        memoryAt: mapDateTime(json, r'memoryAt', r'')!,
        ownerId: mapValueOfType<String>(json, r'ownerId')!,
        seenAt: mapDateTime(json, r'seenAt', r''),
        showAt: mapDateTime(json, r'showAt', r''),
        type: MemoryType.fromJson(json[r'type'])!,
        updatedAt: mapDateTime(json, r'updatedAt', r'')!,
      );
    }
    return null;
  }

  static List<SyncMemoryV1> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SyncMemoryV1>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SyncMemoryV1.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SyncMemoryV1> mapFromJson(dynamic json) {
    final map = <String, SyncMemoryV1>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SyncMemoryV1.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SyncMemoryV1-objects as value to a dart map
  static Map<String, List<SyncMemoryV1>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SyncMemoryV1>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SyncMemoryV1.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'createdAt',
    'data',
    'deletedAt',
    'hideAt',
    'id',
    'isSaved',
    'memoryAt',
    'ownerId',
    'seenAt',
    'showAt',
    'type',
    'updatedAt',
  };
}

