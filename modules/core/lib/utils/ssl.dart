import 'dart:convert';
import 'dart:io';
 
import 'package:core/utils/constants.dart';

Future<HttpClient> getHttpClient() async {
  final sslCert = utf8.encode(certificate);
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert);
  HttpClient httpClient = HttpClient(context: securityContext);
  httpClient.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;

  return httpClient;
}
