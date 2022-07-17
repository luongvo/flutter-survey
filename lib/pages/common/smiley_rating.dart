import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedEmojiIndexProvider = StateProvider.autoDispose<int>((_) => 2);
const _emojis = {
  0: "😡",
  1: "😕",
  2: "😐",
  3: "🙂",
  4: "😄",
};

class SmileyRating extends ConsumerWidget {
  final int itemCount;
  final Function onRate;

  SmileyRating({
    required this.itemCount,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: min(itemCount, _emojis.length),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onEmojiTapped(ref, index),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Consumer(
                  builder: (context, widgetRef, _) {
                    final selectedIndex = ref.watch(selectedEmojiIndexProvider);
                    return _buildSmileyRating(context, index, selectedIndex);
                  },
                ),
              ),
            );
          }),
    );
  }

  Widget _buildSmileyRating(
    BuildContext context,
    int index,
    int selectedIndex,
  ) {
    final enabledStyle =
        Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20);
    final disabledStyle =
        enabledStyle.copyWith(color: Colors.white.withOpacity(0.4));
    final selectedStyle = index == selectedIndex ? enabledStyle : disabledStyle;
    return Text(_emojis[index] ?? "", style: selectedStyle);
  }

  void onEmojiTapped(WidgetRef ref, int selectedIndex) {
    final selectedIndexState = ref.read(selectedEmojiIndexProvider.notifier);
    final previousIndex = selectedIndexState.state;
    if (previousIndex == selectedIndex) return;
    selectedIndexState.state = selectedIndex;
    onRate(selectedIndex + 1);
  }
}
