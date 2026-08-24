import 'package:config/env/env.dart';

class Timeouts {
  Timeouts();

  final Env _env = Env();

  int get connect => _env.getInt('CONNECT_TIMEOUT_MS', defaultValue: 15000);
  int get receive => _env.getInt('RECEIVE_TIMEOUT_MS', defaultValue: 15000);
  int get send => _env.getInt('SEND_TIMEOUT_MS', defaultValue: 15000);
}
