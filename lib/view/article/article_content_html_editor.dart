import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tech_application/component/appbar_component.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/controller/article/article_management_controller.dart';

// ignore: must_be_immutable
class ArticleContentHtmlEditor extends StatelessWidget {
  ArticleContentHtmlEditor({super.key});

  final HtmlEditorController controller = HtmlEditorController();

  final ArticleManagementController articleManagementInfoController =
      Get.put(ArticleManagementController());

  String finalContentText = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: SafeArea(
        child: Scaffold(resizeToAvoidBottomInset: false,
          appBar: appBar(MyStrings.titleAppBarArticleContentEditor),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                  child: HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                    adjustHeightForKeyboard: true,
                    autoAdjustHeight: true,
                    hint: MyStrings.hintArticleContentEditor,
                    shouldEnsureVisible: true,
                    initialText: articleManagementInfoController
                        .articleInfoModel.value.content),
                callbacks: Callbacks(
                  onChangeContent: (p0) => finalContentText = p0!,
                ),
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width / 2.25,
                            height: Get.height / 13,
                            child: ElevatedButton(
                              onPressed: () {
                                articleManagementInfoController
                                    .updateMainTextArticle(finalContentText);
                                controller.clearFocus();
                                Get.back();
                              },
                              child: Text(MyStrings.preview),
                            ),
                          ),
                          const Expanded(child: SizedBox.shrink()),
                          SizedBox(
                            width: Get.width / 2.25,
                            height: Get.height / 13,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.clearFocus();
                                Get.back();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black)),
                              child: Text(MyStrings.completeLater),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
