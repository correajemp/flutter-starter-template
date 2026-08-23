enum AppScreens {
  splash('splash'),
  showcase('showcase');

  final String route;

  const AppScreens(this.route);

  String get path => '/$route';
}
