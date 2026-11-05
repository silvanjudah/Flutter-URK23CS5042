
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int round = 0;

  // Stores liked fruit indexes
  final liked = <int>{};

  // Fruit details
  final fruits = const [
    {
      'name': 'Apple',
      'price': '₹180',
      'image': 'assets/apple.jpg'
    },
    {
      'name': 'Orange',
      'price': '₹100',
      'image': 'assets/orange.jpg'
    },
    {
      'name': 'Mango',
      'price': '₹70',
      'image': 'assets/mango.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
        backgroundColor: Colors.orange,
      ),

      // Replay animation button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            round++;
          });
        },
        child: const Icon(Icons.replay),
      ),

      body: ListView.builder(
        key: ValueKey(round),
        itemCount: fruits.length,

        itemBuilder: (context, index) {
          final fruit = fruits[index];

          // Slide up and fade-in animation
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(
              milliseconds: 800 + index * 500,
            ),
            curve: Curves.easeOut,

            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 100 * (1 - value)),
                  child: child,
                ),
              );
            },

            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.asset(
                  fruit['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),

                title: Text(fruit['name']!),
                subtitle: Text(fruit['price']!),

                // Favourite icon animation
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      liked.contains(index)
                          ? liked.remove(index)
                          : liked.add(index);
                    });
                  },

                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),

                    transitionBuilder: (child, anim) {
                      return ScaleTransition(
                        scale: anim,
                        child: child,
                      );
                    },

                    child: Icon(
                      liked.contains(index)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      key: ValueKey(liked.contains(index)),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
