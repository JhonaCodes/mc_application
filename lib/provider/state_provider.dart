import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum StateProviderType{
  creating,
  created,
  error,
  cancel,
  none
}

/// It is not a recommended implementation but it is an option worth keeping in mind, safer than [useState] 🤢🤮
///
/// No use this way of implementation in your project.
/// It is only a possibility if you are not a lover of [StatefulWidget].
/// Whenever you need to manage local state, try using [StatefulWidget].
/// But If you need to manage global state, try using [ChangeNotifierProvider].

class CreatingState with ChangeNotifier{
  StateProviderType _isCreating = StateProviderType.created;

  StateProviderType get isCreating => _isCreating;

  void setCreating(StateProviderType value) {
    _isCreating = value;
    notifyListeners();
  }

  bool get isCreated => isCreating == StateProviderType.created;
}


final creatingState = ChangeNotifierProvider<CreatingState>((ref) {
  log("CreatingState.ChangeNotifierProvider");
  return CreatingState();
});