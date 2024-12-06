import 'package:flutter/material.dart';
import '../objects/imovel.dart';
import '../servers/imoveisServer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Imovel>> futureImovel;

  @override
  void initState() {
    super.initState();
    futureImovel = ApiService().fetchImovel();
  }

  @override
  Widget build(BuildContext context) {
    var corPadrao = const Color.fromARGB(255, 60, 255, 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Imoveis'),
        centerTitle: true,
        backgroundColor: corPadrao,
      ),
      body: Center(
        child: FutureBuilder<List<Imovel>>(
          future: futureImovel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Nenhum dado encontrado');
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final imovel = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: corPadrao.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.corporate_fare_rounded,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                imovel.tipo,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1.5,
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Localização: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              imovel.localizacao,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              "Preço: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "R\$ " + (imovel.preco).toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(children: [
                          const Text(
                            "Quartos: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            (imovel.quartos).toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
