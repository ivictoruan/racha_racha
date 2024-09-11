import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Racha Racha',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rache a conta no rolê!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              color: Colors.deepPurple,
            ),
            title: const Text(
              'Histórico de contas',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
              ),
            ),
            onTap: () {
              // Navigator.pop(context); // Fecha o drawer antes de navegar
              // Lógica a ser executada ao pressionar a opção de histórico de contas
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.deepPurple,
            ),
            title: const Text(
              'Perfil',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
              ),
            ),
            onTap: () {
              // Navigator.pop(context); // Fecha o drawer antes de navegar
              // Lógica a ser executada ao pressionar a opção de configurações
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.help,
              color: Colors.deepPurple,
            ),
            title: const Text(
              'Ajuda',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
              ),
            ),
            onTap: () {
              // Navigator.pop(context); // Fecha o drawer antes de navegar
              // Lógica a ser executada ao pressionar a opção de ajuda
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.deepPurple,
            ),
            title: const Text(
              'Sair',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
              ),
            ),
            onTap: () {
              // Navigator.pop(context); // Fecha o drawer antes de navegar
              // Lógica a ser executada ao pressionar a opção de sair
            },
          ),
        ],
      ),
    );
  }
}
