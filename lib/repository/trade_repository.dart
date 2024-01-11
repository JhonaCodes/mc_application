import 'package:deepstatemanagment/infrastructure/api/base_api_impl.dart';
import 'package:deepstatemanagment/infrastructure/db_table.dart';
import 'package:deepstatemanagment/model/trade.dart';

/// Trades repository
class TradeRepository{
  final BaseApiImpl apiImpl;
  TradeRepository(this.apiImpl);

  /// [Stream]
  ///
  /// This method is used to fetch all trades from the API using Stream.
  /// This stream is responsible for maintaining the persistent connection, giving us data changes in real time.
  Stream<List<Trade>> fetchAllTradesStream() async*{
  yield* apiImpl
      .getStream(path: DBTable.trades, key: 'id')
      .asyncMap((List<Map<String, dynamic>> data) async{
    return data.map((record) => Trade.fromJson(record)).toList();
  });

}

  Future<List<Trade>> fetchTradeById(String id) {
    return apiImpl.getById(
        path: DBTable.trades,
        id: id,
    ).then((value) => value.map(Trade.fromJson).toList());
  }

  /// Create trade
  Future<void> addTrade(Trade trade) async{
    await apiImpl.post(DBTable.trades, trade.toJson());
  }

}