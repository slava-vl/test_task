import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../free_disk_space/bloc/free_disk_space.dart';
import '../../data/model/payload.dart';

class PayloadWidget extends StatelessWidget {
  final Payload item;
  const PayloadWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(160, 162, 216, 0.3),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
            BoxShadow(
              color: Color.fromRGBO(180, 196, 252, 0.15),
              blurRadius: 8,
              spreadRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.push('/object_scheme', extra: item),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Color.fromRGBO(27, 27, 31, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Отснято сегодня:',
                            style: TextStyle(
                              color: Color.fromRGBO(107, 108, 108, 1),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: '${item.totalPointsCount - item.remainingPoints}',
                                style: const TextStyle(
                                  color: Color.fromRGBO(27, 27, 31, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 4)),
                              TextSpan(text: '/ ${item.totalPointsCount} доступно'),
                            ]),
                            style: const TextStyle(
                              color: Color.fromRGBO(107, 108, 108, 1),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Съемка займет:',
                            style: TextStyle(
                              color: Color.fromRGBO(107, 108, 108, 1),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: '${item.remainingPoints * 5} ГБ',
                                style: const TextStyle(
                                  color: Color.fromRGBO(27, 27, 31, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 4)),
                              WidgetSpan(
                                child: BlocBuilder<FreeDiskSpaceBloc, FreeDiskSpaceState>(
                                  builder: (context, state) {
                                    return Text(
                                      '/ ${state.space.toStringAsFixed(2)} ГБ доступно',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(107, 108, 108, 1),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
