import "package:json_annotation/json_annotation.dart";

part "version_model.g.dart";

@JsonSerializable()
class VersionModel {
  final int major;
  final int minor;
  final int patch;
  final int build;
  final int buildAt;

  const VersionModel({
    this.major = 1,
    this.minor = 0,
    this.patch = 0,
    this.build = 0,
    this.buildAt = 0,
  });

  String getVersion() {
    return "$major.$minor.$patch";
  }

  bool isBiggerThan(VersionModel version) {
    if (major < version.major) {
      return false;
    }

    if (major > version.major) {
      return true;
    }

    if (minor > version.minor) {
      return true;
    }

    if (minor < version.minor) {
      return false;
    }

    return patch >= version.patch;
  }

  factory VersionModel.fromByteList(List<int> payload) {
    return VersionModel(
      major: payload[0],
      minor: payload[1],
      patch: payload[2],
    );
  }

  factory VersionModel.fromInt(int version) {
    final String payload = "$version".padRight(3, "0");
    return VersionModel(
      major: int.parse(payload[0]),
      minor: int.parse(payload[1]),
      patch: int.parse(payload[2]),
    );
  }

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
