//mail
//GET https://graph.microsoft.com/v1.0/me/messages?$select=sender,subject
import 'package:nobody/references.dart';

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

@NomoCode()
class MailQuery extends GraphQuery {
  /// constructor
  MailQuery(GraphServiceClient graph_client)
      : super(graph_client, "/me/messages");

  /// special (mail related) functionalities

  /// with subject
  Future<MailQuery> with_subject(String subject) async {
    await super.filter("subject eq '$subject'");
    return this;
  }

  /// with sender
  Future<MailQuery> from(String sender) async {
    await super.filter("sender eq '$sender'");
    return this;
  }

  /// with receiver
  Future<MailQuery> to(String receiver) async {
    await super.filter("receiver eq '$receiver'");
    return this;
  }

  /// before
  Future<MailQuery> before(DateTime date) async {
    await super.filter("receivedDateTime lt '$date'");
    return this;
  }

  /// after
  Future<MailQuery> after(DateTime date) async {
    await super.filter("receivedDateTime gt '$date'");
    return this;
  }

  ///between
  Future<MailQuery> between(DateTime start, DateTime end) async {
    await super
        .filter("receivedDateTime gt '$start' and receivedDateTime lt '$end'");
    return this;
  }

  /// has attachment
  Future<MailQuery> with_attachment() async {
    await super.filter("hasAttachments eq true");
    return this;
  }
}
