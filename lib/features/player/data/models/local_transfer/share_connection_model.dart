import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';

class ShareConnectionModel {
  final String ip;
  final int port;
  final String token;

  const ShareConnectionModel({
    required this.ip,
    required this.port,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {'ip': ip, 'port': port, 'token': token};
  }

  factory ShareConnectionModel.fromJson(Map<String, dynamic> json) {
    return ShareConnectionModel(
      ip: json['ip'] as String,
      port: json['port'] as int,
      token: json['token'] as String,
    );
  }

  factory ShareConnectionModel.fromEntity(ShareConnectionEntity entity) {
    return ShareConnectionModel(
      ip: entity.ip,
      port: entity.port,
      token: entity.token,
    );
  }

  ShareConnectionEntity toEntity() {
    return ShareConnectionEntity(ip: ip, port: port, token: token);
  }
}
