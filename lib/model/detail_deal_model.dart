import 'package:equatable/equatable.dart';

class DetailDeal extends Equatable {
  final int index;
  final String id;

  const DetailDeal({this.index, this.id});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [index, id];
}