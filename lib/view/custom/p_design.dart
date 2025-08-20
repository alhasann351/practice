import 'package:flutter/material.dart';

class PDesign extends StatelessWidget {
  const PDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background split half image + half color
          Column(
            children: [
              Container(
                height: size.height * 0.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/mosjid.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(child: Container(color: Colors.white)),
            ],
          ),

          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                // Spacer to create the empty space for the progress bar container to appear
                SizedBox(
                  height: size.height * 0.5 - 75,
                ), // এইখানে height-টা ঠিক করে বসান
                // Progressbar container
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Current Prayer: Asr",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Next Prayer: Maghrib",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // Prayer Times list starts immediately below
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final prayers = [
                      "Fajr",
                      "Dhuhr",
                      "Asr",
                      "Maghrib",
                      "Isha",
                      "Tahajjud",
                    ];
                    return ListTile(
                      title: Text(prayers[index]),
                      trailing: const Text("05:30 AM"),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final prayers = [
                      "Fajr",
                      "Dhuhr",
                      "Asr",
                      "Maghrib",
                      "Isha",
                      "Tahajjud",
                    ];
                    return ListTile(
                      title: Text(prayers[index]),
                      trailing: const Text("05:30 AM"),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
