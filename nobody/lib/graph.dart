import 'package:dio/dio.dart';
import 'package:nobody/references.dart';

@NomoCode()
class GraphServiceClient {
  final String token;
  final Dio client;
  const GraphServiceClient(this.token, this.client);

  //about me
  Future<GraphServiceClient> about_me() async {
    Show.action("GETTING", "USER", "PROFILE");
    var response =
        await client.getUri(Uri.parse('https://graph.microsoft.com/v1.0/me'));
    var request = await response.data;
    var body = await request;
    print(body);
    return this;
  }

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
}



  //mail
  //GET https://graph.microsoft.com/v1.0/me/messages?$select=sender,subject
  ///response:
  /*
      {
        "bccRecipients": [{"@odata.type": "microsoft.graph.recipient"}],
        "body": {"@odata.type": "microsoft.graph.itemBody"},
        "bodyPreview": "string",
        "categories": ["string"],
        "ccRecipients": [{"@odata.type": "microsoft.graph.recipient"}],
        "changeKey": "string",
        "conversationId": "string",
        "conversationIndex": "String (binary)",
        "createdDateTime": "String (timestamp)",
        "flag": {"@odata.type": "microsoft.graph.followupFlag"},
        "from": {"@odata.type": "microsoft.graph.recipient"},
        "hasAttachments": true,
        "id": "string (identifier)",
        "importance": "String",
        "inferenceClassification": "String",
        "internetMessageHeaders": [{"@odata.type": "microsoft.graph.internetMessageHeader"}],
        "internetMessageId": "String",
        "isDeliveryReceiptRequested": true,
        "isDraft": true,
        "isRead": true,
        "isReadReceiptRequested": true,
        "lastModifiedDateTime": "String (timestamp)",
        "parentFolderId": "string",
        "receivedDateTime": "String (timestamp)",
        "replyTo": [{"@odata.type": "microsoft.graph.recipient"}],
        "sender": {"@odata.type": "microsoft.graph.recipient"},
        "sentDateTime": "String (timestamp)",
        "subject": "string",
        "toRecipients": [{"@odata.type": "microsoft.graph.recipient"}],
        "uniqueBody": {"@odata.type": "microsoft.graph.itemBody"},
        "webLink": "string",

        "attachments": [{"@odata.type": "microsoft.graph.attachment"}],
        "extensions": [{"@odata.type": "microsoft.graph.extension"}],
        "multiValueExtendedProperties": [{"@odata.type": "microsoft.graph.multiValueLegacyExtendedProperty"}],
        "singleValueExtendedProperties": [{"@odata.type": "microsoft.graph.singleValueLegacyExtendedProperty"}]
      }
  */

