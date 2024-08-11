part of '../presentation_imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String printJson(Map<String, dynamic> json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(json);
      return jsonString;
    } catch (e) {
      return jsonEncode(json);
    }
  }

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
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome to Medina Stores'),
                  const SizedBox(height: 20),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state.user?.data == null) {
                        return const Text('No user found');
                      }
                      return Text(
                        'User: ${printJson(state.user!.data!.modelize.toMap())}',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
