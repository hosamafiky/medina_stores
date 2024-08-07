import 'package:flutter/material.dart';
import 'package:medina_stores/core/helpers/external_map_launcher.dart';
import 'package:medina_stores/core/helpers/location_helper.dart';
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
      appBar: const MainAppBar(title: Text('Home Page')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(
                hintText: 'Enter data',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await UrlLauncherHelper.sendMail(
                  emails: [_dataController.text],
                  subject: 'Test subject',
                  body: 'Test body',
                );
              },
              child: const Text('Open mail app'),
            ),
            ElevatedButton(
              onPressed: () async {
                final position = await LocationHelper.getCurrentPosition();
                final placeMark = await LocationHelper.getPlacemarkFromCoordinates(position);
                await ExternalMapLauncher.launchMapWithCoordinates(
                  latitude: 24.7136,
                  longitude: 46.6753,
                  title: placeMark.thoroughfare,
                );
              },
              child: const Text('Open map app with coordinates'),
            ),
            ElevatedButton(
              onPressed: () async {
                await ExternalMapLauncher.launchMapWithQuery(
                  'Olaya Street, Riyadh',
                );
              },
              child: const Text('Open map app with QUERY'),
            ),
            ElevatedButton(
              onPressed: () async {
                await UrlLauncherHelper.sendSMS(
                  _dataController.text,
                  body: 'Test message',
                );
              },
              child: const Text('Open SMS app'),
            ),
            ElevatedButton(
              onPressed: () async {
                await UrlLauncherHelper.makePhoneCall(_dataController.text);
              },
              child: const Text('Make phone call'),
            ),
          ],
        ),
      ),
    );
  }
}
