import 'package:flutter/material.dart';

import '../../core/utils/custom_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();

    Size size = MediaQuery.sizeOf(context);

    List<Map> settingsItems = [
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
        toolbarHeight: size.height * 0.06,
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
          padding: EdgeInsets.all(0.02 * size.width),
          itemCount: settingsItems.length,
          itemBuilder: (BuildContext context, index) => SettingsButtonWidget(
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

class SettingsButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const SettingsButtonWidget(
      {Key? key, required this.text, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 2,
          shadowColor: Colors.deepPurple,
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.02 * size.width),
          child: SizedBox(
            height: size.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  icon,
                  color: Colors.deepPurple,
                ),
                const Spacer(),
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
