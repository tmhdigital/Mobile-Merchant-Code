import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:merchent/screen/profile_section/profile_screen/model/profile_model.dart';
import 'package:merchent/service/repository/profile_get_repository.dart';
import 'package:merchent/service/storage/get_storage_services.dart';
import 'package:merchent/widget/app_log/app_print.dart';
import '../../../routes/app_routes.dart';
import '../../../service/storage/storage_service.dart';
import '../../../utils/app_log/app_log.dart';
import '../../../utils/app_log/error_log.dart';
import '../../../service/repository/update_profile_repository.dart';

class SplashController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final UpdateProfileRepository _updateProfileRepository =
      UpdateProfileRepository();

  final Rxn<UserProfile> profile = Rxn<UserProfile>();
  final GetStorageServices getStorageServices = GetStorageServices.instance;

  @override
  void onInit() {
    super.onInit();
    goToNextScreen();
    //
  }

  /// ===============================
  /// PROFILE FETCH
  /// ===============================
  Future<void> fetchProfile() async {
    try {
      final userProfile = await _profileRepository.fetchProfile();

      profile.value = userProfile;

      // /// ---------- Location Check ----------
      final coordinates = userProfile.location?.coordinates ?? <double>[];

      /// ---------- Business Name Check ----------
      final businessName = userProfile.businessName?.trim() ?? "";
    } catch (e) {
      AppPrint.appError(e.toString(), title: "Error fetching profile");
    }
  }

  /// ===============================
  /// SPLASH NAVIGATION LOGIC
  /// ===============================
  void goToNextScreen() async {
    await Future.wait([
      LocalStorage.getAllPrefData(),
      Future.delayed(const Duration(seconds: 1)),
    ]);

    final accessToken = LocalStorage.token;

    appLog("Access Token => $accessToken");

    /// ---------- Login Check ----------
    if (accessToken.isEmpty) {
      if (getStorageServices.getIsUserFirstTime() == true) {
        Get.offAllNamed(AppRoutes.authenticationsScreen);
        return;
      } else {
        Get.offAllNamed(AppRoutes.onBoardingScreen);
        return;
      }
    }

    /// ---------- Fetch Profile ----------
    await fetchProfile();
    await getFCMToken();

    /// Small sync delay (race condition prevention)
    await Future.delayed(const Duration(milliseconds: 300));

    final bool isBusiness = LocalStorage.isBusiness;
    final bool isLocation = LocalStorage.isLocation;

    appLog("isBusiness => $isBusiness");
    appLog("isLocation => $isLocation");

    /// ---------- Navigation Decision ----------
    if (!isLocation) {
      Get.offAllNamed(AppRoutes.locationScreen);
      return;
    }

    if (!isBusiness) {
      Get.offAllNamed(AppRoutes.shopInformationScreen);
      return;
    }

    Get.offAllNamed(AppRoutes.userBottomNav);
  }

  /// ===============================
  /// FCM TOKEN SYNC
  /// ===============================
  Future<void> getFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      appLog("FCM TOKEN: $token");

      if (token != null) {
        await _updateProfileRepository.syncFCMToken(token);
      }
    } catch (e) {
      errorLog("Failed to get FCM token: $e");
    }
  }

  @override
  void onClose() {
    appLog("SplashController disposed");
    super.onClose();
  }
}
