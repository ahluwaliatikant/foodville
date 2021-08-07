import 'package:equatable/equatable.dart';

class MyParameter extends Equatable {
  final String id;
  final bool isUser;

  MyParameter({
    this.id,
    this.isUser
  });

  @override
  List<Object> get props => [id, isUser];
}