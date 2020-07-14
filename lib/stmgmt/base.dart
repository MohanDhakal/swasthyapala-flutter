import 'package:flutter/cupertino.dart';
import 'package:swasthyapala_flutter/enum/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}