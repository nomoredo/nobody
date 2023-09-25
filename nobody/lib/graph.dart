import 'package:dio/dio.dart';
import 'package:nobody/references.dart';

@NomoCode()
class GraphServiceClient {
  final String token;
  final Dio client;
  const GraphServiceClient(this.token, this.client);

  ///common helper methods that can be used to call any graph api
  ///example:
  /// await nobody.graph("/me/messages")
  /// .select("sender,subject")
  /// .top(10)
  /// .orderBy("receivedDateTime desc")
  /// .get();
  /// these are generic methods that can be used to call any graph api
  /// the above example is equivalent to the following:
  Future<GraphQuery> graph(String path) async {
    return GraphQuery(this, path);
  }

  ///mail
  ///direct method to get mail related information
  /// routes to /me/messages
  Future<MailQuery> read_mails() async {
    return MailQuery(this);
  }

  ///files
  ///direct method to get files related information
  /// routes to /me/drive/root/children
  Future<GraphQuery> find_files() async {
    return GraphQuery(this, "/me/drive/root/children");
  }
}
