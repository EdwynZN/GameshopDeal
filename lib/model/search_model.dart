import 'package:equatable/equatable.dart';

class SearchModel extends Equatable{
  final bool exact;
  final String title;

  SearchModel({this.exact, this.title});

  Map<String, dynamic> toMap() => <String, dynamic>{
    'title': title,
    if(exact) 'exact': exact
  };

  @override
  List<Object> get props => [exact, title];

  @override
  bool get stringify => true;
}