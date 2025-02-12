import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Counter Provider to store the value
final counterProvider = StateProvider<int>((ref) => 0);

class CouterPage extends ConsumerWidget {
  const CouterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('Flutter Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 50),
            ),
            const Spacer(),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.blueAccent, iconSize: 30),
                    padding: const EdgeInsets.all(8),
                    onPressed: () {
                      ref
                          .read(counterProvider.notifier)
                          .update((state) => state + 1);
                    },
                    icon: const Icon(Icons.add)),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.blueAccent, iconSize: 30),
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                    onPressed: () {
                      ref
                          .read(counterProvider.notifier)
                          .update((state) => state - 1);
                    },
                    icon: const Icon(Icons.minimize)),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
