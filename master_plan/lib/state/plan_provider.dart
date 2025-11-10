import 'package:flutter/widgets.dart';
import '../models/data_layer.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<List<Plan>>> {
  PlanProvider({
    super.key,
    required Widget child,
    List<Plan> initialPlans = const <Plan>[],
  }) : super(notifier: ValueNotifier<List<Plan>>(initialPlans), child: child);

  static ValueNotifier<List<Plan>> of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    assert(provider != null, 'No PlanProvider found in context');
    return provider!.notifier!;
  }
}


