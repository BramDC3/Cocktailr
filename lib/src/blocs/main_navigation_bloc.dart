import 'package:cocktailr/src/models/bases/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class MainNavigationBloc extends BlocBase {
  final _currentIndex = BehaviorSubject<int>();

  Stream<int> get currentIndex => _currentIndex.stream;

  Function(int) get changeCurrentIndex => _currentIndex.sink.add;

  @override
  void dispose() {
    _currentIndex.close();
  }
}
