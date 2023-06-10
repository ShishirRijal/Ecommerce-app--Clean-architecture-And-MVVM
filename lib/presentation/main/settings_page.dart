import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../core.dart/core.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(
            AppString.changeLanguage.tr(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          leading: SvgPicture.asset(SvgAssets.changeLanguage),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(SvgAssets.settingRightArrow),
          ),
          onTap: () {
            // _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppString.contactUs.tr(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          leading: SvgPicture.asset(SvgAssets.contactUs),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(SvgAssets.settingRightArrow),
          ),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppString.inviteYourFriends.tr(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          leading: SvgPicture.asset(SvgAssets.inviteFriends),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(SvgAssets.settingRightArrow),
          ),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(
            AppString.logout.tr(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          leading: SvgPicture.asset(SvgAssets.logout),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(SvgAssets.settingRightArrow),
          ),
          onTap: () {
            //
          },
        )
      ],
    );
  }

  bool isRtl() {
    return false;
  }

  void _contactUs() {
    // its a task for you to open any web bage with dummy content
  }

  void _inviteFriends() {
    // its a task to share app name with friends
  }
}
