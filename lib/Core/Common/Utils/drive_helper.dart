String convertToDirectDriveLink(String url) {
  if (url.isEmpty || !url.contains("drive.google.com")) {
    return url; // கூகுள் டிரைவ் லிங்க் இல்லை என்றால் அப்படியே திருப்பி அனுப்பும்.
  }

  try {
    String fileId = "";
    if (url.contains("/file/d/")) {
      // https://drive.google.com/file/d/FILE_ID/view... வடிவம்
      final parts = url.split("/file/d/");
      if (parts.length > 1) {
        fileId = parts[1].split("/")[0].split("?")[0];
      }
    } else if (url.contains("id=")) {
      // https://drive.google.com/open?id=FILE_ID வடிவம்
      final uri = Uri.parse(url);
      fileId = uri.queryParameters['id'] ?? "";
    }

    if (fileId.isNotEmpty) {
      return "https://lh3.googleusercontent.com/d/$fileId";
    }
  } catch (e) {
    print("Error parsing Google Drive link: $e");
  }
  return url;
}
