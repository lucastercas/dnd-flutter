class Character {
  final String name;
  final String surname;

  final int level;
  final String race;
  final String charClass;

  final Map<String, dynamic> abilities;
  final Map<String, dynamic> spells;
  final List<dynamic> skills;

  final String alignment;

  final int maxHealth;
  final int curHealth;
  final int healing;

  Character(
    this.name,
    this.surname,
    this.abilities,
    this.spells,
    this.skills,
    this.race,
    this.charClass,
    this.alignment,
    this.maxHealth,
    this.curHealth,
    this.healing,
    this.level,
  );

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        abilities = json['abilities'],
        skills = json['skills'],
        spells = json['spells'],
        race = json['race'],
        level = json['level'],
        alignment = json['alignment'],
        maxHealth = json['maxHealth'],
        charClass = json['class'],
        curHealth = json['curHealth'],
        healing = json['healing'];

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
