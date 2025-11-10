import 'package:flutter/material.dart';
import '../state/plan_provider.dart';
import '../models/data_layer.dart';
import 'plan_screen.dart';

class MasterHome extends StatelessWidget {
  const MasterHome({super.key});

  @override
  Widget build(BuildContext context) {
    final plansNotifier = PlanProvider.of(context);
    return ValueListenableBuilder<List<Plan>>(
      valueListenable: plansNotifier,
      builder: (context, plans, _) {
        if (plans.isEmpty) {
          return const EmptyPlansPage();
        }
        return PlanScreen(plan: plans.first);
      },
    );
  }
}

class EmptyPlansPage extends StatefulWidget {
  const EmptyPlansPage({super.key});

  @override
  State<EmptyPlansPage> createState() => _EmptyPlansPageState();
}

class _EmptyPlansPageState extends State<EmptyPlansPage> {
  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('No Master Plan'),
            content: const Text(
              'You don\'t have a Master Plan yet. Create one to start adding tasks.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.note, size: 100, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'No master plan found.\nTap the button below to create your first plan.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Create Master Plan'),
                onPressed: () {
                  final plansNotifier = PlanProvider.of(context);
                  const newPlan = Plan(name: 'Master Plan', tasks: []);
                  plansNotifier.value =
                      List<Plan>.from(plansNotifier.value)..add(newPlan);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const MasterHome()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


