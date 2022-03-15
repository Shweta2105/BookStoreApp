import 'package:bookstoreapp/providers/book.dart';
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
    required List<Book> wishlist,
    required List<Book> orders,
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
  Future<void> updateWishlist({required Book book}) =>
      provider.updateWishlist(book: book);

  @override
  Future<void> addToOrderList(
          {required String image,
          required String title,
          required String author,
          required String price}) =>
      provider.addToOrderList(
          image: image, title: title, author: author, price: price);

  @override
  Future<List<Book>> getOrderList() => provider.getOrderList();
}
