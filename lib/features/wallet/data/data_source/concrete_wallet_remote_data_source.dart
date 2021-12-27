//
// import 'package:dartz/dartz.dart';
// import 'package:dio/src/cancel_token.dart';
// import 'package:ojos_app/core/constants.dart';
// import 'package:ojos_app/core/errors/base_error.dart';
// import 'package:ojos_app/core/http/http_method.dart';
// import 'package:ojos_app/features/wallet/data/api_response/wallet_response.dart';
// import 'package:ojos_app/features/wallet/data/data_source/remote_wallet_data_spource.dart';
//
// class ConcreteRemoteWalletDataSource extends RemoteWalletDataSource{
//   @override
//   Future<Either<BaseError, RegisterResultModel>> getMyWallet({CancelToken? cancelToken}) {
//     return request<RegisterResultModel, RegisterResponse>(
//       responseStr: 'RegisterResponse',
//       converter: (json) => WalletResponse.fromJson(json),
//       method: HttpMethod.GET,
//       //data: data!.toJson(),
//       url: API_GET_WALLET,
//       withAuthentication: false,
//       cancelToken: cancelToken!,
//     );
//   }
//
// }