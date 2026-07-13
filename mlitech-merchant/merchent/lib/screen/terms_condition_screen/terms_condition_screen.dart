import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../utils/app_size.dart';
import '../../../widget/app_appbar/custom_app_bar.dart';
import 'controller/terms_and_conditions_controller.dart';

class TermAndCondition extends StatelessWidget {
  TermAndCondition({super.key});

  final TermsAndConditionsController controller = Get.put(
    TermsAndConditionsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar:  AppbarWidget(
        showLeading: true,
        text: controller.args.toString().replaceAll('-', ' ').capitalize ?? '',
      ),

      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Html(
              data: controller.content,
              // You'll need flutter_html package for this
              // Or use Text widget if you want plain text
            ),
          );
        }),
      ),
    );
  }
}
