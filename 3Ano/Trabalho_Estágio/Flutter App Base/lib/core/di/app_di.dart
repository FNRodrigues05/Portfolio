import '../../data/di/data_di.dart';
import '../../domain/di/domain_di.dart';
import '../../presentation/di/presentation_di.dart';

void initInjector() {
  setUpDataDi();
  setUpDomainDi();
  setUpPresentationDi();
}
