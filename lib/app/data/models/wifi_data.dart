class WifiData {
  String name;
  String password;
  String type;

  WifiData({
    required this.name,
    required this.password,
    required this.type,
  });

  @override
  String toString() {
    return '''
    Name: $name
    Password: $password
    Type: $type
    ''';
  }

  static WifiData parseWifiData(String wifiString) {
    // Remove the "WIFI:" prefix and split the string by semicolons
    final parts = wifiString.replaceFirst('WIFI:', '').split(';');

    // Extract key-value pairs
    String name = '';
    String password = '';
    String type = '';

    for (var part in parts) {
      if (part.startsWith('S:')) {
        name = part.substring(2);
      } else if (part.startsWith('T:')) {
        type = part.substring(2);
      } else if (part.startsWith('P:')) {
        password = part.substring(2);
      }
    }

    return WifiData(
      name: name.replaceAll(';', ''),
      password: password.replaceAll(';', ''),
      type: type,
    );
  }
}
