class Note {
  const Note({
    this.id = -1,
    this.title = "",
    this.content = "",
    this.createdAt = "",
  });

  final int id;
  final String title;
  final String content;
  final String createdAt;

  Note copyWith({int? id, String? title, String? content, String? createdAt}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
      );

      @override
  String toString() {
    return "Note(id:$id, title:$title, content:$content, createdAt:$createdAt)\n";
  }
}
