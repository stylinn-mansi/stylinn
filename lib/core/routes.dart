import 'package:flutter/material.dart';
import '../views/onboarding/welcome_screen.dart';
import '../views/onboarding/signup_screen.dart';
import '../views/onboarding/user_info_screen.dart';
import '../views/onboarding/style_quiz_screen.dart';
import '../views/onboarding/body_analysis_screen.dart';
import '../views/onboarding/login_options_screen.dart';
import '../views/onboarding/style_preferences_screen.dart';
import '../views/main/main_screen.dart';
import '../views/main/wardrobe/upload_clothing_screen.dart';
import '../views/main/wardrobe/clothing_details_screen.dart';
import '../views/style_guide_screen.dart';

class AppRoutes {
  // Onboarding
  static const String welcome = '/welcome';
  static const String loginOptions = '/login-options';
  static const String signup = '/signup';
  static const String userInfo = '/user-info';
  static const String styleQuiz = '/style-quiz';
  static const String bodyAnalysis = '/body-analysis';
  static const String stylePreferences = '/style-preferences';
  
  // Main Navigation
  static const String home = '/home';
  static const String main = '/main';
  
  // Wardrobe
  static const String uploadClothing = '/upload-clothing';
  static const String clothingDetails = '/clothing-details';
  
  // Development/Debug
  static const String styleGuide = '/style-guide';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Onboarding Routes
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
      case AppRoutes.loginOptions:
        return MaterialPageRoute(
          builder: (_) => const LoginOptionsScreen(),
        );
      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case AppRoutes.userInfo:
        return MaterialPageRoute(
          builder: (_) => const UserInfoScreen(),
        );
      case AppRoutes.styleQuiz:
        return MaterialPageRoute(
          builder: (_) => const StyleQuizScreen(),
        );
      case AppRoutes.bodyAnalysis:
        return MaterialPageRoute(
          builder: (_) => const BodyAnalysisScreen(),
        );
      case AppRoutes.stylePreferences:
        return MaterialPageRoute(
          builder: (_) => const StylePreferencesScreen(),
        );
      
      // Main Routes
      case AppRoutes.home:
      case AppRoutes.main:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      
      // Wardrobe Routes
      case AppRoutes.uploadClothing:
        return MaterialPageRoute(
          builder: (_) => const UploadClothingScreen(),
        );
      case AppRoutes.clothingDetails:
        final item = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ClothingDetailsScreen(item: item),
        );
        
      // Development/Debug Routes
      case AppRoutes.styleGuide:
        return MaterialPageRoute(
          builder: (_) => const StyleGuideScreen(),
        );
    
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 