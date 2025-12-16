class MateriModel {
  final String title;
  final bool isPdf; // true = PDF (ikon merah), false = dokumen (ikon biru)
  final String type; // "text" | "image"
  final String? imageBase64;

  MateriModel({
    required this.title,
    required this.isPdf,
    this.type = "text",
    this.imageBase64,
  });
}
