// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// FutureGenerator
// **************************************************************************

/// CODE GENERATED BY NOMOCODE
/// DO NOT EDIT

/// IMPORTING ORIGINAL SOURCE
import 'package:nobody/references.dart';

/// GENERATED EXTENSION
extension ExMailQuery on Future<MailQuery> {
  Future<MailQuery> with_subject(
    String subject,
  ) async {
    var MailQuery = await this;
    return MailQuery.with_subject(
      subject,
    );
  }

  Future<MailQuery> from(
    String sender,
  ) async {
    var MailQuery = await this;
    return MailQuery.from(
      sender,
    );
  }

  Future<MailQuery> to(
    String receiver,
  ) async {
    var MailQuery = await this;
    return MailQuery.to(
      receiver,
    );
  }

  Future<MailQuery> before(
    DateTime date,
  ) async {
    var MailQuery = await this;
    return MailQuery.before(
      date,
    );
  }

  Future<MailQuery> after(
    DateTime date,
  ) async {
    var MailQuery = await this;
    return MailQuery.after(
      date,
    );
  }

  Future<MailQuery> between(
    DateTime start,
    DateTime end,
  ) async {
    var MailQuery = await this;
    return MailQuery.between(
      start,
      end,
    );
  }

  Future<MailQuery> with_attachment() async {
    var MailQuery = await this;
    return MailQuery.with_attachment();
  }
}
