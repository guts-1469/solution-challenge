import '../constant.dart';

final Uri send_otp = Uri.parse(baseUrl + '/consumer/auth/send-otp');
final Uri verify_otp = Uri.parse(baseUrl + '/consumer/auth/verify-otp');
final Uri register_user = Uri.parse(baseUrl + '/consumer/auth/register-account');
final Uri user_activities = Uri.parse(baseUrl + '/consumer/user/activities');
final Uri notifications = Uri.parse(baseUrl + '/user/notifications');
final Uri transactions = Uri.parse(baseUrl + '/user/transactions');
final Uri dashboard = Uri.parse(baseUrl + '/consumer/user/dashboard');
final Uri user_statistics = Uri.parse(baseUrl + '/consumer/order/statistics');
final Uri get_categories = Uri.parse(baseUrl + '/consumer/user/categories');
final Uri get_order = Uri.parse(baseUrl + '/consumer/order/orders');
final Uri get_dustbin_location = Uri.parse('$baseUrl/consumer/order/pickup-locations');
final Uri mark_pick_up = Uri.parse('$baseUrl/consumer/order/mark-pickup');
final Uri update_profile = Uri.parse('$baseUrl/consumer/user/update-profile');
final Uri get_my_category=Uri.parse('$baseUrl/consumer/user/my-categories');
final Uri order_summery=Uri.parse('$baseUrl/consumer/user/pre-order-summary');

final Uri book_order=Uri.parse('$baseUrl/consumer/user/pre-order-summary');