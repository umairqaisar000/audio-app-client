import 'package:audio_app/providers/rooms_notifier.dart';
import 'package:audio_app/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoungeView extends ConsumerWidget {
  const LoungeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(roomsNotifierProvider.notifier).fetchRooms();

    // Access the current state of rooms
    final rooms = ref.watch(roomsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lounges',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: rooms.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Loading state
          : ListView.builder(
              itemCount: rooms.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
              itemBuilder: (context, index) {
                final roomTemp = rooms[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RoomCard(
                    room: roomTemp,
                  ),
                );
              },
            ),
    );
  }
}
