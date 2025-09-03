class Note {
  const Note({
    this.id = -1,
    this.title = "",
    this.content = "",
    this.createdAt = -1,
  });

  final int id;
  final String title;
  final String content;
  final int createdAt;
}
