
import 'package:feed_flutter_app/ui/base/state_widget.dart';
import 'package:feed_flutter_app/ui/model/state.dart';
import 'package:feed_flutter_app/ui/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StateWidgetState extends State<StateWidget> {

  StateModel state;
  GoogleSignInAccount googleAccount;
  final GoogleSignIn googleSignIn = new GoogleSignIn();


  @override
  void initState() {
    super.initState();
    if (widget.stateModel != null) {
      state = widget.stateModel;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }

  Future<Null> initUser() async {
    googleAccount = await getSignedInAccount(googleSignIn);

    if (googleAccount == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      await signInWithGoogle();
    }

  }

  Future<Null> signInWithGoogle() async {
    if (googleAccount == null) {
      // Start the sign-in process:
      googleAccount = await googleSignIn.signIn();
    }
    FirebaseUser firebaseUser = await signInToFirebase(googleAccount);
    setState(() {
      state.isLoading = false;
      state.user = firebaseUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StateDataWidget(
      data: this,
      child: widget.child,
    );
  }

}

class StateDataWidget extends InheritedWidget {
  final StateWidgetState data;

  StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of StateDataWidget:
  @override
  bool updateShouldNotify(StateDataWidget old) => true;
}