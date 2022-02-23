import 'application/domain/models/application_config.dart';
import 'main.dart';

void main() async {
  commonMain(
    ApplicationConfig(
      apiKey:
          'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCTyQ69YqNkzFqnpR33K7t3AmwVk0zfnAmCyKKqG3VgfEUtLpH7pyOQgKV1gp06C2xnp1jN6xeHF8AssTZer0dWcw5O7hQ8oLG5J7xY8w2HtzAeB7o1234+cYx2J8D8aIBwVVA3YHo66PnA6A8XOAZHgKCFuC/UrW4TnrujbQA71wIDAQAB',
      apiUrl: 'http://actiontrak.net:80',
      isApiLoggingEnabled: false,
      isApiDebuggerEnabled: false,
      isUiDebuggerEnabled: false,
      isProxyEnabled: false,
      baseContentUrl: 'actiontrak.net:80',
    ),
  );
}
