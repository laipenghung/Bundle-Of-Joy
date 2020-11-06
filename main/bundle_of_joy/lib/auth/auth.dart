import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:flutter_facebook_login/flutter_facebook_login.dart";
import 'file:///C:/Users/User/Desktop/Code/Bundle-Of-Joy/main/bundle_of_joy/lib/motherProfile/mother.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FacebookLogin facebookLogin = FacebookLogin();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  if (validateCredential(credential) != null) {
    return validateCredential(credential);
  }

  return null;
}

Future<String> signInWithFacebook() async {
  await Firebase.initializeApp();
  final result = await facebookLogin.logIn(["email"]);
  final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);

  if (validateCredential(credential) != null) {
    return validateCredential(credential);
  }

  return null;
}

Future<String> validateCredential(credential) async {
  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print("Sign in succeeded: $user");
    Mother newMother = new Mother();
    newMother.addUser(user);
    return "$user";
  } else {
    print("User not found");
    return null;
  }
}

signOut() async {
  _auth.signOut();
  print("User Signed Out");
}
