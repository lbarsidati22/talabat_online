import 'package:flutter/material.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/view_models/home_details_cubit/home_details_cubit.dart';

class CounterWidget extends StatelessWidget {
  final dynamic cubit;
  final int value;
  final int? initalValue;
  final String prudactId;
  const CounterWidget({
    super.key,
    required this.cubit,
    required this.value,
    this.initalValue,
    required this.prudactId,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grey,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => cubit.decrementCounter(prudactId),
            // initalValue != null
            //     ? cubit.icrementCounter(prudactId)
            //     : cubit.icrementCounter(prudactId),
            icon: Icon(Icons.remove),
          ),
          Text(
            value.toString(),
          ),
          IconButton(
            onPressed: () => cubit.icrementCounter(prudactId),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
