import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/service/auth/auth_user.dart';
import 'package:bookstoreapp/service/auth/auth_provider.dart';
import 'package:bookstoreapp/service/auth/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, UserCredential;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String name,
    required List<Books> wishlist,
    required List<Books> orders,
  }) async {
    try {
      UserCredential data = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      await FirebaseFirestore.instance
          .collection('AuthUsers')
          .doc(data.user!.uid)
          .set({
        'name': name,
        'uid': data.user!.uid,
        'email': email,
        'password': password,
        'wishlist': wishlist,
        'orders': orders
      });

      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
    throw '';
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == ' wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> updateWishlist({Books? book}) async {
    final user = FirebaseAuth.instance.currentUser;

    // final wishlist = await FirebaseFirestore.instance
    //     .collection('AuthUsers')
    //     .doc(user!.uid)
    //     .collection('wishlist')
    //     .add({'wishlist': book});
    // print("${wishlist}");
  }
}
