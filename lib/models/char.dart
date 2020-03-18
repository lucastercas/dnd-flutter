class Character {
  final String name;
  final String surname;
  final String race;
  final String charClass;
  final int maxHealth;
  final int curHealth;

  Character(
    this.name,
    this.surname,
    this.race,
    this.charClass,
    this.maxHealth,
    this.curHealth,
  );

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        race = json['race'],
        maxHealth = json['maxHealth'],
        charClass = json['class'],
        curHealth = json['curHealth'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'race': race,
        'class': charClass,
        'maxHealth': maxHealth,
        'curHealth': curHealth
      };
}
