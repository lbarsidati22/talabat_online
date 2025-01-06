import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/view/widgets/lable_with_text_feild.dart';
import 'package:talabat_online/view/widgets/main_bottom.dart';
import 'package:talabat_online/view_models/payment_methods_cubit/pyament_methods_cubit.dart';

class AddNewCartPage extends StatefulWidget {
  const AddNewCartPage({super.key});

  @override
  State<AddNewCartPage> createState() => _AddNewCartPageState();
}

final cardNumberController = TextEditingController();
final holderNameController = TextEditingController();
final cvvController = TextEditingController();
final expyiDataController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _AddNewCartPageState extends State<AddNewCartPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<PyamentMethodsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LableWithTextFeild(
                  hintText: 'Enter card number',
                  icon: Icons.calendar_view_day_outlined,
                  controller: cardNumberController,
                  lable: 'Card Number',
                ),
                LableWithTextFeild(
                  hintText: 'Enter holder name',
                  icon: Icons.person,
                  controller: holderNameController,
                  lable: 'Card Holder Name',
                ),
                LableWithTextFeild(
                  hintText: 'Enter Expired',
                  icon: Icons.date_range,
                  controller: expyiDataController,
                  lable: 'Expired ',
                ),
                LableWithTextFeild(
                  hintText: 'Enter cvv',
                  icon: Icons.lock,
                  controller: cvvController,
                  lable: 'Cvv',
                ),
                SizedBox(
                  height: 16,
                ),
                BlocConsumer<PyamentMethodsCubit, PyamentMethodsState>(
                  listenWhen: (prevouse, current) =>
                      current is AddNewCardError ||
                      current is AddNewCardLoaded ||
                      current is AddNewCardLeading,
                  listener: (context, state) {
                    if (state is AddNewCardLoaded) {
                      Navigator.pop(context);
                    }
                  },
                  bloc: cubit,
                  buildWhen: (previouse, current) =>
                      current is AddNewCardError ||
                      current is AddNewCardLoaded ||
                      current is AddNewCardLeading,
                  builder: (context, state) {
                    if (state is AddNewCardLeading) {
                      return MainBottom(
                        isLeading: true,
                        onTap: null,
                      );
                    }
                    return MainBottom(
                      text: 'Add Card',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.addNewCard(
                              cardNumberController.text,
                              holderNameController.text,
                              expyiDataController.text,
                              cvvController.text);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
