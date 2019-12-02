class SnapfeedConfigApiResponse {
  SnapfeedConfigApiResponse(
    this.accentColor,
    this.photoURL,
  );

  factory SnapfeedConfigApiResponse.fromJson(Map<String, dynamic> json) {
    return SnapfeedConfigApiResponse(
      json['accentColor'] as int,
      json['photoURL'] as String,
    );
  }

  final int accentColor;
  final String photoURL;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accentColor': accentColor,
      'photoURL': photoURL,
    };
  }
}
