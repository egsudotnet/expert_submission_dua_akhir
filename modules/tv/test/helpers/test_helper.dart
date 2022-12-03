import 'package:http/io_client.dart';
import 'package:tv/data/datasource/tv_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
