import 'package:dio/dio.dart';
import 'package:nobody/references.dart';

const graph_root = "https://graph.microsoft.com/v1.0";

@NomoCode()
class GraphQuery {
  final GraphServiceClient graph_client;
  Dio get client => graph_client.client;
  final String path;
  List<String> _filters = [];
  List<String> _select = [];
  int _top = 10;
  String? _orderBy;

  Uri get uri {
    var _path = path.startsWith("http")
        ? path
        : path.startsWith("/")
            ? path
            : "/$path";
    var uri = Uri.parse(graph_root + _path);
    var query = Map<String, dynamic>();
    if (_filters.isNotEmpty) {
      query["\$filter"] = _filters.join(" and ");
    }
    if (_select.isNotEmpty) {
      query["\$select"] = _select.join(",");
    }
    if (_top != 10) {
      query["\$top"] = _top;
    }
    if (_orderBy != null) {
      query["\$orderBy"] = _orderBy;
    }
    return uri.replace(queryParameters: query);
  }

  GraphQuery(this.graph_client, this.path);

  Future<GraphQuery> select(List<String> fields) async {
    _select = fields;
    return this;
  }

  Future<GraphQuery> top(int top) async {
    _top = top;
    return this;
  }

  Future<GraphQuery> orderBy(String orderBy) async {
    _orderBy = orderBy;
    return this;
  }

  Future<GraphQuery> filter(String filter) async {
    _filters.add(filter);
    return this;
  }

  Future<dynamic> get() async {
    Show.request("GET", uri.toString());
    try {
      var response = await client.getUri(uri);
      var request = await response.data;
      var body = await request;
      Show.anything(body);
      return body;
    } on DioException catch (e) {
      print(e.response?.data);
      return e.response?.data;
    } on Exception catch (e) {
      print(e);
      return e;
    }
  }

  Future<dynamic> post(Map<String, dynamic> data) async {
    var response = await client.postUri(uri, data: data);
    var request = await response.data;
    var body = await request;
    print(body);
    return body;
  }
}
