class AppError {
  final String errorMsg;
  static const unknown = Unknown();

  AppError(this.errorMsg);
}

class Unknown implements AppError {
  const Unknown();

  @override
  String get errorMsg => 'default_error';
}
