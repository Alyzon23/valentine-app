import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'games_menu.dart';
import 'snake_game.dart';
import 'tetris_game.dart';
import 'memory_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Para Mi Ñaña 💕',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const ValentineApp(),
    );
  }
}

class ValentineApp extends StatefulWidget {
  const ValentineApp({super.key});

  @override
  State<ValentineApp> createState() => _ValentineAppState();
}

class _ValentineAppState extends State<ValentineApp> {
  String currentScreen = 'question';
  String selectedGame = '';

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      case 'question':
        return QuestionScreen(onYes: () => setState(() => currentScreen = 'celebration'));
      case 'celebration':
        return CelebrationScreen(onContinue: () => setState(() => currentScreen = 'menu'));
      case 'menu':
        return MenuScreen(
          onGamesClick: () => setState(() => currentScreen = 'game'),
          onNotesClick: () => setState(() => currentScreen = 'notes'),
          onPhotosClick: () => setState(() => currentScreen = 'photos'),
        );
      case 'game':
        return GamesMenuScreen(
          onGameSelect: (game) => setState(() {
            selectedGame = game;
            currentScreen = 'playing';
          }),
          onBack: () => setState(() => currentScreen = 'menu'),
        );
      case 'playing':
        switch (selectedGame) {
          case 'flappy':
            return FlappyHeartGame(onBack: () => setState(() => currentScreen = 'game'));
          case 'snake':
            return SnakeGame(onBack: () => setState(() => currentScreen = 'game'));
          case 'tetris':
            return TetrisGame(onBack: () => setState(() => currentScreen = 'game'));
          case 'memory':
            return MemoryGame(onBack: () => setState(() => currentScreen = 'game'));
          default:
            return const SizedBox();
        }
      case 'notes':
        return NotesScreen(onBack: () => setState(() => currentScreen = 'menu'));
      case 'photos':
        return PhotosScreen(onBack: () => setState(() => currentScreen = 'menu'));
      default:
        return const SizedBox();
    }
  }
}

class QuestionScreen extends StatefulWidget {
  final VoidCallback onYes;
  const QuestionScreen({super.key, required this.onYes});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int noClickCount = 0;
  double yesSize = 120;
  Offset noOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFFFF69B4), Color(0xFFFF1493), Color(0xFFDC143C)],
          ),
        ),
        child: Stack(
          children: [
            const FloatingHearts(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('💝', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: 30),
                  const Text(
                    '¿Quieres ser mi\nValentine?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text(
                    '(Ñaña 💕)',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: widget.onYes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(yesSize, yesSize),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    child: Text(
                      'SÍ ❤️',
                      style: TextStyle(fontSize: yesSize / 5, color: const Color(0xFFFF1493), fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (noClickCount < 5)
                    Transform.translate(
                      offset: noOffset,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            noClickCount++;
                            yesSize += 30;
                            noOffset = Offset(
                              Random().nextDouble() * 200 - 100,
                              Random().nextDouble() * 200 - 100,
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.7),
                          fixedSize: Size(100 - noClickCount * 15, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(fontSize: 20 - noClickCount * 2, color: const Color(0xFFFF1493)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CelebrationScreen extends StatefulWidget {
  final VoidCallback onContinue;
  const CelebrationScreen({super.key, required this.onContinue});

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => showButton = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            colors: [Color(0xFFFF1493), Color(0xFFFF69B4), Color(0xFFFFC0CB), Color(0xFFFF69B4), Color(0xFFFF1493)],
          ),
        ),
        child: Stack(
          children: [
            const FloatingHearts(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🎉', style: TextStyle(fontSize: 100)),
                  const SizedBox(height: 30),
                  const Text(
                    '¡SABÍA QUE\nDIRÍAS QUE SÍ!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text('💕', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: 20),
                  const Text(
                    '¡Te quiero mucho,\nñaña!\n\nFeliz San Valentín 💖',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                  if (showButton)
                    ElevatedButton(
                      onPressed: widget.onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                      child: const Text(
                        'Continuar si tienes curiosidad 👀',
                        style: TextStyle(fontSize: 18, color: Color(0xFFFF1493)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final VoidCallback onGamesClick;
  final VoidCallback onNotesClick;
  final VoidCallback onPhotosClick;

  const MenuScreen({
    super.key,
    required this.onGamesClick,
    required this.onNotesClick,
    required this.onPhotosClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4), Color(0xFFFF1493)],
          ),
        ),
        child: Stack(
          children: [
            const FloatingHearts(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('💕', style: TextStyle(fontSize: 80)),
                    const SizedBox(height: 20),
                    const Text(
                      'Para Mi Ñaña',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 60),
                    MenuButton(icon: '🎮', text: 'Juegos', onTap: onGamesClick),
                    const SizedBox(height: 20),
                    MenuButton(icon: '💌', text: 'Notas de Cariño', onTap: onNotesClick),
                    const SizedBox(height: 20),
                    MenuButton(icon: '📸', text: 'Nuestras Fotos', onTap: onPhotosClick),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  const MenuButton({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 50)),
              const SizedBox(width: 20),
              Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFF1493))),
            ],
          ),
        ),
      ),
    );
  }
}

class FlappyHeartGame extends StatefulWidget {
  final VoidCallback onBack;
  const FlappyHeartGame({super.key, required this.onBack});

  @override
  State<FlappyHeartGame> createState() => _FlappyHeartGameState();
}

class _FlappyHeartGameState extends State<FlappyHeartGame> {
  double heartY = 0.5;
  double velocity = 0;
  List<Obstacle> obstacles = [];
  int score = 0;
  bool gameOver = false;
  bool gameWon = false;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!gameOver && !gameWon) {
        setState(() {
          velocity += 0.001;
          heartY += velocity;

          if (heartY > 1 || heartY < 0) gameOver = true;

          obstacles = obstacles.map((o) => Obstacle(o.x - 0.01, o.gapY, o.passed)).where((o) => o.x > -0.2).toList();

          if (obstacles.isEmpty || obstacles.last.x < 0.6) {
            obstacles.add(Obstacle(1.2, Random().nextDouble() * 0.4 + 0.3, false));
          }

          for (var i = 0; i < obstacles.length; i++) {
            var obs = obstacles[i];
            if (obs.x >= 0.1 && obs.x <= 0.3 && !obs.passed) {
              if (heartY < obs.gapY - 0.15 || heartY > obs.gapY + 0.15) {
                gameOver = true;
              } else if (obs.x < 0.2) {
                obstacles[i] = Obstacle(obs.x, obs.gapY, true);
                score++;
                if (score >= 10) gameWon = true;
              }
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void jump() {
    if (!gameOver && !gameWon) {
      setState(() => velocity = -0.02);
    }
  }

  void restart() {
    setState(() {
      heartY = 0.5;
      velocity = 0;
      obstacles = [];
      score = 0;
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: jump,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFC0CB), Color(0xFFFFB6C1)],
            ),
          ),
          child: Stack(
            children: [
              CustomPaint(
                painter: GamePainter(heartY, obstacles),
                child: Container(),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: ElevatedButton(
                  onPressed: widget.onBack,
                  child: const Text('← Volver'),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: Text(
                  'Puntos: $score/10',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              if (gameOver)
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('😢', style: TextStyle(fontSize: 60)),
                          const Text('¡Inténtalo de nuevo!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          ElevatedButton(onPressed: restart, child: const Text('Reintentar')),
                        ],
                      ),
                    ),
                  ),
                ),
              if (gameWon)
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('🎉', style: TextStyle(fontSize: 60)),
                          const Text('¡Ganaste!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          const Text('¡Eres increíble, ñaña!', style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 20),
                          ElevatedButton(onPressed: widget.onBack, child: const Text('Volver al Menú')),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  final double heartY;
  final List<Obstacle> obstacles;

  GamePainter(this.heartY, this.obstacles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFF1493);

    for (var obs in obstacles) {
      final x = obs.x * size.width;
      final gapY = obs.gapY * size.height;

      canvas.drawRect(Rect.fromLTWH(x, 0, 60, gapY - 100), paint);
      canvas.drawRect(Rect.fromLTWH(x, gapY + 100, 60, size.height - gapY - 100), paint);
    }

    final heartPaint = Paint()..color = const Color(0xFFFF1493);
    final heartX = size.width * 0.2;
    final heartYPos = heartY * size.height;
    
    final path = Path();
    path.moveTo(heartX, heartYPos + 12);
    path.cubicTo(heartX, heartYPos, heartX - 20, heartYPos - 12, heartX - 20, heartYPos + 4);
    path.cubicTo(heartX - 20, heartYPos + 20, heartX, heartYPos + 28, heartX, heartYPos + 40);
    path.cubicTo(heartX, heartYPos + 28, heartX + 20, heartYPos + 20, heartX + 20, heartYPos + 4);
    path.cubicTo(heartX + 20, heartYPos - 12, heartX, heartYPos, heartX, heartYPos + 12);
    canvas.drawPath(path, heartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class NotesScreen extends StatelessWidget {
  final VoidCallback onBack;
  const NotesScreen({super.key, required this.onBack});

  final List<NoteData> notes = const [
    NoteData('💕', 'Eres Fuerte', 'Sé que has pasado por momentos difíciles, pero siempre has salido adelante. Eres más fuerte de lo que crees.'),
    NoteData('✨', 'Eres Increíble', 'No dejes que nadie te haga sentir menos. Eres una persona increíble y mereces todo lo mejor.'),
    NoteData('🌟', 'Siempre Aquí', 'Pase lo que pase, siempre estaré aquí para ti. Somos ñañas para siempre.'),
    NoteData('💖', 'Te Quiero', 'Te quiero mucho, ñaña. Eres una de las personas más importantes en mi vida.'),
    NoteData('🌸', 'Eres Especial', 'Nunca olvides lo especial que eres. Iluminas la vida de todos a tu alrededor.'),
    NoteData('🦋', 'Nuevos Comienzos', 'Este es un nuevo comienzo. Cosas mejores están por venir, te lo prometo.'),
    NoteData('🌈', 'Mereces Felicidad', 'Mereces ser feliz y estar con alguien que te valore. No te conformes con menos.'),
    NoteData('💝', 'Familia', 'El amor de familia es el más puro. Y yo siempre te amaré incondicionalmente.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
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
                    ElevatedButton(onPressed: onBack, child: const Text('← Volver')),
                    const Text('💌 Notas de Cariño', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: notes.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(notes[index].icon, style: const TextStyle(fontSize: 50)),
                          const SizedBox(height: 12),
                          Text(notes[index].title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFF1493)), textAlign: TextAlign.center),
                          const SizedBox(height: 8),
                          Text(notes[index].message, style: const TextStyle(fontSize: 16, color: Color(0xFFFF69B4)), textAlign: TextAlign.center),
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

class PhotosScreen extends StatelessWidget {
  final VoidCallback onBack;
  const PhotosScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final photos = [
      'assets/imagen1.jpg',
      'assets/imagen2.jpg',
      'assets/imagen3.jpg',
      'assets/imagen4.jpg',
      'assets/imagen5.jpg',
      'assets/umagen6.jpg',
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
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
                    ElevatedButton(onPressed: onBack, child: const Text('← Volver')),
                    const Text('📸 Nuestras Fotos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: photos.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(photos[index], height: 300, fit: BoxFit.cover),
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

class FloatingHearts extends StatelessWidget {
  const FloatingHearts({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        20,
        (index) => FloatingHeart(delay: index * 0.15),
      ),
    );
  }
}

class FloatingHeart extends StatefulWidget {
  final double delay;
  const FloatingHeart({super.key, required this.delay});

  @override
  State<FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<FloatingHeart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double x;

  @override
  void initState() {
    super.initState();
    x = Random().nextDouble();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000 + (Random().nextDouble() * 2000).toInt()),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: x * MediaQuery.of(context).size.width,
          top: (1.2 - _controller.value * 1.4) * MediaQuery.of(context).size.height,
          child: const Opacity(
            opacity: 0.3,
            child: Text('💕', style: TextStyle(fontSize: 30)),
          ),
        );
      },
    );
  }
}

class Obstacle {
  final double x;
  final double gapY;
  final bool passed;
  Obstacle(this.x, this.gapY, this.passed);
}

class NoteData {
  final String icon;
  final String title;
  final String message;
  const NoteData(this.icon, this.title, this.message);
}
