import 'package:flutter/material.dart';

import '../../constant.dart';

class TransactionsEnCoursItems extends StatefulWidget {
  const TransactionsEnCoursItems({super.key});

  @override
  State<TransactionsEnCoursItems> createState() =>
      _TransactionsEnCoursItemsState();
}

class _TransactionsEnCoursItemsState extends State<TransactionsEnCoursItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.5,
      decoration: BoxDecoration(
          color: teraGrey, borderRadius: BorderRadius.circular(5)),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            TransactionItem(),
            TransactionItem(),
            TransactionItem(),
            TransactionItem(),
          ],
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: teraDark,
      child: Row(
        children: [
          Image.asset(
            "assets/patate.png",
            scale: 14,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: 230,
            height: 70,
            color: teraOrange,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/icons8-poids-90.png",
                          scale: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "20 Kg",
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/icons8-sac-dargent-90.png",
                          scale: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "160000 F",
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/icons8-poids-90.png",
                          scale: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Ibrahima Dia",
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/icons8-sac-dargent-90.png",
                          scale: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Id",
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Image.asset(
                  "assets/icons/icons8-plus-90.png",
                  color: Colors.white,
                  scale: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
