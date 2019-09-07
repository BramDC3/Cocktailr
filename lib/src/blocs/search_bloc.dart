import 'package:cocktailr/src/bases/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BlocBase {
  final _keyword = PublishSubject<String>();

  Stream<String> get keyword => _keyword.stream;

  Function(String) get changeKeyword => _keyword.sink.add;

  @override
  void dispose() {
    _keyword.close();
  }
}
