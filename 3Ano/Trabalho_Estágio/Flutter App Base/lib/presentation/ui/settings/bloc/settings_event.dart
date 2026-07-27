part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();

  @override
  List<Object> get props => [];
}

class SaveDataSettingsEvent extends SettingsEvent {
  final String name;

  const SaveDataSettingsEvent(this.name);

  @override
  List<Object> get props => [];
}

class ClearDataSettingsEvent extends SettingsEvent {
  const ClearDataSettingsEvent();

  @override
  List<Object> get props => [];
}
