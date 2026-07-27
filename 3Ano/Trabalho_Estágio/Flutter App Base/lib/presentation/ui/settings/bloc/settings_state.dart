part of 'settings_bloc.dart';

enum SettingsStatus { initial, error, loading, loaded, goToHome }

extension SettingsStatusX on SettingsStatus {
  bool get isInitial => this == SettingsStatus.initial;

  bool get isError => this == SettingsStatus.error;

  bool get isLoading => this == SettingsStatus.loading;

  bool get isLoaded => this == SettingsStatus.loaded;

  bool get isGoToHome => this == SettingsStatus.goToHome;
}

class SettingsState extends Equatable {
  const SettingsState({this.status = SettingsStatus.initial, this.name = ''});

  final SettingsStatus status;
  final String name;

  SettingsState copyWith({SettingsStatus? status, String? name}) {
    var result = SettingsState(
      status: status ?? this.status,
      name: name ?? this.name,
    );
    return result;
  }

  @override
  List<Object?> get props => [status, name];
}
