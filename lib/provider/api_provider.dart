import 'package:deepstatemanagment/infrastructure/api/api_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider<APiDao>((ref) => APiDao());