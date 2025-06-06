import 'package:flutter/material.dart';
import 'package:ovia_app/core/notifications/daily_notifications.dart';
import 'package:ovia_app/screens/settings/settings_screen.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({super.key});

  final bool isPairing = false;

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 350,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.isPairing
                                ? const AssetImage('assets/images/time.jpg')
                                : const AssetImage('assets/images/heart1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          )),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Ovia for Partners',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Text(
                              'Share your pairing code',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Your partner will receive a link to download Ovia app. He'll then use the code to pair your profiles.",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: const Center(
                        child: Text(
                          'QMWHCR',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.isPairing
                            ? 'Lost the code? You can send it again anytime'
                            : 'Your personal data is important. Only share it with a trusted, responsible partner.',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  child: Text(widget.isPairing
                      ? 'Resend the code'
                      : 'Send pairing code'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    // minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    final now = DateTime.now();
                    DailyNotificationService().scheduleDailyReminder(
                      id: 99,
                      title: 'Manual Test!',
                      body: 'This is a test scheduled one minute ahead.',
                      hour: 13,
                      minute: 57,
                    );
                    print(
                        "Notification scheduled for ${now.hour}:${now.minute + 1}");
                  // await DailyNotificationService().showNotification(
                  //   id: 99,
                  //     title: 'Manual Test!',
                  //     body: 'This is a test scheduled one minute ahead.',
                  //   );
                  },
                  child: const Text('Cancel invite'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
