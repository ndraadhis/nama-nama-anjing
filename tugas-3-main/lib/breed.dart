class Breed {
  final String id;
  final String name;
  final String description;
  final Life life;
  final Weight maleWeight;
  final Weight femaleWeight;
  final bool hypoallergenic;
  final String groupId;

  Breed({
    required this.id,
    required this.name,
    required this.description,
    required this.life,
    required this.maleWeight,
    required this.femaleWeight,
    required this.hypoallergenic,
    required this.groupId,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      name: json['attributes']['name'],
      description: json['attributes']['description'],
      life: Life.fromJson(json['attributes']['life']),
      maleWeight: Weight.fromJson(json['attributes']['male_weight']),
      femaleWeight: Weight.fromJson(json['attributes']['female_weight']),
      hypoallergenic: json['attributes']['hypoallergenic'],
      groupId: json['relationships']['group']['data']['id'],
    );
  }
}

class Life {
  final int max;
  final int min;

  Life({required this.max, required this.min});

  factory Life.fromJson(Map<String, dynamic> json) {
    return Life(
      max: json['max'],
      min: json['min'],
    );
  }
}

class Weight {
  final int max;
  final int min;

  Weight({required this.max, required this.min});

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      max: json['max'],
      min: json['min'],
    );
  }
}
