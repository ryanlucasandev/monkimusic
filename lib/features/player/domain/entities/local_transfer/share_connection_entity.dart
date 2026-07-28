class ShareConnectionEntity {
  final String ip;
  final int port;
  final String token;

  const ShareConnectionEntity({
    required this.ip,
    required this.port,
    required this.token,
  });

  String get qrData {
    return 'http://$ip:$port/transfer/$token';
  }
}
