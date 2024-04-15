import 'package:jaspr/jaspr.dart';
import 'package:jaspr_provider/jaspr_provider.dart';

class App extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ChangeNotifierProvider(
      create: (_) => Counter(),
      child: const MyHomePage(),
    );
  }
}

class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyHomePage extends StatelessComponent {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield P(
      children: [
        DomComponent(
          tag: "h1",
          child: const Text('Example'),
        ),
        P(
          children: [
            const Text('You have pushed the button this many times: '),
            Count(),
          ],
        ),
        DomComponent(
          tag: 'button',
          events: {
            'click': (dynamic e) {
              context.read<Counter>().increment();
            },
          },
          child: Text("Press"),
        ),
      ],
    );
  }
}

class P extends StatelessComponent {
  const P({
    Key? key,
    this.child,
    this.children,
  }) : super(key: key);

  final Component? child;
  final List<Component>? children;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield DomComponent(
      tag: 'p',
      child: child,
      children: children,
    );
  }
}

class Count extends StatelessComponent {
  const Count({Key? key}) : super(key: key);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      '${context.watch<Counter>().count}',
      key: const Key('counterState'),
    );
  }
}
