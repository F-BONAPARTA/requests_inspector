import 'package:dio/dio.dart';

import '../requests_inspector.dart';

class RequestsInspectorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String rightLink =
        response.requestOptions.path.contains(response.requestOptions.baseUrl)
            ? response.requestOptions.path
            : (response.requestOptions.baseUrl + response.requestOptions.path);
    InspectorController().addNewRequest(
      RequestDetails(
        requestMethod: RequestMethod.values
            .firstWhere((e) => e.name == response.requestOptions.method),
        url: rightLink,
        statusCode: response.statusCode ?? 0,
        headers: response.requestOptions.headers,
        queryParameters: response.requestOptions.queryParameters,
        requestBody: response.requestOptions.data,
        responseBody: response.data,
        sentTime: DateTime.now(),
      ),
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String rightLink =
        err.requestOptions.path.contains(err.requestOptions.baseUrl)
            ? err.requestOptions.path
            : (err.requestOptions.baseUrl + err.requestOptions.path);
    InspectorController().addNewRequest(
      RequestDetails(
        requestMethod: RequestMethod.values
            .firstWhere((e) => e.name == err.requestOptions.method),
        url: rightLink,
        headers: err.requestOptions.headers,
        queryParameters: err.requestOptions.queryParameters,
        requestBody: err.requestOptions.data,
        responseBody: err.message,
        sentTime: DateTime.now(),
      ),
    );
    super.onError(err, handler);
  }
}
