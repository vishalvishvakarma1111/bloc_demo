import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/timer_demo/tcker.dart';
import 'package:psspl_bloc_demo/timer_demo/timer_bloc/timer_bloc.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: const Ticker()),
      child: BlocConsumer<TimerBloc, TimerState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title: const Text("Timer app")),
              body: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.deepPurpleAccent,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Text(
                      state.duration.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    if (state is TimerInitial) ...[
                      IconButton(
                        onPressed: () {
                          context
                              .read<TimerBloc>()
                              .add(TimerStarted(duration: state.duration));
                        },
                        icon: const Icon(Icons.play_arrow,
                            color: Colors.white, size: 50),
                      ),
                    ],
                    if (state is TimerRunInProgress) ...[
                      IconButton(
                        onPressed: () =>
                            context.read<TimerBloc>().add(TimerPaused()),
                        icon: const Icon(Icons.pause,
                            color: Colors.white, size: 50),
                      ),
                      IconButton(
                        onPressed: () =>
                            context.read<TimerBloc>().add(TimerReset()),
                        icon: const Icon(Icons.replay,
                            color: Colors.white, size: 50),
                      ),
                    ],
                    if (state is TimerRunPause) ...[
                      IconButton(
                        onPressed: () =>
                            context.read<TimerBloc>().add(TimerResumed()),
                        icon: const Icon(Icons.play_arrow,
                            color: Colors.white, size: 50),
                      ),
                      IconButton(
                        onPressed: () =>
                            context.read<TimerBloc>().add(TimerReset()),
                        icon: const Icon(Icons.replay,
                            color: Colors.white, size: 50),
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    if (state is TimerRunComplete)
                      IconButton(
                          onPressed: () =>
                              context.read<TimerBloc>().add(TimerReset()),
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 50,
                          )),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
