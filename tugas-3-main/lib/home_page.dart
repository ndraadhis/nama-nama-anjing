import 'package:flutter/material.dart';
import 'package:indraadhis_215410070/breed_page.dart';
import 'package:indraadhis_215410070/breed.dart';
import 'user_service.dart';

//HomePage adalah sebuah StatefulWidget yang berfungsi sebagai halaman utama aplikasi. Ini mendefinisikan halaman utama yang akan menampilkan daftar ras anjing.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Breed>> futureBreeds;

  @override
  //initState(): Metode ini dijalankan ketika HomePage pertama kali dibuat. Di sini, futureBreeds diinisialisasi dengan memanggil getBreeds() dari UserService
  void initState() {
    super.initState();
    //late Future<List<Breed>> futureBreeds;: Variabel ini akan menyimpan objek Future yang akan menghasilkan daftar Breed
    futureBreeds = UserService().getBreeds();
  }

  @override
  //build(BuildContext context): Metode ini membangun tampilan antarmuka pengguna. Metode ini mengembalikan sebuah Scaffold dengan sebuah AppBar dan body yang berisi FutureBuilder.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dog Breeds')),
      body: Center(
        //FutureBuilder<List<Breed>>: Widget ini digunakan untuk membangun tampilan berdasarkan hasil dari Future.
        child: FutureBuilder<List<Breed>>(
          //future: futureBreeds: Menetapkan futureBreeds sebagai sumber data FutureBuilder.
          future: futureBreeds,
          builder: (context, AsyncSnapshot<List<Breed>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              //ListView.separated: Widget ini digunakan untuk menampilkan daftar item dengan pemisah di antara setiap item.
              return ListView.separated(
                //itemBuilder: Fungsi ini digunakan untuk membangun setiap item dalam daftar. Dalam hal ini, setiap item adalah sebuah ListTile yang menampilkan nama ras anjing dan umur harapan hidupnya. Jika item di-tap, maka akan memanggil fungsi openPage untuk membuka halaman detail.
                itemBuilder: (context, index) {
                  Breed breed = snapshot.data![index];
                  return ListTile(
                    title: Text(breed.name),
                    subtitle: Text('Life Expectancy: ${breed.life.min} - ${breed.life.max} years'),
                    trailing: const Icon(Icons.chevron_right_outlined),
                    onTap: () => openPage(context, breed),
                  );
                },
                //separatorBuilder: Fungsi ini digunakan untuk membangun pemisah di antara setiap item dalam daftar.
                separatorBuilder: (context, index) {
                  return const Divider(color: Colors.black26);
                },
                //itemCount: Jumlah item dalam daftar diambil dari panjang daftar Breed yang diperoleh dari snapshot.
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
//openPage(BuildContext context, Breed breed): Fungsi ini digunakan untuk navigasi ke halaman detail BreedPage dengan membawa data Breed yang dipilih.
  void openPage(BuildContext context, Breed breed) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BreedPage(breed: breed)),
    );
  }
}
