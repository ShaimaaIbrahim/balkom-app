////////////////////////////////////////////////////////////////////////////////
// Languages
const LANG_AR = 'ar';
const LANG_EN = 'en';
const APP_NAME = "OJOS";

// Headers
const HEADER_LANGUAGE = 'Language';
const HEADER_AUTH = 'Authorization';
const HEADER_CONTENT_TYPE = 'Content-Type';
const HEADER_ACCEPT = 'Accept';

// ====================  APP_NAME API URL ====================
const API_BASE = 'https://bilqom.com/api/auth';
//==========================
//   User Management API
//==========================

const GMS = '+966';
const GET_CATEGORIES= "$API_BASE/categories/";

const API_AUTH = '$API_BASE';
const API_AUTH_REGISTER = '$API_AUTH/register';
const API_AUTH_RESEND_CODE = '$API_AUTH/resend/pin';
const API_AUTH_VERIFY = '$API_AUTH/confirm/otp';
const API_AUTH_LOGIN = '$API_AUTH/login';
const API_AUTH_CHANGE_PASSWORD = '$API_AUTH/change/password';
const API_AUTH_RESET_PASSWORD = '$API_AUTH/reset/password';
const API_AUTH_FORGOT_PASSWORD = '$API_AUTH/forgot/password';

//===============================
//    Profile & Update Profile
//===============================
const API_AUTH_USER_DETAILS = '$API_AUTH/user/detail';
const API_AUTH_UPDATE_PROFILE = '$API_AUTH/user/update';

/// categories
const API_CATEGORY = '$API_BASE';
const API_LISTS_CATEGORIES = '$API_CATEGORY/categories';

/// brands
const API_LISTS_BRANDS = '$API_BASE/brands';
const API_LISTS_NOTIFICATIONS = '$API_BASE/notifications';
const API_LISTS_WALLET_TRANSACTIONS = '$API_BASE/wallet/transactions';
const API_LISTS_FAQS = '$API_BASE/faqs';

/// shipping carriers
const API_LISTS_SHIPPING_CARRIERS = '$API_BASE/shipping_carriers';
const API_LISTS_CITIES = '$API_BASE/cities';
const API_LISTS_PAYMENT_GETWAY = '$API_BASE/getway/payments';

/// Extra Glasses
const API_GET_EXTRA_GLASSES = '$API_BASE/extraglasses';
const API_GET_OFFERS = '$API_BASE/offers';

/// Extra Glasses
const API_PRODUCT = '$API_BASE';
const API_GET_PRODUCTS = '$API_PRODUCT/products';
const API_GET_MY_PRODUCTS = '$API_PRODUCT/myproducts';
const API_GET_SEARCH_TEST = '$API_PRODUCT/searchtest';
const API_GET_PRODUCTS_DETAILS = '$API_PRODUCT/products';
const API_GET_PRODUCTS_FILTER = '$API_PRODUCT/filter_products';
const API_FAVORITES = '$API_PRODUCT/favorites';
const API_REVIEW = '$API_PRODUCT/product_reviews';

API_NEGA({city_id = 1}) {
  return '$API_BASE/neighborhoods?city_id=$city_id';
}

const atteripiot_APi = '$API_BASE/attributes';

/// Cart
const API_CART = '$API_BASE';
const API_EXECUTE_COUPON = '$API_CART/couponcode';

/// Cart
const API_ORDER = '$API_BASE';
const API_GET_ORDER = '$API_ORDER/orders';
const API_SEND_ORDER = '$API_ORDER/orders';
String getOrderDetails(orderId) {
  return '$API_ORDER/orders/$orderId';
}

///settings

const API_SETTINGS = '$API_BASE';
const API_POST_CONTACT_US = '$API_SETTINGS/contact_us';
const API_POST_PROBLEM_MSG = '$API_SETTINGS/problem_send';
const API_POST_SET_NOTIFICATION = '$API_SETTINGS/set_notification';
const API_ABOUT_APP = '$API_SETTINGS/settings';
const API_Membership_APP = '$API_SETTINGS/site/membership';
const API_Privacy_APP = '$API_SETTINGS/site/privacy';

// Keys
const KEY_LANG = 'lang';
const KEY_TOKEN = 'token';
const USER_DATA_LOGIN = 'user_data_login';
const KEY_FCM_TOKEN = 'fcm_token';

const KEY_EXTRA_GLASSES = 'KEY_EXTRA_GLASSES';
const KEY_SELECTED_GENDER_STYLE = 'KEY_SELECTED_GENDER_STYLE';
const KEY_SELECTED_NOTIFY_NEW_PRODUCT = 'notify_new_product';
const KEY_SELECTED_NOTIFY_WALLET = 'notify_wallet';
const KEY_SELECTED_NOTIFY_OFFER = 'notify_offer';

/// Boxes Name
const BOX_EXTRA_GLASSES = 'Extra_Glasses_Box';
const BOX_CATEGORY = 'categories';
const BOX_SHIPPING_CARRIERS = 'shipping_carriers_box';
const BOX_CITY = 'city_box';
const BOX_PAYMENT_METHOD = 'payment_methods_box';
const BOX_Brand = 'BOX_Brand';

/// product query filters
const FILTER_ORDER = 'order';

/// asc
const FILTER_SORT = 'sort';

/// date
const FILTER_IS_NEW = 'isnew';

/// bool
const FILTER_CATEGORY_ID = 'category_id';

/// int
const FILTER_GENDER_ID = 'gender_id';

/// int
const FILTER_TYPE = 'type';

/// int
const FILTER_BRAND_ID = 'brand_id';

/// int
const FILTER_FRAME_SHAPE_ID = 'frameshape_id';

/// int
const FILTER_BEST_SALES = 'bestsalse';

/// int

// //===============================
// //    Auction
// //===============================
// const API_AUTH_AUCTION_LIST = '$API_AUTH/auctionList';
// const API_AUTH_USER_AUCTION_LIST = '$API_AUTH/userAuctionList';
// const API_AUTH_AUCTION_DETAILS = '$API_AUTH/auctionDetails';
// const API_AUTH_AUCTION_ADD_COMMENT = '$API_AUTH/addComment';
//
//
// //===============================
// //    OTHER
// //===============================
// const API_AUTH_ADD_DIAMOND = '$API_AUTH/addDiamondRequest';
// const API_AUTH_ADD_SPARE_PART = '$API_AUTH/addSparePart';
// const API_AUTH_ADD_CONTACT_US = '$API_AUTH/addContactUs';
// const API_AUTH_GET_ABOUT_US = '$API_AUTH/getAboutUs';
// //===============================
// //    BOX_KEY
// //===============================
// const BOX_LIST_COUNTRY = '/CountryCityCallNumberDao';
//
// //==============================================================================
//
// //==============================================================================
//
// const API_FIREBASE_NOTIFICATION = '$API_BASE/firebase-notification';
// const API_LIST_NOTIFICATIONS = 'notification/index';
//
// const API_FIREBASE_NOTIFICATION_CHANGE_LANGUAGE =
//     '$API_FIREBASE_NOTIFICATION/change-application-language';
//
// const API_NOTIFICATION_UPDATE_FIREBASE_TOKEN = '$API_BASE/updateFirebaseToken';

// Message Code types
const MESSAGE_CODE_SUCCESS = 0;
const MESSAGE_CODE_ERROR = 1;
const MESSAGE_CODE_TOKEN_NOT_FOUND = 2;
const MESSAGE_CODE_LOGIN_REQUIRED = 3;
const MESSAGE_CODE_ACCOUNT_NOT_VERIFIED = 4;
const MESSAGE_CODE_OTHER = 5;
// Notifications Channels
const NOTIFICATIONS_CHANNEL_ID = 'global-channel';
const NOTIFICATIONS_CHANNEL_TITLE = 'Global';
const NOTIFICATIONS_CHANNEL_DESCRIPTION = 'Global Channel';

// Notification Type
const int ADD_COMMENTS = 1;
const int ADD_SUBSCRIPTION = 2;
const int ADD_NWE_POST = 3;

const int NOTIFY_AUCTION_BEFORE_HOUR = 4;
const int NOTIFY_AUCTION_ON_TIME = 5;
const int NOTIFICATION_TO_USERS = 6;

//Hive Boxes

const BOX_LIST_NOTIFICATIONS = 'list_notifcations';
