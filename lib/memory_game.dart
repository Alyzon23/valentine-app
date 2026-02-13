import 'package:flutter/material.dart';
import 'dart:math';

class MemoryGame extends StatefulWidget {
  final VoidCallback onBack;
  const MemoryGame({super.key, required this.onBack});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> emojis = ['💕', '💖', '💗', '💝', '💘', '💞', '💓', '💌'];
  List<String> cards = [];
  List<int> flippedIndices = [];
  List<int> matchedIndices = [];
  int moves = 0;
  bool canFlip = true;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void initGame() {
    cards = [...emojis, ...emojis];
    cards.shuffle(Random());
    flippedIndices = [];
    matchedIndices = [];
    moves = 0;
  }

  void onCardTap(int index) {
    if (!canFlip || flippedIndices.contains(index) || matchedIndices.contains(index)) return;

    setState(() {
      flippedIndices.add(index);
      if (flippedIndices.length == 2) {
        canFlip = false;
        moves++;
        if (cards[flippedIndices[0]] == cards[flippedIndices[1]]) {
          matchedIndices.addAll(flippedIndices);
          flippedIndices = [];
          canFlip = true;
        } else {
          Future.delayed(const Duration(milliseconds: 800), () {
            setState(() {
              flippedIndices = [];
              canFlip = true;
            });
          });
        }
      }
    });
  }

  void restart() {
    setState(() {
      initGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool won = matchedIndices.length == cards.length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFFFC0CB), Color(0xFFFFB6C1)]),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: widget.onBack, child: const Text('← Volver')),
                    Text('Movimientos: $moves', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      bool isFlipped = flippedIndices.contains(index) || matchedIndices.contains(index);
                      return GestureDetector(
                        onTap: () => onCardTap(index),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: isFlipped ? Colors.white : const Color(0xFFFF1493),
                          child: Center(
                            child: Text(
                              isFlipped ? cards[index] : '?',
                              style: TextStyle(
                                fontSize: 40,
                                color: isFlipped ? const Color(0xFFFF1493) : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (won)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🎉', style: TextStyle(fontSize: 60)),
                            const Text('¡Ganaste!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            Text('Movimientos: $moves', style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 20),
                            ElevatedButton(onPressed: restart, child: const Text('Jugar de nuevo')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
