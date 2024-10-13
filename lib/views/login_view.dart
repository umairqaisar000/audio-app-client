import 'package:audio_app/providers/user_notifier.dart';
import 'package:audio_app/responses/user_creation_response.dart';
import 'package:audio_app/services/create_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  Future<void> onClickContinue(WidgetRef ref, String userName) async {
    UserProfileResponse? response = await UserService().createProfile(userName);
    if (response?.data != null) {
      ref
          .read(userNotifierProvider.notifier)
          .updateUser(response?.data.id ?? 0, response?.data.name ?? "");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Call Pro'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Enter your unique name',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 34),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Make it memorable!',
                            labelStyle: Theme.of(context).textTheme.labelLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onClickContinue(ref, controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
