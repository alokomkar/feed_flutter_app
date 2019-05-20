
import 'package:feed_flutter_app/ui/base/state_data_widget.dart';
import 'package:feed_flutter_app/ui/model/state.dart';
import 'package:flutter/material.dart';

class StateWidget extends StatefulWidget {

  final StateModel stateModel;
  final Widget child;

  StateWidget({
    @required this.child,
    this.stateModel
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static StateWidgetState of(BuildContext context)
    => (context.inheritFromWidgetOfExactType(StateDataWidget)
    as StateDataWidget).data;

  @override
  State<StatefulWidget> createState() => new StateWidgetState();

}