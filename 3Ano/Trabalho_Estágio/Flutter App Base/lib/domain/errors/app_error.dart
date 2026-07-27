class AppError {
  final String errorMsg = 'default_error';
  static const unknown = Unknown();
}

class Unknown implements AppError {
  const Unknown();

  @override
  String get errorMsg => 'default_error';
}
