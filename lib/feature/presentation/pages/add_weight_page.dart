import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/presentation/cubit/weight/weight_cubit.dart';

class AddNewWeightPage extends StatefulWidget {
  final String uid;
  AddNewWeightPage({super.key, required this.uid});

  @override
  State<AddNewWeightPage> createState() => _AddNewWeightPageState();
}

class _AddNewWeightPageState extends State<AddNewWeightPage> {
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${DateFormat("dd MMM hh:mm a").format(DateTime.now())}}"),
            Expanded(
                child: Scrollbar(
                    child: TextFormField(
              controller: _weightController,
              maxLines: 1,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "start typing...."),
            ))),
            InkWell(
              onTap: _submitNewWeight,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitNewWeight() {
    if (_weightController.text.isNotEmpty) {
      BlocProvider.of<WeightCubit>(context).addWeight(
          weight: WeightEntity(
              date: Timestamp.now(),
              weight: _weightController.text,
              uid: widget.uid));
    }
  }
}
