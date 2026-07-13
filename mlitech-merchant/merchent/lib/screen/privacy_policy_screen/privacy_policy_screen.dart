import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchent/screen/common_widget/common_text_widget.dart';
import '../../../widget/appbar_widget/appbar_widget.dart';
import '../../constant/app_color/app_theme_color.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final TermsAndConditionsController controller =
    //     Get.put(TermsAndConditionsController());
    final AppThemeColor appThemeColor = Theme.of(
      context,
    ).extension<AppThemeColor>()!;

    return Scaffold(
      appBar: AppbarWidget(
        backgroundColor: appThemeColor.button1,
        textWidget: TextWidget(
          text: 'Privacy Policy',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          fontColor: appThemeColor.text2,
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new, color: appThemeColor.text2),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextWidget(
          text: '''
Welcome to the [Your App Name] Loyalty Program! These Terms & Conditions ("Terms") govern your participation in the loyalty program operated by [Your Company Name], located at [Your Company Address], Dhaka, Bangladesh ("Company," "we," "us," or "our"). By downloading, accessing, or using the [Your App Name] mobile application (the "App") and participating in our Loyalty Program, you agree to be bound by these Terms.
1. Membership & Eligibility
1.1. Eligibility: Membership in the [Your App Name] Loyalty Program (the "Program") is open to individuals who are [e.g., 18 years of age or older / legal age of majority in Bangladesh]. Employees of [Your Company Name] and its affiliates may have restricted or no eligibility, as determined by the Company.
1.2. Registration: To become a member, you must register for an account through the App and agree to these Terms. You are responsible for providing accurate and complete information during registration.
1.3. Referral ID (if applicable): If you sign up using a referral ID, your account may be subject to a validation period and specific benefits or restrictions as outlined during the signup process. Your account features may be paused until your payment (e.g., cash payment) is validated.
1.4. One Account Per Person: Each individual may maintain only one Program account.
      ''',
          fontColor: appThemeColor.text2,
          textAlignment: TextAlign.start,
        ),
      ),
    );
  }
}
