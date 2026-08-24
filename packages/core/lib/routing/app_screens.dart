enum AppScreens {
  splash('splash'),
  showcase('showcase'),
  authLogin('auth/login'),
  authRegister('auth/register'),
  authWelcome('auth/welcome'),
  authLoginSuccess('auth/login/success'),
  authRegisterSuccess('auth/register/success');

  final String route;

  const AppScreens(this.route);

  String get path => '/$route';
}
