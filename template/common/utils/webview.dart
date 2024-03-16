import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class Wv {
  /// 开的app
  static Future<void> toLaunchUrl(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // 打开微信
  static Future<bool> openWx() async {
    final Uri launch = Uri.parse('weixin://');
    final Uri launch2 = Uri.parse('wechat://');
    bool isInstall = await canLaunchUrl(launch);
    bool isInstall2 = await canLaunchUrl(launch2);
    if (isInstall || isInstall2) {
      await launchUrl(launch);
      await launchUrl(launch2);
      return true;
    } else if (!(isInstall && isInstall2)) {
      return false;
    } else {
      return false;
    }
  }

  // 打开WhatsApp
  static Future<bool> openWhatsApp(String text) async {
    final Uri launch = Uri.parse('whatsapp://send?text=$text');
    bool isInstall = await canLaunchUrl(launch);
    if (isInstall) {
      await launchUrl(launch);
      return true;
    } else {
      return false;
    }
  }

  // 打开推特
  static Future<bool> openTelegram() async {
    final Uri launch = Uri.parse('tg://');
    bool isInstall = await canLaunchUrl(launch);
    if (isInstall) {
      await launchUrl(launch);
      return true;
    } else {
      return false;
    }
  }

  // 打开手机
  static openPhoneCall([String? phoneNumber]) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber ?? "",
    );
    await launchUrl(launchUri);
  }

  // 打开短信
  static openSmS(String body, [String? phoneNumber]) async {
    if (Platform.isAndroid) {
      final Uri launchUri = Uri.parse("sms:?body=${body}");
      await launchUrl(launchUri);
    } else {
      // ios
      final Uri launchUri = Uri.parse("sms:&body=${body}");
      await launchUrl(launchUri);
    }
  }

  // 打开短信
  static openMailto([String? url]) async {
    final Uri launchUri = Uri.parse("mailto:$url");
    await launchUrl(launchUri);
  }

  // 打开本地应用商店
  static openItmsApp() async {
    final Uri launchUri = Uri.parse('itms-apps://');
    await launchUrl(launchUri);
  }

  // webview 打开链接
  static Future<void> launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // app 外打开
  static Future<void> launchInWebViewAppOut(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
