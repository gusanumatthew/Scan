import 'package:alome/src/features/authentication/models/app_user.dart';
import 'package:alome/src/repositories/user_repository.dart';
import 'package:alome/src/services/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class AuthenticationRepository {
  final Reader reader;

  AuthenticationRepository(this.reader);
  User? get currentUser => FirebaseAuth.instance.currentUser;

//Register
  Future<AppUser> registerRepository({
    required String email,
    required String displayName,
    required String password,
  }) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
      await reader(userRepository).createUserWithId(credential.user!.uid,
          userName: displayName, email: email);

      /// await credential.user!.sendEmailVerification();
      return reader(userRepository).getFutureUser(credential.user!.uid);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

//Sign in
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if (!credential.user!.emailVerified) {
      //   await FirebaseAuth.instance.signOut();
      //   throw const Failure('Email is not verified');
      // }
      return reader(userRepository).getFutureUser(credential.user!.uid);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

//Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

final authenticationRepository = Provider(
  (ref) => AuthenticationRepository(ref.read),
);
