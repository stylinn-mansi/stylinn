import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable widget that displays a popup with emoji reactions
class ReactionPopup extends StatelessWidget {
  /// The position where the popup should be displayed
  final Offset position;
  
  /// Callback when an emoji is selected
  final Function(String emoji) onEmojiSelected;
  
  /// Callback when the popup is dismissed
  final VoidCallback onDismiss;
  
  /// Available emojis to display
  final List<EmojiReaction> emojis;
  
  /// Creates a reaction popup
  const ReactionPopup({
    super.key,
    required this.position,
    required this.onEmojiSelected,
    required this.onDismiss,
    this.emojis = const [
      EmojiReaction(emoji: '❤️', label: 'Love', color: Colors.red),
      EmojiReaction(emoji: '🔥', label: 'Fire', color: Colors.orange),
      EmojiReaction(emoji: '😍', label: 'Adore', color: Colors.pink),
      EmojiReaction(emoji: '😲', label: 'Wow', color: Colors.blue),
      EmojiReaction(emoji: '👍', label: 'Like', color: Colors.green),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Transparent overlay to capture taps outside popup
          Positioned.fill(
            child: GestureDetector(
              onTap: onDismiss,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Reaction popup
          Positioned(
            left: position.dx - 120, // Center the popup horizontally
            top: position.dy - 60,   // Position above the tap point
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: emojis.map((emojiReaction) => _buildReactionButton(
                  emojiReaction.emoji,
                  emojiReaction.color.withOpacity(0.2),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionButton(String emoji, Color bgColor) {
    return GestureDetector(
      onTap: () {
        // Add haptic feedback
        HapticFeedback.lightImpact();
        onEmojiSelected(emoji);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

/// Represents an emoji reaction with its associated data
class EmojiReaction {
  /// The emoji character
  final String emoji;
  
  /// A label describing the emoji
  final String label;
  
  /// The color associated with this emoji
  final Color color;
  
  /// Creates an emoji reaction
  const EmojiReaction({
    required this.emoji,
    required this.label,
    required this.color,
  });
}

/// Helper class to show and manage reaction popups
class ReactionPopupManager {
  /// The current overlay entry
  OverlayEntry? _overlayEntry;
  
  /// The build context
  final BuildContext context;
  
  /// Creates a reaction popup manager
  ReactionPopupManager(this.context);
  
  /// Shows a reaction popup at the specified position
  void showReactionPopup({
    required Offset position,
    required Function(String emoji) onEmojiSelected,
    List<EmojiReaction>? emojis,
  }) {
    // Remove any existing overlay
    removeOverlay();
    
    // Add haptic feedback
    HapticFeedback.mediumImpact();
    
    // Create the overlay entry
    _overlayEntry = OverlayEntry(
      builder: (context) => ReactionPopup(
        position: position,
        onEmojiSelected: (emoji) {
          onEmojiSelected(emoji);
          removeOverlay();
        },
        onDismiss: removeOverlay,
        emojis: emojis ?? const [
          EmojiReaction(emoji: '❤️', label: 'Love', color: Colors.red),
          EmojiReaction(emoji: '🔥', label: 'Fire', color: Colors.orange),
          EmojiReaction(emoji: '😍', label: 'Adore', color: Colors.pink),
          EmojiReaction(emoji: '😲', label: 'Wow', color: Colors.blue),
          EmojiReaction(emoji: '👍', label: 'Like', color: Colors.green),
        ],
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
  }
  
  /// Removes the current overlay
  void removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
} 