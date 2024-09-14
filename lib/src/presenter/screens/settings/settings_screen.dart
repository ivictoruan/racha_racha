import 'package:flutter/material.dart';

import '../../shared/constants/space_constants.dart';
import '../../shared/utils/custom_utils.dart';
import 'widgets/settings_button_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();

    final List<Map<String, dynamic>> settingsItems = [
      {
        "icon": Icons.free_breakfast_outlined,
        "text": "Quer me pagar um café?",
        "onTap": () => customUtils.goTo("/wantDonate", context),
      },
      {
        "icon": Icons.feedback_outlined,
        "text": "Feedback",
        "onTap": () => customUtils.goToUrl(
              "https://play.google.com/store/apps/details?id=com.matopibatech.racharacha",
            ),
      },
      {
        "icon": Icons.assessment_outlined,
        "text": "Avalie este App",
        "onTap": () => customUtils.goToUrl(
              "https://play.google.com/store/apps/details?id=com.matopibatech.racharacha",
            ),
      },
      {
        "icon": Icons.youtube_searched_for_outlined,
        "text": " Meu canal no Youtube",
        "onTap": () => customUtils.goToUrl(
              "https://www.youtube.com/channel/UCYGTHmRH98FPXdnACHAmTjg",
            ),
      },
      {
        "icon": Icons.privacy_tip_outlined,
        "text": "Política de Privacidade",
        "onTap": () => customUtils.goToUrl(
              "https://github.com/ivictoruan/invictoruan-privacy/blob/main/privacy-policy.md",
            ),
      },
      {
        "icon": Icons.share,
        "text": "Compartilhar o app",
        "onTap": customUtils.shareRachaRacha,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: SpaceConstants.extraLarge,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.deepPurple,
          ),
          onPressed: () => customUtils.goToBack(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(SpaceConstants.extraSmall),
          itemCount: settingsItems.length,
          itemBuilder: (BuildContext context, int index) =>
              SettingsButtonWidget(
            text: settingsItems[index]["text"] ?? "ABC",
            icon: settingsItems[index]["icon"] ?? Icons.abc,
            onTap: settingsItems[index]["onTap"] ?? () {},
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
        ),
      ),
    );
  }
}
