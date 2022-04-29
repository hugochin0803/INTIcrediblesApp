import 'dart:convert';
//import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef ApiErrorCallback = void Function(Object error, String errorText);

const isInProduction = true;

// const String debugHost = 'https://invitedbiz.worldpos.com.my';
// const String productionHost = 'https://ibizapi.worldpos.com.my';
//const endPoint = "";

const debugApi = 'https://edzj-test.fa.em2.oraclecloud.com:443';
const productionApi = 'https://edzj.fa.em2.oraclecloud.com:443';
const endPointApi = isInProduction ? productionApi : debugApi;

class APIService {
  var dio = Dio();

  APIService() {
    dio = Dio();
  }

  Future<void> getHttp() async {}

  Future<void> getDeviceInfo() async {
    // if (Platform.isAndroid) {
    //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //   deviceId = androidInfo.androidId;
    // }
    // if (Platform.isIOS) {
    //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //   deviceId = iosInfo.identifierForVendor;
    // }
  }

  Future<Map<String, String>> getHeaders() async {
    const _storage = FlutterSecureStorage();
    final authToken = await _storage.read(key: 'access_token');
    if (kDebugMode) {
      print(authToken);
    }
    String username = 'scm_master';
    String password = 'Epm@2020';
    if (kDebugMode) {
      print(base64Encode(utf8.encode('$username:$password')));
    }
    return {
      'content-type': 'application/vnd.oracle.adf.resourceitem+json',
      'authorization':
          'Basic ' + base64Encode(utf8.encode('$username:$password'))
    };
  }
}

class APIRoutes {
  static const String getOrganizers =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inventoryOrganizations?onlyData=true';
  static const String getPO =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/linesToReceive?onlyData=true&limit=1000&';
  static const String getInTransit =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/linesToReceive?onlyData=true&limit=1000&';
  static const String getSubInventory =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/activeSubinventories?onlyData=true&limit=1000&';
  static const String getLocator =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/activeLocators?onlyData=true&limit=1000&';
  static const String getItemVailability =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inventoryOnhandBalances?onlyData=true&';
  static const String getUOM =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/unitsOfMeasure?onlyData=true&limit=1000';
  static const String getReason =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inventoryTransactionReasons?limit=1000';
  static const String postReceiveShipment =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/receivingReceiptRequests';

  static const String postTransferCheck =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inTransitShipments?onlyData=true';

  static const String postTransfer =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inventoryStagedTransactions';

  static const String getOnHandBalanceDetails =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/onhandQuantityDetails?limit=1000';

  static const String getOnHandBalanceDetailsForPutAway =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/onhandQuantityDetails?limit=500';

  static const String getReview =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inventoryCompletedTransactions?limit=1000';

  static const String getReturn =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/linesToReturn?limit=1000';

  static const String postReturn =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/receivingReceiptTransactionRequests';

  static const String getRawMaterial =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/itemsV2';

  static const String getSource =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inventoryAccountAliases?limit=1000';

  static const String getAccount =
      '$endPointApi/fscmRestApi/resources/11.13.18.05/inventoryTransactionAccounts?limit=1000';
}
