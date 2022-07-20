import 'package:bloc/bloc.dart';

class BlocsObservers extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    //print('${bloc.runtimeType} $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    //print(bloc);
    //print(event);
  }
}
