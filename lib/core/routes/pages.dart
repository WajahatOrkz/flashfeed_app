import 'package:get/get.dart';
import '../../features/auth/presentation/bindings/auth_binding.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/initial_auth_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/feed/presentation/bindings/feed_binding.dart';
import '../../features/feed/presentation/views/feed_view.dart';
import '../../features/onboarding/presentation/binding/onboarding_binding.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/splash/presentation/bindings/splash_binding.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.onboardingRoute,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.initialAuthRoute,
      page: () => const InitialAuthView(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.loginRoute,
      page: () => const LoginView(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.signUpRoute,
      page: () => const SignupView(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.feedRoute,
      page: () => const FeedView(),
      binding: FeedBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.forgotPasswordRoute,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.resetPasswordRoute,
      page: () => const ResetPasswordScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
