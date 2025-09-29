import '../config/app_configs.dart';

final String baseUrl = AppConfigs.baseUrl;
final String apiBaseUrl = AppConfigs.apiBaseUrl;
final String mediaUrl = AppConfigs.mediaUrl;

///---fcm
const String fcmService = 'https://fcm.googleapis.com/fcm/send';

///---auth
// String signUpWithEmailURL = apiBaseUrl + 'signup-email';
String signUpWithEmailURL = '${apiBaseUrl}auth/register';
String signInWithEmailURL = '${apiBaseUrl}auth/login';
String socialLoginURL = '${apiBaseUrl}auth/social_login';
String signOutURL = '${apiBaseUrl}auth/logout';
String deleteAccountURL = '${apiBaseUrl}auth/delete_account';

///---logged-in-user
String getLoggedInUserUrl = '${apiBaseUrl}auth/user';

String contactUsUrl = '${apiBaseUrl}contact';

//---edit-or-update-profile
String editUserProfileURL = '${apiBaseUrl}customers/update_general_info';

///---consultant-profile-by-id
String getLawyerProfileUrl = '${apiBaseUrl}lawyers/';

///---featured
String getFeaturedEvents = '${apiBaseUrl}featured_events';
String getFeaturedLawyers = '${apiBaseUrl}featured_lawyers';

///---all listings
String getAllLawyers = '${apiBaseUrl}filter_lawyers';
String getLawyersByCategory = '${apiBaseUrl}filter_lawyers?lawyer_category=';
String getAllBlogsPosts = '${apiBaseUrl}filter_posts';
String getAllEvents = '${apiBaseUrl}filter_events';
String getAllServices = '${apiBaseUrl}filter_services';
String getAllLawFirms = '${apiBaseUrl}filter_law_firms';

///---categories
String getLawyerCategoriesURL = '${apiBaseUrl}lawyer_categories';
String getLawyerMainCategoriesURL =
    '${apiBaseUrl}lawyer_main_categories_with_childrens';

///---top-rated
String getTopRatedLawyers = '${apiBaseUrl}top_rated_lawyers';

///---book-appointment
String getScheduleAvailableDaysURL =
    '${apiBaseUrl}get-scheduled-available-days';
String getScheduleSlotsForMenteeUrl = '${apiBaseUrl}get-date-schedule';
String bookAppointmentUrl = '${apiBaseUrl}bookAppointment';

///---appointment-log-user
String getAppointmentsDetailURL = '${apiBaseUrl}appointmentDetails';

/// wallet
String getWalletBalanceURL = '${apiBaseUrl}get_current_balance';
String getWalletTransactionURL = '${apiBaseUrl}get_wallet_transactions';
String getWalletWithdrawalURL = '${apiBaseUrl}get_wallet_withdrawls';
String walletTopupURL = '${apiBaseUrl}add-to-wallet';

///---lawyer-reviews
String getLawyerReviews = '${apiBaseUrl}filter_lawyer_reviews';

///---lawyer-podcasts
String getLawyerPodcasts = '${apiBaseUrl}filter_lawyer_podcasts';

///---lawyer-broadcasts
String getLawyerBroadcasts = '${apiBaseUrl}filter_lawyer_broadcasts';

///---lawyer-reviews
String getLawFirmReviews = '${apiBaseUrl}filter_law_firm_reviews';

///---agora
// String agoraTokenUrl = apiBaseUrl + 'agoraToken';
String agoraTokenUrl = '${apiBaseUrl}customers/api_generate_agora_token';

///---chat messages
String getMessagesUrl = '${apiBaseUrl}customers/api_get_chat_messages/';
String sendMessageUrl = '${apiBaseUrl}customers/api_send_chat_message';

///---service chat messages
String getServiceMessagesUrl =
    '${apiBaseUrl}customers/api_get_service_chat_messages/';
String sendServiceMessageUrl =
    '${apiBaseUrl}customers/api_send_service_chat_message';

///---reset-password
String forgotPasswordUrl = '${apiBaseUrl}auth/forgot_password';
String newPasswordUrl = '${apiBaseUrl}reset-password';

/// All Settings
String getAllSettingUrl = '${apiBaseUrl}settings';

/// All Themes
String getThemesUrl = '${apiBaseUrl}themes';

/// Get All Carousel Banner
String getCarouselBannerUrl = '${apiBaseUrl}app_carousels';

/// All Languages
String getAllLanguagesUrl = '${apiBaseUrl}get_all_languages';

/// Get Terms and Conditions
String getTermsConditionsUrl = '${apiBaseUrl}terms_conditions';

// Get Lawyer Appointment Types
String getLawyerAppointmentTypes = '${apiBaseUrl}lawyers/profile/';

// Get Lawyer Book Appointment
String getLawyerBookAppointment = '${apiBaseUrl}lawyers/profile/';

// Customer Book Appointment
String customerBookAppointment = '${apiBaseUrl}customers/book_appointment';

// Customer Book Appointment
String customerBookService = '${apiBaseUrl}customers/book_service';

// Stripe Payment API URL
String stripePaymentUrl = "https://api.stripe.com/v1/payment_intents";

// Get Customer Appointment History
String getCustomerAppointmentHistory =
    "${apiBaseUrl}customers/get_filter_appointment_logs";

// Get Customer Booked Services History
String getCustomerBookedServicesHistory =
    "${apiBaseUrl}customers/get_filter_service_logs";

// Content Pages URls
String contentPagesURL = "${apiBaseUrl}company_page";

// Content Pages URls
String getPaymentGatewaysURL = "${apiBaseUrl}gateways";

// Open Web View For Payment URls
String webViewPaymentURL = "${baseUrl}add_fund_confirm";
