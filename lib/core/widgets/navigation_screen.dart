import 'package:kemet/constants.dart';
import 'package:kemet/features/home/presentation/manager/BNB_cubit/bnbcubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBNavBar extends StatelessWidget {
  const BuildBNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BNBCubit, BnbcubitState>(
      builder: (context, state) {
        var currentIndexFun = BlocProvider.of<BNBCubit>(context);
        int currentIndex = BlocProvider.of<BNBCubit>(context).currentIndex;
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: currentIndex == 0 ? mainColor : Colors.grey,
                      ),
                      onPressed: () {
                        currentIndexFun.changeIndex(0);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: currentIndex == 1 ? mainColor : Colors.grey,
                      ),
                      onPressed: () {
                        currentIndexFun.changeIndex(1);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: currentIndex == 2 ? mainColor : Colors.grey,
                      ),
                      onPressed: () {
                        currentIndexFun.changeIndex(2);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        color: currentIndex == 3 ? mainColor : Colors.grey,
                      ),
                      onPressed: () {
                        currentIndexFun.changeIndex(3);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
