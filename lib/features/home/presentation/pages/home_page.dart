import 'package:flutter/material.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/helpers/external_map_launcher.dart';
import 'package:medina_stores/core/helpers/location_helper.dart';
import 'package:medina_stores/core/helpers/social_media_launcher.dart';
import 'package:medina_stores/core/helpers/url_launcher_helper.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/main_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dataController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(context.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: context.toggleTheme,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(
                hintText: 'Enter data',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final position = await LocationHelper.getCurrentPosition();
                var uri = Uri.parse("google.navigation:q=${position.latitude + 20},${position.longitude + 10}&mode=d");
                await UrlLauncherHelper.launchURL(uri);
              },
              child: const Text('Open URL'),
            ),
            ElevatedButton(
              onPressed: () async => await UrlLauncherHelper.sendMail(
                emails: [_dataController.text],
                subject: 'Test subject',
                body: 'Test body',
              ),
              child: const Text('Open mail app'),
            ),
            ElevatedButton(
              onPressed: () async => await SocialMediaLauncher.launchFacebookApp(identifier: 'hosam.elfikky'),
              child: const Text('Open Facebook app'),
            ),
            ElevatedButton(
              onPressed: () async => await SocialMediaLauncher.launchYoutubeApp(channelId: 'arabeem'),
              child: const Text('Open Youtube app'),
            ),
            ElevatedButton(
              onPressed: () async => await SocialMediaLauncher.launchInstagramApp(identifier: 'eqam86'),
              child: const Text('Open Instagram app'),
            ),
            ElevatedButton(
              onPressed: () async {
                final position = await LocationHelper.getCurrentPosition();
                final placeMark = await LocationHelper.getPlacemarkFromCoordinates(position);
                await ExternalMapLauncher.launchMapWithCoordinates(
                  latitude: position.latitude,
                  longitude: position.longitude,
                  title: placeMark.thoroughfare,
                );
              },
              child: const Text('Open map app with coordinates'),
            ),
            ElevatedButton(
              onPressed: () async => await ExternalMapLauncher.launchMapWithQuery(_dataController.text),
              child: const Text('Open map app with QUERY'),
            ),
            ElevatedButton(
              onPressed: () async => await UrlLauncherHelper.sendSMS(_dataController.text, body: 'Test message'),
              child: const Text('Open SMS app'),
            ),
            ElevatedButton(
              onPressed: () async => await UrlLauncherHelper.makePhoneCall(_dataController.text),
              child: const Text('Make phone call'),
            ),
          ],
        ),
      ),
    );
  }
}
