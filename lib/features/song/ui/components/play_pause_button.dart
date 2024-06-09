import 'package:audio_service/audio_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/song_notifier.dart';

// PlayPauseButton class responsible for displaying a play/pause button
class PlayPauseButton extends StatelessWidget {
  // Size of the button
  final double? size;

  // Constructor to initialize the PlayPauseButton
  const PlayPauseButton({
    super.key,
     this.size,
  });

  // Build method to create the widget
  @override
  Widget build(BuildContext context) {
    SongNotifier songNotifier = context.watch<SongNotifier>();
    final songHandler = songNotifier.songHandler;
    // StreamBuilder listens to changes in the playback state
    return StreamBuilder<PlaybackState>(
      stream: songHandler.playbackState.stream,
      builder: (context, snapshot) {
        // Check if there's data in the snapshot
        if (snapshot.hasData) {
          // Retrieve the playing status from the playback state
          bool playing = snapshot.data!.playing;

          // Return an IconButton that toggles play/pause on press
          return IconButton.filledTonal(
            onPressed: () {
              // Toggle play/pause based on the current playing status
              if (playing) {
                songHandler.pause();
              } else {
                songHandler.play();
              }
            },
            // Display a play or pause icon based on the playing status
            icon: playing
                ? Icon(
                    Icons.pause_rounded,
                    size: size,
                  )
                : Icon(
                    Icons.play_arrow_rounded,
                    size: size,
                  ),
          );
        } else {
          // If there's no data in the snapshot, return an empty SizedBox
          return const SizedBox.shrink();
        }
      },
    );
  }
}
