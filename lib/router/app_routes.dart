enum AppRoutes {
  home('home', '/home'),
  selected('selected', '/selected');

  final String name;
  final String path;

  const AppRoutes(this.name, this.path);
}
