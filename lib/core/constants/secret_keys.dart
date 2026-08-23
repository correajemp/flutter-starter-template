import 'package:flutter_starter_template/config/env/env.dart';

class SecretKeys {
  SecretKeys();

  final Env _env = Env();

  String get googleServerClientId => _env.getString('GOOGLE_SERVER_CLIENT_ID');
  String get googleIosClientId => _env.getString('GOOGLE_IOS_CLIENT_ID');
}
