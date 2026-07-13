
import 'package:get/get.dart';
import '../../../../service/repository/condition_repository.dart';
import '../../../../utils/app_log/error_log.dart';
import '../model/policy_model.dart';


class TermsAndConditionsController extends GetxController {
  final CommonRepository commonRepository = CommonRepository();
  final args = Get.arguments;

  // Observable for the complete terms and conditions model
  var termsConditions = TermsAndConditionsModel(
    id: '',
    type: '',
    content: '',

  ).obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await commonRepository.fetchDisclaimerData(type: args);
      if (response != null) {
        termsConditions.value = response.data;
        errorMessage('');
      } else {
        errorMessage('No content available');
      }
    } catch (e, st) {
      errorLog('loadData $e\n$st', );
      errorMessage('Error loading content: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // Method to reload data
  void refreshData() {
    loadData();
  }

  // Getter methods for easy access
  String get content => termsConditions.value.content;
  String get type => termsConditions.value.type;
  DateTime? get lastUpdated => termsConditions.value.updatedAt;
}
