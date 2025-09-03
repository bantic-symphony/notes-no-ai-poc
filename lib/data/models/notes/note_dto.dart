class NoteDto {
  const NoteDto({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String content;
  final int createdAt;

  factory NoteDto.fromJson(Map<String, dynamic> json) => NoteDto(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'created_at': createdAt,
  };

  @override
  String toString() {
    return '''NoteDto(
    id: $id,
    title: $title,
    content: $content,
    createdAt: $createdAt
    )''';
  }
}
