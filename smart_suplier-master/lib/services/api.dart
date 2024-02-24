
import '../constant.dart';

final Uri send_otp = Uri.parse(baseUrl + '/auth/send-otp');
final Uri verify_otp = Uri.parse(baseUrl + '/auth/verify-otp');
final Uri register_user =Uri.parse(baseUrl+'/auth/register-user');
final Uri user_activities  = Uri.parse(baseUrl + '/user/activities');
final Uri notifications = Uri.parse(baseUrl + '/user/notifications');
final Uri update_profile = Uri.parse(baseUrl + '/user/update-profile');
final Uri transactions = Uri.parse(baseUrl + '/user/transactions');
final Uri  dashboard= Uri.parse(baseUrl + '/user/dashboard');
final Uri user_statistics = Uri.parse(baseUrl + '/user/statistics');
// final Uri  = Uri.parse(baseUrl + '/');
final Uri add_dustbin = Uri.parse(baseUrl + '/dustbin/request-dustbin');


final Uri get_categories = Uri.parse(baseUrl + '/dustbin/get-categories');