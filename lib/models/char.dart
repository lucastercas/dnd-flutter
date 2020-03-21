class Character {
  Character(
      this.name,
      this.surname,
      this.avatar,
      this.abilities,
      this.spells,
      this.skills,
      this.race,
      this.charClass,
      this.alignment,
      this.maxHealth,
      this.curHealth,
      this.tempHealth,
      this.healing,
      this.level,
      this.armour,
      this.proficiencies,
      this.proficiencyBonus,
      this.savingThrows);

  final String name;
  final String surname;
  final String avatar;

  final int level;
  final String race;
  final String charClass;

  final List<dynamic> proficiencies;
  final Map<String, dynamic> abilities;
  final int proficiencyBonus;
  final Map<String, dynamic> spells;
  final Map<String, dynamic> skills;
  final Map<String, dynamic> savingThrows;

  final String alignment;

  final int maxHealth;
  final int curHealth;
  final int healing;
  final int tempHealth;
  final int armour;

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        abilities = json['abilities'],
        skills = json['skills'],
        avatar = json['avatar'],
        spells = json['spells'],
        race = json['race'],
        level = json['level'],
        alignment = json['alignment'],
        charClass = json['class'],
        maxHealth = json['maxHealth'],
        curHealth = json['curHealth'],
        tempHealth = json['tempHealth'],
        healing = json['healing'],
        proficiencies = json['proficiencies'],
        savingThrows = json['savingThrows'],
        armour = json['armour'],
        proficiencyBonus = json['proficiencyBonus'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'spells': spells,
        'race': race,
        'level': level,
        'class': charClass,
        'maxHealth': maxHealth,
        'avatar': avatar,
        'curHealth': curHealth,
        'tempHealth': tempHealth,
        'savingThrows': savingThrows,
        'healing': healing,
        'proficiencies': proficiencies,
        'abilities': abilities,
        'armour': armour,
        'proficiencyBonus': proficiencyBonus,
      };
}
