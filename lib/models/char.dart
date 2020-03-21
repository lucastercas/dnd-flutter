import 'package:cloud_firestore/cloud_firestore.dart';

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
    this.savingThrows,
  );

  String name;
  String surname;
  String avatar;

  int level;
  String race;
  String charClass;

  List<dynamic> proficiencies;
  Map<dynamic, dynamic> abilities;
  int proficiencyBonus;
  Map<dynamic, dynamic> spells;
  Map<dynamic, dynamic> skills;
  Map<dynamic, dynamic> savingThrows;

  String alignment;

  int maxHealth;
  int curHealth;
  int healing;
  int tempHealth;
  int armour;

  void takeDamage(int amount) {
    if (this.armour > 0)
      this.armour -= amount;
    else
      this.curHealth -= amount;
  }

  void heal(int amount) {
    this.healing += amount;
  }

  Character.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        surname = snapshot['surname'],
        abilities = snapshot['abilities'],
        skills = snapshot['skills'],
        avatar = snapshot['avatar'],
        spells = snapshot['spells'],
        race = snapshot['race'],
        level = snapshot['level'],
        alignment = snapshot['alignment'],
        charClass = snapshot['class'],
        maxHealth = snapshot['maxHealth'],
        curHealth = snapshot['curHealth'],
        tempHealth = snapshot['tempHealth'],
        healing = snapshot['healing'],
        proficiencies = snapshot['proficiencies'],
        savingThrows = snapshot['savingThrows'],
        armour = snapshot['armour'],
        proficiencyBonus = snapshot['proficiencyBonus'];

  Character.fromJson(Map<dynamic, dynamic> json)
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
