import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../state/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key, required this.plan});

  final Plan plan;

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late Plan plan;

  @override
  void initState() {
    super.initState();
    plan = widget.plan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plan Rakai Seto Sembodo')),
      body: _buildList(context),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    final ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final Plan currentPlan = plan;
        final int planIndex =
            planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
        final List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
          ..add(const Task());
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );
        setState(() {
          plan = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );
        });
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(
        plan.tasks[index],
        index,
        context,
      ),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    final ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final Plan currentPlan = plan;
          final int planIndex = planNotifier.value
              .indexWhere((p) => p.name == currentPlan.name);
          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                ),
            );
          setState(() {
            plan = (planNotifier.value[planIndex]);
          });
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final Plan currentPlan = plan;
          final int planIndex = planNotifier.value
              .indexWhere((p) => p.name == currentPlan.name);
          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: text,
                  complete: task.complete,
                ),
            );
          setState(() {
            plan = (planNotifier.value[planIndex]);
          });
        },
      ),
    );
  }
}


