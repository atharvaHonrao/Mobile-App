import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tsec_app/screens/department_screen/widgets/department_screen_app_bar.dart';
import '../../utils/department_enum.dart';
import '../../widgets/custom_scaffold.dart';

class DepartmentListScreen extends StatelessWidget {
  const DepartmentListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: DepartmentScreenAppBar(title: 'Department'),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            DepartmentList(),
          ],
        ),
      ),
    );
  }
}

class DepartmentList extends StatelessWidget {
  const DepartmentList({Key? key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final DepartmentEnum department = DepartmentEnum.values[index];
            return DeptWidget(
              image: department.name.toLowerCase(),
              department: department,
            );
          },
          childCount: DepartmentEnum.values.length,
        ),
      ),
    );
  }
}

class DeptWidget extends StatelessWidget {
  const DeptWidget({
    Key? key,
    required this.image,
    required this.department,
  }) : super(key: key);

  final String image;
  final DepartmentEnum department;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(
        "/department?department=${department.index}",
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(bottom: 20),
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: EdgeInsets.all(size * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(size * 0.04),
                  child: Image.asset(
                    "assets/images/branches/$image.png",
                    height: 150,
                  ),
                ),
              ),
              Text(
                department.name,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
