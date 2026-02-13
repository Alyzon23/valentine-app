import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class TetrisGame extends StatefulWidget {
  final VoidCallback onBack;
  const TetrisGame({super.key, required this.onBack});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  List<List<int>> board = List.generate(20, (_) => List.filled(10, 0));
  List<Offset> currentPiece = [];
  Offset piecePosition = const Offset(4, 0);
  int score = 0;
  bool gameOver = false;
  Timer? gameTimer;

  final List<List<Offset>> pieces = [
    [const Offset(0, 0), const Offset(1, 0), const Offset(2, 0), const Offset(3, 0)], // I
    [const Offset(0, 0), const Offset(1, 0), const Offset(0, 1), const Offset(1, 1)], // O
    [const Offset(1, 0), const Offset(0, 1), const Offset(1, 1), const Offset(2, 1)], // T
    [const Offset(0, 0), const Offset(1, 0), const Offset(1, 1), const Offset(2, 1)], // Z
  ];

  @override
  void initState() {
    super.initState();
    spawnPiece();
    startGame();
  }

  void startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!gameOver) {
        setState(() {
          moveDown();
        });
      }
    });
  }

  void spawnPiece() {
    currentPiece = pieces[Random().nextInt(pieces.length)];
    piecePosition = const Offset(4, 0);
    if (!canMove(piecePosition)) {
      gameOver = true;
    }
  }

  bool canMove(Offset newPos) {
    for (var block in currentPiece) {
      int x = (newPos.dx + block.dx).toInt();
      int y = (newPos.dy + block.dy).toInt();
      if (x < 0 || x >= 10 || y >= 20 || (y >= 0 && board[y][x] != 0)) {
        return false;
      }
    }
    return true;
  }

  void moveDown() {
    Offset newPos = Offset(piecePosition.dx, piecePosition.dy + 1);
    if (canMove(newPos)) {
      piecePosition = newPos;
    } else {
      placePiece();
      clearLines();
      spawnPiece();
    }
  }

  void moveLeft() {
    Offset newPos = Offset(piecePosition.dx - 1, piecePosition.dy);
    if (canMove(newPos)) {
      setState(() => piecePosition = newPos);
    }
  }

  void moveRight() {
    Offset newPos = Offset(piecePosition.dx + 1, piecePosition.dy);
    if (canMove(newPos)) {
      setState(() => piecePosition = newPos);
    }
  }

  void placePiece() {
    for (var block in currentPiece) {
      int x = (piecePosition.dx + block.dx).toInt();
      int y = (piecePosition.dy + block.dy).toInt();
      if (y >= 0) {
        board[y][x] = 1;
      }
    }
  }

  void clearLines() {
    for (int y = 19; y >= 0; y--) {
      if (board[y].every((cell) => cell != 0)) {
        board.removeAt(y);
        board.insert(0, List.filled(10, 0));
        score += 10;
        y++;
      }
    }
  }

  void restart() {
    setState(() {
      board = List.generate(20, (_) => List.filled(10, 0));
      score = 0;
      gameOver = false;
      spawnPiece();
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
                    Text('Puntos: $score', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 10 / 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                      itemCount: 200,
                      itemBuilder: (context, index) {
                        int x = index % 10;
                        int y = index ~/ 10;
                        bool isBoard = board[y][x] != 0;
                        bool isPiece = currentPiece.any((block) =>
                            (piecePosition.dx + block.dx).toInt() == x &&
                            (piecePosition.dy + block.dy).toInt() == y);

                        return Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: isPiece || isBoard ? const Color(0xFFFF1493) : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: isPiece || isBoard ? const Center(child: Text('💕', style: TextStyle(fontSize: 12))) : null,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: moveLeft,
                    icon: const Icon(Icons.arrow_back, size: 50, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () => setState(moveDown),
                    icon: const Icon(Icons.arrow_downward, size: 50, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: moveRight,
                    icon: const Icon(Icons.arrow_forward, size: 50, color: Colors.white),
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
