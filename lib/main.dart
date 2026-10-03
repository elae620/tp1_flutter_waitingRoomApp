
import 'package:flutter/material.dart';
import 'package:waiting_room_app/waiting_room_manager.dart';

void main() {
  runApp(const WaitingRoomApp());
}

class WaitingRoomApp extends StatelessWidget {
  const WaitingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WaitingRoomScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() =>
      _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  // Gestionnaire de la liste des clients
  final WaitingRoomManager _manager = WaitingRoomManager();

  // Contrôleur du champ de saisie
  final TextEditingController _controller = TextEditingController();

  // Ajouter un client
  void _addClient() {
    final name = _controller.text.trim();

    if (name.isNotEmpty) {
      setState(() {
        _manager.addClient(name);
        _controller.clear();
      });
    }
  }

  // Libérer les ressources du contrôleur
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Waiting Room'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            // Champ de saisie et bouton Ajouter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Client Name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addClient(),
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: _addClient,
                  child: const Text('Add'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Nombre de clients dans la file
            Text(
              'Clients in Queue: ${_manager.clients.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Liste des clients avec un bouton Supprimer
            Expanded(
              child: ListView.builder(
                itemCount: _manager.clients.length,

                itemBuilder: (context, index) {
                  final clientName = _manager.clients[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.indigo,
                      ),

                      title: Text(clientName),

                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),

                        tooltip: 'Remove client',

                        onPressed: () {
                          setState(() {
                            _manager.removeClient(clientName);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}