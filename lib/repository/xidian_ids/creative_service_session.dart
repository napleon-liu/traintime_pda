// Copyright 2023 BenderBlog Rodriguez.
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:watermeter/model/xidian_ids/creative.dart';
import 'package:watermeter/repository/xidian_ids/ids_session.dart';

class CreativeServiceSession extends IDSSession {
  static const url = "https://scjspt.xidian.edu.cn";
  static var authorization = "";

  Future<void> initSession() async {
    try {
      var response = await checkAndLogin(
        target: "$url/login/ids",
      );
      String urlReceived = "${response.realUri}";
      String ticket = RegExp(r'ST\S+').firstMatch(urlReceived)![0]!;
      developer.log("Received: $ticket.", name: "CreativeServiceSession");
      bool isLogin = await dio
          .post(
        "$url/api/v1/auth/ids",
        data: {"ticket": ticket},
        options: Options(contentType: ContentType.json.toString()),
      )
          .then(
        (value) {
          if (value.data["code"] == 200) {
            authorization = value.headers.value("Authorization")!;
          }
          return value.data["code"] == 200;
        },
      );

      developer.log(
        "Received: \n${isLogin}\n",
        name: "CreativeServiceSession",
      );

      if (!isLogin) {
        throw NotLoginException();
      } else {
        return;
      }
    } on DioException {
      rethrow;
    }
  }

  Future<List<Job>> getJob() async {
    if (authorization.isEmpty) {
      await initSession();
    }

    var data = await dio
        .post(
          "$url/api/v1/job/query",
          data: {
            "where": [{}],
            "order": "created_at desc",
            "size": 20
          },
          options: Options(
            contentType: ContentType.json.toString(),
            headers: {
              "Authorization": authorization,
            },
          ),
        )
        .then(
          (value) => value.data,
        );

    if (data["code"] != 200) {
      throw NotFetchJobException(msg: data["message"]);
    } else {
      return List<Job>.generate(
        data["total"],
        (index) {
          developer.log(data["data"][index].toString(), name: "CreateSession");
          return Job.fromJson(data["data"][index]);
        } ,
      );
    }
  }
}

class NotLoginException implements Exception {}

class NotFetchJobException implements Exception {
  final String msg;
  const NotFetchJobException({required this.msg});

  @override
  String toString() => msg;
}