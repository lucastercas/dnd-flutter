import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp({String username, String email, String password}) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = authResult.user;
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = username;
    await user.updateProfile(updateInfo);
    final currentUser = await _firebaseAuth.currentUser();
    await currentUser.reload();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // To-Do: How to check if user still exists?
  Future<bool> isSignedIn() async {
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    currentUser.reload();
    // IdTokenResult idToken = await currentUser.getIdToken(refresh: true);
    return currentUser != null;
  }

  Future<Map<String, dynamic>> getUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return {
      "uid": user.uid,
      "email": user.email,
      "displayName": user.displayName != null ? user.displayName : ""
    };
  }
}
