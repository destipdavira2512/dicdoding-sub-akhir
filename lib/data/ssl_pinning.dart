import 'package:flutter/services.dart';
import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class ClassSSLPinning extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createLEClient();

  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<HttpClient> customHttpClient({
    bool isTestMode = false,
  }) async {
    HttpOverrides.global = new ClassSSLPinning();
    SecurityContext context = SecurityContext(withTrustedRoots: false);

    try {
      List<int> bytes = [];

      if (isTestMode) {
        bytes = utf8.encode(_certificate);
      } else {
        bytes = (await rootBundle.load('certificates/certificate.cer'))
            .buffer
            .asUint8List();
      }

      context.setTrustedCertificatesBytes(bytes);
    } on TlsException catch (error) {
      if (error.osError?.message != null &&
          error.osError!.message
              .contains('Certificate already in hash table')) {
        log('createHttpClient() - certificate already trusted.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $error');
      }
    } catch (error) {
      log('unexpected error $error');
    }
    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createLEClient({bool isTestMode = false}) async {
    IOClient client = IOClient(await customHttpClient(isTestMode: isTestMode));
    return client;
  }
}

const _certificate = """-----BEGIN CERTIFICATE-----
MIIF5zCCBM+gAwIBAgIQAdKnBRs48TrGZbcfFRKNgDANBgkqhkiG9w0BAQsFADBG
MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRUwEwYDVQQLEwxTZXJ2ZXIg
Q0EgMUIxDzANBgNVBAMTBkFtYXpvbjAeFw0yMTEwMjEwMDAwMDBaFw0yMjExMTgy
MzU5NTlaMBsxGTAXBgNVBAMMECoudGhlbW92aWVkYi5vcmcwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQC8Ec+A4PYy8acf0O0ebSymr7jvuwlpv9AE4hHi
0/zpeHn+oRQcQ950dPPkiFTyxGQ1ZaaWpujOOMhXEj7Y9qX7Q6hYGv3Y2XQbErba
WG0dYZOT5LVxd6Fedj/TcyICVDU2suK6vqndug1XUqTRsfMTY994gHWf6QL2+VL0
wFIfUcbpxzRhYLOIEmPlIxPpdzDvrh3cX73U0VvDIycbmxUgI/DkdqFyE93QJafK
bD2qa+szpXicUHAGf3u+wLdEuXHwZ1hAjsheOW5+IciMKYCybSM0pm5Ik90et75B
ye8vY9sQukK6uGY5Bm9upYJhco3cTbYJTadKTZ+ukVMqRfz3AgMBAAGjggL6MIIC
9jAfBgNVHSMEGDAWgBRZpGYGUqB7lZI8o5QHJ5Z0W/k90DAdBgNVHQ4EFgQUbBJ2
pTVTIhbl/i1hSGCoJQJTUaAwKwYDVR0RBCQwIoIQKi50aGVtb3ZpZWRiLm9yZ4IO
dGhlbW92aWVkYi5vcmcwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUF
BwMBBggrBgEFBQcDAjA9BgNVHR8ENjA0MDKgMKAuhixodHRwOi8vY3JsLnNjYTFi
LmFtYXpvbnRydXN0LmNvbS9zY2ExYi0xLmNybDATBgNVHSAEDDAKMAgGBmeBDAEC
ATB1BggrBgEFBQcBAQRpMGcwLQYIKwYBBQUHMAGGIWh0dHA6Ly9vY3NwLnNjYTFi
LmFtYXpvbnRydXN0LmNvbTA2BggrBgEFBQcwAoYqaHR0cDovL2NydC5zY2ExYi5h
bWF6b250cnVzdC5jb20vc2NhMWIuY3J0MAwGA1UdEwEB/wQCMAAwggF9BgorBgEE
AdZ5AgQCBIIBbQSCAWkBZwB1ACl5vvCeOTkh8FZzn2Old+W+V32cYAr4+U1dJlwl
XceEAAABfKGE524AAAQDAEYwRAIgUuAFRBhoFIqgzBGJg12YDv26moS9xRx0UmYe
VOi3YVECIGigEG/HSrh+Jhw+pj8GrPji5zLZev/NhFbgAI9Z+JigAHUAQcjKsd8i
RkoQxqE6CUKHXk4xixsD6+tLx2jwkGKWBvYAAAF8oYTnXwAABAMARjBEAiBnWphw
CrLg7u6jOnaxRRQ0A7ESan6hbsDiPg+tUmoo5QIgOKufQRsQDiw8COBmdDKjQxcJ
Cwj0RnnE+JWKBKjD8tgAdwDfpV6raIJPH2yt7rhfTj5a6s2iEqRqXo47EsAgRFwq
cwAAAXyhhOeyAAAEAwBIMEYCIQClg2eAirkVpLAsrz7a97zxraww48oc1AnCx/07
4YD0jAIhANtSG6mNHQ3Qk85GEfyl4dI1sAJ8gjOAI4kG+ZbR5iFYMA0GCSqGSIb3
DQEBCwUAA4IBAQA+0VPryDt08DgXGPiQc/LVh2aqx0Si0wylNF7zgVtBh2nzdPV7
18Qex5uK+Z4VjnBFzLQ7wUkLh8MNi2uJmxyX0tdhATJ2sdGieHuGdcJnjZYHMXqP
AAHoVgjJSWWhy+t66cPauipX2dR0b4Ul0cz42aRlmpExJwRqm7jCtpaJU3nuxOwN
jia+Kff2MpLspB3nHmHOZ2gvwU05oiZQvnranwshboDhCDV3ucFX4IKPr74+1P8l
DUpiVEdsyxDA9Sbkc2QS57dWiD0Ju55Sxhhd1uSHi4aqKaFpAA4XZr4edUwWFE4c
4JJi1ufB/lOcf+G5uV2HrO27/FScF/8dZyzy
-----END CERTIFICATE-----""";
