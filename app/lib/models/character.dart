import 'package:cloud_firestore/cloud_firestore.dart';

class Character {
  String name;
  String surname;
  String _avatarUrl;

  int level;
  String race;
  String charClass;

  int proficiencyBonus;
  List<dynamic> proficiencies;
  Map<dynamic, dynamic> _abilities;
  Map<dynamic, dynamic> spells;
  Map<dynamic, dynamic> skills;
  Map<dynamic, dynamic> savingThrows;

  String alignment;

  int maxHealth;
  int curHealth;
  int healing;
  int tempHealth;
  int armour;

  Character() {
    this._abilities = {
      "str": 0,
      "cha": 0,
      "con": 0,
      "dex": 0,
      "int": 0,
      "wis": 0,
    };
    this.proficiencies = [];
    this.spells = {};
    this.skills = {};
    this.savingThrows = {};
  }

  void updateAbility({String name, int value}) {
    this._abilities[name] = value;
  }

  set avatarUrl(String path) => this._avatarUrl = path;

  set strenght(int value) => this._abilities["str"] = value;
  set charisma(int value) => this._abilities["cha"] = value;
  set constitution(int value) => this._abilities["con"] = value;
  set dexterity(int value) => this._abilities["dex"] = value;
  set intelligence(int value) => this._abilities["int"] = value;
  set wisdom(int value) => this._abilities["wid"] = value;

  set abilities(Map<String, int> abilities) => this._abilities = abilities;

  get abilities => this._abilities;
  get avatarUrl => this._avatarUrl;

  Character.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        surname = snapshot['surname'],
        _abilities = snapshot['abilities'],
        skills = snapshot['skills'],
        _avatarUrl = snapshot['avatar'],
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
        _abilities = json['abilities'],
        skills = json['skills'],
        _avatarUrl = json['avatar'],
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
        'avatarUrl': _avatarUrl,
        'curHealth': curHealth,
        'tempHealth': tempHealth,
        'savingThrows': savingThrows,
        'healing': healing,
        'proficiencies': proficiencies,
        'abilities': _abilities,
        'armour': armour,
        'proficiencyBonus': proficiencyBonus,
      };
}
