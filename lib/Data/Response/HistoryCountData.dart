import 'dart:convert';

class HistoryCountData {
  String? today;
  String? yesterday;
  HistoryCountData({
    this.today,
    this.yesterday,
  });

  HistoryCountData copyWith({
    String? today,
    String? yesterday,
  }) {
    return HistoryCountData(
      today: today ?? this.today,
      yesterday: yesterday ?? this.yesterday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'today': today,
      'yesterday': yesterday,
    };
  }

  factory HistoryCountData.fromMap(Map<String, dynamic> map) {
    return HistoryCountData(
      today: map['today'],
      yesterday: map['yesterday'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryCountData.fromJson(String source) =>
      HistoryCountData.fromMap(json.decode(source));

  @override
  String toString() => 'HistoryCountData(today: $today, yesterday: $yesterday)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryCountData &&
        other.today == today &&
        other.yesterday == yesterday;
  }

  @override
  int get hashCode => today.hashCode ^ yesterday.hashCode;
}
