class Player {
  final String name;
  final String color;
  String id = "";

  Player(this.name, this.color);

  Player.fromPlayer(Player another)
      : color = another.color,
        name = another.name;
}
