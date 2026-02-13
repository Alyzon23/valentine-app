import 'package:flutter/material.dart';

class GamesMenuScreen extends StatelessWidget {
  final Function(String) onGameSelect;
  final VoidCallback onBack;

  const GamesMenuScreen({
    super.key,
    required this.onGameSelect,
    required this.onBack,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: onBack,
                      child: const Text('← Volver'),
                    ),
                    const Expanded(
                      child: Text(
                        '🎮 Juegos',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 80),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameCard(
                        icon: '💕',
                        title: 'Flappy Heart',
                        description: '¡Vuela entre obstáculos!',
                        onTap: () => onGameSelect('flappy'),
                      ),
                      const SizedBox(height: 16),
                      GameCard(
                        icon: '🧩',
                        title: 'Tetris de Corazones',
                        description: '¡Completa líneas!',
                        onTap: () => onGameSelect('tetris'),
                      ),
                      const SizedBox(height: 16),
                      GameCard(
                        icon: '🐍',
                        title: 'Snake',
                        description: '¡Come corazones!',
                        onTap: () => onGameSelect('snake'),
                      ),
                      const SizedBox(height: 16),
                      GameCard(
                        icon: '🎴',
                        title: 'Memory',
                        description: '¡Encuentra las parejas!',
                        onTap: () => onGameSelect('memory'),
                      ),
                    ],
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

class GameCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 50)),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFF1493)),
                    ),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Color(0xFFFF69B4)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Color(0xFFFF1493)),
            ],
          ),
        ),
      ),
    );
  }
}
