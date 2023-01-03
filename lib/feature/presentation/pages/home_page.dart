import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/app_const.dart';
import 'package:task/feature/presentation/cubit/weight/weight_cubit.dart';
import 'package:task/feature/presentation/cubit/weight/weight_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(
          context,
          PageConst.addWeightPage,
        );
      }),
      body: BlocBuilder<WeightCubit, WeightState>(
        builder: (context, state) {
          if (state is WeightFailure) {
            return emptyWidget();
          }
          if (state is WeightSuccess) {
            BlocProvider.of<WeightCubit>(context).getWeights(uid: uid0);
            return _bodyWidget(state);
          }

          return Center(child: emptyWidget());
        },
      ),
    );
  }

  Widget emptyWidget() => const Center(
        child: Text("Empty!"),
      );

  Widget _bodyWidget(WeightSuccess weightSuccess) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 1500,
      child: weightSuccess.weights == []
          ? emptyWidget()
          : GridView.builder(
              itemCount: weightSuccess.weights.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  onDoubleTap: () => BlocProvider.of<WeightCubit>(context)
                      .deleteWeight(weight: weightSuccess.weights[index]),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: const Offset(0, 1.5))
                        ]),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          weightSuccess.weights[index].weight.toString(),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(DateFormat("dd MMMM YYY hh:mm a")
                            .format(weightSuccess.weights[index].date!.toDate())
                            .toString())
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
