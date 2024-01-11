import 'package:deepstatemanagment/infrastructure/api/base_api_impl.dart';
import 'package:deepstatemanagment/model/trade.dart';
import 'package:deepstatemanagment/repository/trade_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/// [ViewModel]
/// Read [ProductVM] documentation.
class TradeVM extends StateNotifier<List<Trade>>{
  TradeVM( BaseApiImpl apiImpl ):super([]){
    _tradeRepository = TradeRepository(apiImpl);
  }

  late TradeRepository _tradeRepository;

  /// [Stream]
  ///
  /// A [Stream] is a sequence of asynchronous events.
  /// A [Stream] can emit three different kinds of events: a data event, an error event and a done event.
  /// In this case I seek to issue trade information in real time.
  ///
  /// [async*] is used to determine what a [Stream] is and [yield*] to delegate the transmission of data to the next nested function.
  /// In the case that we return only [yield], we are saying that it should take this function as the data emission base.
  /// In the deep implementation [supabase.from(path).stream()] It is the one that emits the events.
  /// For us it is like establishing the connection to the [WebSocket] and receiving the flow of events in order to distribute them through our application using Stream.
  Stream<List<Trade>> getTradesStream() async*{
    yield* _tradeRepository.fetchAllTradesStream();
  }

  Future<void> addTrade(Trade trade) async{
    await _tradeRepository.addTrade(trade);
  }

}