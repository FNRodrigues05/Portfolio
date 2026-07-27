part of 'my_home_bloc.dart';

enum MyHomeStatus { initial, error, loading, loaded, goToHome }

extension MyHomeStatusX on MyHomeStatus {
  bool get isInitial => this == MyHomeStatus.initial;

  bool get isError => this == MyHomeStatus.error;

  bool get isLoading => this == MyHomeStatus.loading;

  bool get isLoaded => this == MyHomeStatus.loaded;

  bool get isGoToHome => this == MyHomeStatus.goToHome;
}

class MyHomeState extends Equatable {
  const MyHomeState({
    this.status = MyHomeStatus.initial,
    this.counter = 0,
    this.name = '',
    this.lista = const [],
  });

  final MyHomeStatus status;
  final int counter;
  final String name;
  final List<String> lista;

  MyHomeState copyWith({
    MyHomeStatus? status,
    int? counter,
    String? name,
    List<String>? lista,
  }) {
    var result = MyHomeState(
      status: status ?? this.status,
      counter: counter ?? this.counter,
      name: name ?? this.name,
      lista: lista ?? this.lista,
    );
    return result;
  }

  @override
  List<Object?> get props => [status, counter, name, lista];
}
