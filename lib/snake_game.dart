import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SnakeGame extends StatefulWidget {
  final VoidCallback onBack;
  const SnakeGame({super.key, required this.onBack});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  List<Offset> snake = [const Offset(5, 5)];
  Offset food = const Offset(10, 10);
  String direction = 'right';
  bool gameOver = false;
  int score = 0;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (!gameOver) {
        setState(() {
          moveSnake();
          checkCollision();
          if (snake.first == food) {
            score++;
            generateFood();
          } else {
            snake.removeLast();
          }
        });
      }
    });
  }

  void moveSnake() {
    Offset newHead = snake.first;
    switch (direction) {
      case 'up':
        newHead = Offset(newHead.dx, newHead.dy - 1);
        break;
      case 'down':
        newHead = Offset(newHead.dx, newHead.dy + 1);
        break;
      case 'left':
        newHead = Offset(newHead.dx - 1, newHead.dy);
        break;
      case 'right':
        newHead = Offset(newHead.dx + 1, newHead.dy);
        break;
    }
    snake.insert(0, newHead);
  }

  void checkCollision() {
    if (snake.first.dx < 0 || snake.first.dx >= 20 || snake.first.dy < 0 || snake.first.dy >= 30) {
      gameOver = true;
    }
    for (int i = 1; i < snake.length; i++) {
      if (snake[i] == snake.first) {
        gameOver = true;
      }
    }
  }

  void generateFood() {
    food = Offset(Random().nextInt(20).toDouble(), Random().nextInt(30).toDouble());
  }

  void restart() {
    setState(() {
      snake = [const Offset(5, 5)];
      direction = 'right';
      gameOver = false;
      score = 0;
      generateFood();
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFC0CB), Color(0xFFFFB6C1)],
          ),
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
                    Text('Puntos: $score', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 20 / 30,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 20),
                      itemCount: 600,
                      itemBuilder: (context, index) {
                        int x = index % 20;
                        int y = index ~/ 20;
                        bool isSnake = snake.contains(Offset(x.toDouble(), y.toDouble()));
                        bool isFood = food == Offset(x.toDouble(), y.toDouble());
                        bool isHead = snake.first == Offset(x.toDouble(), y.toDouble());

                        return Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: isHead
                                ? const Color(0xFFFF1493)
                                : isSnake
                                    ? const Color(0xFFFF69B4)
                                    : isFood
                                        ? Colors.red
                                        : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: isFood ? const Center(child: Text('💕', style: TextStyle(fontSize: 10))) : null,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => setState(() => direction = 'up'),
                        icon: const Icon(Icons.arrow_upward, size: 40, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => setState(() => direction = 'left'),
                        icon: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
                      ),
                      const SizedBox(width: 80),
                      IconButton(
                        onPressed: () => setState(() => direction = 'right'),
                        icon: const Icon(Icons.arrow_forward, size: 40, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => setState(() => direction = 'down'),
                        icon: const Icon(Icons.arrow_downward, size: 40, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (gameOver)
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
                            const Text('😢', style: TextStyle(fontSize: 60)),
                            const Text('Game Over', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('Puntos: $score', style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 20),
                            ElevatedButton(onPressed: restart, child: const Text('Reintentar')),
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
