import 'package:flutter/material.dart';
import 'package:medina_stores/core/helpers/url_launcher_helper.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/main_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: Text('Home Page')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter data here',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await UrlLauncherHelper.makePhoneCall(_phoneController.text);
              },
              child: const Text('Make a Call'),
            )
          ],
        ),
      ),
    );
  }
}
