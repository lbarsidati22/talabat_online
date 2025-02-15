import 'package:flutter/material.dart';
import 'package:talabat_online/utils/app_colors.dart';

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
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => initalValue != null
                ? cubit.decrementCounter(prudactId, initalValue)
                : cubit.decrementCounter(prudactId),
            icon: Icon(Icons.remove),
          ),
          Text(
            value.toString(),
          ),
          IconButton(
            onPressed: () => initalValue != null
                ? cubit.icrementCounter(prudactId, initalValue)
                : cubit.icrementCounter(prudactId),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
