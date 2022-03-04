import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/service/auth/auth_provider.dart';
import 'package:bookstoreapp/service/auth/auth_user.dart';
import 'package:bookstoreapp/service/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String name,
    required List<Books> wishlist,
    required List<Books> orders,
  }) =>
      provider.createUser(
          email: email,
          password: password,
          name: name,
          wishlist: wishlist,
          orders: orders);

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;
  @override
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> updateWishlist({required Books book}) =>
      provider.updateWishlist(book: book);
}
