import 'package:config/env/env.dart';

class ApiUrls {
  ApiUrls();

  final Env _env = Env();

  String get base => _env.getString('API_BASE_URL');
}
