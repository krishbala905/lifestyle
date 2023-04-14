import 'dart:async';

import 'package:rxdart/subjects.dart';

class LoadingWebPageBloc  {
//Controllers
  final BehaviorSubject<bool> _loadingWebPageController = BehaviorSubject<bool>.seeded(true);

  //Sinks
  Function(bool) get changeLoadingWebPage => _loadingWebPageController.sink.add;

  //Streams
  Stream<bool> get loadingWebPageStream => _loadingWebPageController.stream.asBroadcastStream();

  @override
  void dispose() {
    _loadingWebPageController.close();
    dispose();
  }
}