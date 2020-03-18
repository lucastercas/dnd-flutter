class Character {
  final String name;
  final String surname;
  final String race;
  final String charClass;
  final int maxHealth;
  final int curHealth;
  final int healing;
  final int level;
  final Map<String, dynamic> abilities;

  Character(
    this.name,
    this.surname,
    this.race,
    this.charClass,
    this.maxHealth,
    this.curHealth,
    this.healing,
    this.abilities,
    this.level,
  );

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        race = json['race'],
        level = json['level'],
        maxHealth = json['maxHealth'],
        charClass = json['class'],
        curHealth = json['curHealth'],
        healing = json['healing'],
        abilities = json['abilities'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'race': race,
        'level': level,
        'class': charClass,
        'maxHealth': maxHealth,
        'curHealth': curHealth,
        'healing': healing,
        'abilities': abilities,
      };
}
