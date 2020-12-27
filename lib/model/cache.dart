import 'package:equatable/equatable.dart';

class Cache extends Equatable{
  final Duration duration;
  final int maxNrOfCacheObjects;
  final String key;

  Cache({
    this.duration = const Duration(days: 15),
    this.maxNrOfCacheObjects: 600,
    this.key: 'Key'
  });

  @override
  List<Object> get props => [
    duration.inMinutes,
    maxNrOfCacheObjects,
    key
  ];

}