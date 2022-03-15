import 'package:bookstoreapp/providers/book.dart';
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
    required List<Book> wishlist,
    required List<Book> orders,
  });

  Future<void> updateWishlist({
    required Book book,
  });
  Future<List<Book>> getOrderList();

  Future<void> logOut();

  Future<void> addToOrderList(
      {required String image,
      required String title,
      required String author,
      required String price});
}
