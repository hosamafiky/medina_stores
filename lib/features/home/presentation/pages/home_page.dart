part of '../presentation_imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    NotificationHelper.instance.checkForInitialMessage();
  }

  @override
  Widget build(BuildContext context) {
    return HomePageListener(
      child: Scaffold(
        appBar: MainAppBar(
          title: const Text('Home Page'),
          padEnd: false,
          actions: [
            IconButton(
              icon: Icon(context.isDark() ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => context.toggleTheme(false),
            ),
            IconButton(
              onPressed: () {
                context.read<UserCubit>().logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
