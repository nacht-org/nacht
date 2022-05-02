/// Check if the provided [url] is valid
bool isUriValid(String url) {
  final uri = Uri.tryParse(url);
  final isValid =
      uri != null && uri.hasAbsolutePath && uri.scheme.startsWith('http');
  return isValid;
}
