class AppEndpoints {
  // Authentication
  static const String register = 'register';
  static const String login = 'login';
  static const String forgetPassword = 'forget-password';
  static const String checkForgetPassword = 'check-forget-password';
  static const String resetPassword = 'reset-password';

  // Products
  static const String getBestSellers = 'products-bestseller';
  static const String getSliders = 'sliders';
  static const String getAllProducts = 'products';
  static const String getNewArrivals = 'products-new-arrivals';
  static const String showCategories = 'categories';


  // Wishlist
  static const String getWishlist = 'wishlist';
  static const String addToWishlist = 'add-to-wishlist';
  static const String removeFromWishlist = 'remove-from-wishlist';

  // Cart
  static const String cart = 'cart';
  static const String addToCart = 'add-to-cart';
  static const String removeFromCart = 'remove-from-cart';
  static const String updateCart = 'update-cart';

  // Profile
  static const String profile = 'profile';
  static const String updateProfile = 'update-profile';
  static const String updatePassword = 'update-password';
  static const String contactUs = 'contact-us';
}
