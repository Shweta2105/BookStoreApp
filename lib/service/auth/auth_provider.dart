import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/service/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser?> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String name,
    required List<Books> wishlist,
    required List<Books> orders,
  });

  Future<void> updateWishlist({
    required Books book,
  });
  Future<List<Books>> getOrderList();

  Future<void> logOut();

  Future<void> addToOrderList(
      {required String image,
      required String title,
      required String author,
      required String price});
}
