class Whether {
  final double whetherCode;
  final double temperature;

  Whether({
    required this.whetherCode,
    required this.temperature,
  });

  factory Whether.fromJson(Map<String, dynamic> json) {
    return Whether(
      temperature: json[""],
      whetherCode: json["weathercode"],
    );
  }
}
