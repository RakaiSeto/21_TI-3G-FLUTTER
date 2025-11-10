import 'package:flutter/material.dart';
import 'views/home.dart';
import 'state/plan_provider.dart';
import 'models/data_layer.dart';

void main() => runApp(const MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Seed initial plan to match the screenshot
    const initialPlan = Plan(name: 'Master Plan Rakai Seto Sembodo', tasks: [
      ],
    );

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: PlanProvider(
        initialPlans: const [initialPlan],
        child: const MasterHome(),
      ),
    );
  }
}
