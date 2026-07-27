import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int? weight;
  final int? height;

  final List<String>? types;

  final Map<String, int>? stats;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.types,
    this.stats,
    this.height,
    this.weight,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, types, stats, height, weight];
}
