import 'package:flutter/material.dart';
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
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      BlocProvider.of<WeightCubit>(context).moreData;
      Future.delayed(
          Duration(seconds: 1),
          () =>
              BlocProvider.of<WeightCubit>(context).getNextWeights(uid: uid0));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(
          context,
          PageConst.addWeightPage,
        );
      }),
      body: Builder(
        builder: (context) {
          BlocProvider.of<WeightCubit>(context).getWeights(uid: uid0);
          return BlocConsumer<WeightCubit, WeightState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is WeightFailure) {
                return emptyWidget();
              } else {
                return _bodyWidget(state);
              }
            },
          );
        },
      ),
    );
  }

  Widget emptyWidget() => const Center(
        child: Text("Empty!"),
      );

  Widget _bodyWidget(state) {
    var weights = BlocProvider.of<WeightCubit>(context).weights;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 1500,
      child: weights == []
          ? emptyWidget()
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: controller,
                    itemCount: weights.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        onDoubleTap: () => BlocProvider.of<WeightCubit>(context)
                            .deleteWeight(weight: weights[index]),
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
                                weights[index].weight.toString(),
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(DateFormat("dd MMMM YYY hh:mm a")
                                  .format(weights[index].date!.toDate())
                                  .toString())
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (state is WeightLoading) const CircularProgressIndicator()
              ],
            ),
    );
  }
}
