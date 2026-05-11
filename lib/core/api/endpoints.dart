/// Auth Endpoints - Staging Only

class EndPoints {
  /// Base URLs
  static const String userBase =
      "https://staging-user.vupop.io/v1/user/service";
  static const String user = "$userBase/user";
  static const String otp = "$userBase/otp";
  static const String mobileOtp = "$userBase/mobileOtp";

  // =========================
  // 🔐 Authentication
  // =========================
  static const String register = "$user/register";
  static const String login = "$user/login";
  static const String logout = "$user/logout";
  static const String checkUser = "$user/checkUser";
  static const String deleteUser = "$user/deleteUser";

  // =========================
  // 📩 Email OTP
  // =========================
  static const String sendOtpToEmail = "$otp/sendOTPToEmail";
  static const String verifyEmailOtp = "$otp/verifyEmail";

  // =========================
  // 🔑 Forgot Password
  // =========================
  static const String forgotPasswordSendOtp =
      "$otp/forgetpassword/sendOTP";
  static const String forgotPasswordVerifyOtp =
      "$otp/forgetpassword/verifyEmail";
  static const String changePassword = "$user/changePassword";

  // =========================
  // 📱 Mobile OTP (Registration)
  // =========================
  static const String sendMobileOtp = "$mobileOtp/sendOtp";
  static const String verifyMobileOtp = "$mobileOtp/verifyOtp";

  // =========================
  // 🎁 Referral
  // =========================
  static const String checkReferrer =
      "$userBase/referrer/checkreferrerExist";
  static const String useReferralCode =
      "$userBase/referallCode/useReferal";
  static const String getReferralCode =
      "$userBase/referallCode";
  static const String getReferralStats =
      "$userBase/referallCode/stats";
  static const String getReferralChart =
      "$userBase/referallCode/invitesChart";


  // =========================
  // 🧑 Profile & Passions
  // =========================
  static const String getUserImage = "$user/image"; // + /{userId}
  static const String getUserProfile = "$user/getUser"; // + /{userId}
  static const String getPassions = "$userBase/Passion/get";
  static const String getUserPassions = "$user/passion"; // + /{userId}
  static const String updateUserImage = "$user/updateImage"; // + /{userId}
  static const String updateUserInfo = "$user/updateUser"; // + /{userId}

}