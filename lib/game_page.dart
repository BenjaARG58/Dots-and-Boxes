import 'package:flutter/material.dart';
import 'app_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int gridSize = 5;

  late List<List<int?>> horizontalLines;
  late List<List<int?>> verticalLines;
  late List<List<int?>> boxes;

  int currentPlayer = 0;
  List<int> scores = [0, 0];

  final playerColors = [Colors.lightBlueAccent, Colors.pinkAccent];
  final backgroundColor = Colors.black;
  final emptyLineColor = Colors.grey.shade900;
  final dotColor = Colors.grey.shade700;

  final double lineThickness = 14;
  final double lineLength = 48;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    horizontalLines = List.generate(gridSize, (_) => List.filled(gridSize - 1, null));
    verticalLines = List.generate(gridSize - 1, (_) => List.filled(gridSize, null));
    boxes = List.generate(gridSize - 1, (_) => List.filled(gridSize - 1, null));
    scores = [0, 0];
    currentPlayer = 0;
  }

  bool isGameOver() {
    for (var row in boxes) {
      for (var box in row) {
        if (box == null) return false;
      }
    }
    return true;
  }

  void drawLine({required bool isHorizontal, required int row, required int col}) {
    setState(() {
      if (isHorizontal) {
        if (horizontalLines[row][col] != null) return;
        horizontalLines[row][col] = currentPlayer;
      } else {
        if (verticalLines[row][col] != null) return;
        verticalLines[row][col] = currentPlayer;
      }

      bool claimedBox = false;

      for (int r = 0; r < gridSize - 1; r++) {
        for (int c = 0; c < gridSize - 1; c++) {
          if (boxes[r][c] != null) continue;

          final top = horizontalLines[r][c] != null;
          final bottom = horizontalLines[r + 1][c] != null;
          final left = verticalLines[r][c] != null;
          final right = verticalLines[r][c + 1] != null;

          if (top && bottom && left && right) {
            boxes[r][c] = currentPlayer;
            scores[currentPlayer]++;
            claimedBox = true;
          }
        }
      }

      if (!claimedBox) currentPlayer = 1 - currentPlayer;
    });
  }

  Widget buildDot() {
    Color color = dotColor;
    if (isGameOver()) {
      if (scores[0] > scores[1]) {
        color = playerColors[0]; // Mavi
      } else if (scores[1] > scores[0]) {
        color = playerColors[1]; // Pembe
      }
    }

    return Container(
      width: lineThickness,
      height: lineThickness,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget buildHorizontalLine(int r, int c) {
    final owner = horizontalLines[r][c];
    return GestureDetector(
      onTap: () => drawLine(isHorizontal: true, row: r, col: c),
      child: Container(
        width: lineLength,
        height: lineThickness,
        decoration: BoxDecoration(
          color: owner == null ? emptyLineColor : playerColors[owner],
          borderRadius: BorderRadius.circular(lineThickness),
        ),
      ),
    );
  }

  Widget buildVerticalLine(int r, int c) {
    final owner = verticalLines[r][c];
    return GestureDetector(
      onTap: () => drawLine(isHorizontal: false, row: r, col: c),
      child: Container(
        width: lineThickness,
        height: lineLength,
        decoration: BoxDecoration(
          color: owner == null ? emptyLineColor : playerColors[owner],
          borderRadius: BorderRadius.circular(lineThickness),
        ),
      ),
    );
  }

  Widget buildBox(int r, int c) {
    final owner = boxes[r][c];
    final color = owner == null
        ? Colors.transparent
        : playerColors[owner].withOpacity(0.4);
    return Container(
      width: lineLength,
      height: lineLength,
      color: color,
    );
  }

  Widget _buildScoreCard({required int player, required String label, required int score}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: playerColors[player].withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: playerColors[player], width: 2),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: playerColors[player],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4, width: 60),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Ka',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: playerColors[0]),
                          children: [
                            TextSpan(text: 're', style: TextStyle(color: playerColors[1])),
                            TextSpan(text: ' Kap', style: TextStyle(color: playerColors[0])),
                            TextSpan(text: 'ma', style: TextStyle(color: playerColors[1])),
                            TextSpan(text: 'ca', style: TextStyle(color: playerColors[0])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            isGameOver()
                ? Text(
              scores[0] > scores[1]
                  ? "Mavi kazandı 🎉"
                  : scores[1] > scores[0]
                  ? "Pembe kazandı 🎉"
                  : "Berabere 🤝",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: scores[0] > scores[1]
                    ? playerColors[0]
                    : scores[1] > scores[0]
                    ? playerColors[1]
                    : Colors.white,
              ),
            )
                : RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.white),
                children: [
                  TextSpan(text: 'Sıra: '),
                  TextSpan(
                    text: currentPlayer == 0 ? 'Mavi' : 'Pembe',
                    style: TextStyle(
                      color: playerColors[currentPlayer],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildScoreCard(player: 0, label: "Mavi", score: scores[0]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'vs',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),
                _buildScoreCard(player: 1, label: "Pembe", score: scores[1]),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(gridSize * 2 - 1, (i) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(gridSize * 2 - 1, (j) {
                        if (i.isEven && j.isEven) return buildDot();
                        if (i.isEven && j.isOdd) return buildHorizontalLine(i ~/ 2, j ~/ 2);
                        if (i.isOdd && j.isEven) return buildVerticalLine(i ~/ 2, j ~/ 2);
                        return buildBox(i ~/ 2, j ~/ 2);
                      }),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _initializeGame()),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade800),
              child: Text("Oyunu Sıfırla", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
