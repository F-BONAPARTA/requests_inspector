// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:requests_inspector/requests_inspector.dart';

class RequestDetails {
  late final String requestName;
  final RequestMethod requestMethod;
  final String url;
  final int? statusCode;
  final dynamic headers;
  final dynamic queryParameters;
  final dynamic requestBody;
  final dynamic responseBody;
  late final DateTime sentTime;
  RequestDetails({
    String? requestName,
    required this.requestMethod,
    required this.url,
    this.statusCode,
    this.headers,
    this.queryParameters,
    this.requestBody,
    this.responseBody,
    DateTime? sentTime,
  }) {
    this.requestName = requestName ?? _extractName(url);
    this.sentTime = sentTime ?? DateTime.now();
  }

  String _extractName(String url) {
    url = url.split('?').first;
    final name = url.split('/').last;
    return name.toUpperCase();
  }

  RequestDetails copyWith({
    String? requestName,
    RequestMethod? requestMethod,
    String? url,
    int? statusCode,
    headers,
    queryParameters,
    requestBody,
    responseBody,
    DateTime? sentTime,
  }) {
    return RequestDetails(
      requestName: requestName ?? this.requestName,
      requestMethod: requestMethod ?? this.requestMethod,
      url: url ?? this.url,
      statusCode: statusCode ?? this.statusCode,
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
      requestBody: requestBody ?? this.requestBody,
      responseBody: responseBody ?? this.responseBody,
      sentTime: sentTime ?? this.sentTime,
    );
  }

  @override
  String toString() {
    return 'RequestDetails(requestName: $requestName, requestMethod: $requestMethod, url: $url, statusCode: $statusCode, headers: $headers, queryParameters: $queryParameters, requestBody: $requestBody, responseBody: $responseBody, sentTime: $sentTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestDetails &&
        other.requestName == requestName &&
        other.requestMethod == requestMethod &&
        other.url == url &&
        other.statusCode == statusCode &&
        other.headers == headers &&
        other.queryParameters == queryParameters &&
        other.requestBody == requestBody &&
        other.responseBody == responseBody &&
        other.sentTime == sentTime;
  }

  @override
  int get hashCode {
    return requestName.hashCode ^
        requestMethod.hashCode ^
        url.hashCode ^
        statusCode.hashCode ^
        headers.hashCode ^
        queryParameters.hashCode ^
        requestBody.hashCode ^
        responseBody.hashCode ^
        sentTime.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestName': requestName,
      'requestMethod': requestMethod.name,
      'url': url,
      'statusCode': statusCode,
      'headers': headers,
      'queryParameters': queryParameters,
      'requestBody': requestBody,
      'responseBody': responseBody,
      'sentTime': sentTime.toIso8601String(),
    }..removeWhere((_, v) => v == null);
  }

  factory RequestDetails.fromMap(Map<String, dynamic> map) {
    return RequestDetails(
      requestName: map['requestName'],
      requestMethod: RequestMethod.values
          .firstWhere((e) => e.name == map['requestMethod']),
      url: map['url'] as String,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      headers: map['headers'] as dynamic,
      queryParameters: map['queryParameters'] as dynamic,
      requestBody: map['requestBody'] as dynamic,
      responseBody: map['responseBody'] as dynamic,
      sentTime: DateTime.parse(map['sentTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestDetails.fromJson(String source) =>
      RequestDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
