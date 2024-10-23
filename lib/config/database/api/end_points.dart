class EndPoints {
  //basic urls
  static const String baseUrl = 'https://ama.runasp.net/api/';
  static const String prefixToken = 'Bearer';
  static const String images = "";

  //auth
  static const String accounts = "accounts/";
  static const String forgetPassword = "${accounts}login";
  static const String resetPassword = "";
  static const String login = "${accounts}login";
  static const String register = "${accounts}signup/customer";
  static const String checkEmail = "${accounts}checkEmail";
  static const String refreshToken = "${accounts}refresh-token";
  //ads
  static const String ads = "";

  //offers
  static const String offers = "";

  //products
  static const String products = "products";
  static const String bestSellerProducts = "$products/top-popular";
  static const String recommendationProducts = "$products/recommended";
  static const String productsSearch = "$products/search";

  //categories
  static const String categories = "categories";
  static const String categoriesWithSubCategoriesAndBrands = "$categories/sub-categories-and-brands";
  //wishlist
  static const String wishlist = "wishlist";

  //cart
  static const String cartProducts = "carts";

  //address
  static const String address = "addresses";

  //orders
  static const String orders = "orders";

  //coupons
  static const String checkCoupon = "coupons/check-coupon";
  //checkout
  static const String checkout = "checkout";
  static const String checkoutCard = "$checkout/card";
  static const String checkoutCash = "$checkout/cash";

  //chat
  static const String chat = "https://ama.runasp.net/chat";
}

class ApiKeys {
  static const String email = "email";
  static const String password = "password";
  static const String rePassword = "rePassword";
  static const String newPassword = 'newPassword';
  static const String oldPassword = 'oldPassword';
  static const String confirmPassword = 'confirmPassword';
  static const String message = "message";
  static const String token = "token";
  static const String name = "name";
  static const String phone = "phone";
  static const String image = "image";
  static const String age = "age";
  static const String coordinates = "coordinates";
  static const String location = "location";
  static const String otpSecret = "otpSecret";
}
