import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
final _formKey = GlobalKey<FormState>();

// Controllers for adding new items
final TextEditingController teamController = TextEditingController();
final TextEditingController jumlahAnggotaController = TextEditingController();
final TextEditingController tanggalPendakianController = TextEditingController();
final TextEditingController tanggalTurunController = TextEditingController();
final TextEditingController nomorHPController = TextEditingController();
final TextEditingController alamatController = TextEditingController();

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF94CABD),
        title: Text(
          'Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('registrations').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                final titleEdc = TextEditingController(text: data['title'].toString());
                final noteEdc = TextEditingController(text: data['note'].toString());
                final jumlahAnggotaEdc = TextEditingController(text: data['jumlahAnggota'].toString());
                final tanggalPendakianEdc = TextEditingController(text: data['tanggalPendakian'].toString());
                final tanggalTurunEdc = TextEditingController(text: data['tanggalTurun'].toString());
                final nomorHPEdc = TextEditingController(text: data['nomorHP'].toString());
                final alamatEdc = TextEditingController(text: data['alamat'].toString());

                return InkWell(
                  onTap: () {},
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(data['title'],
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0)),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditBottomSheet(
                                      context,
                                      document.id,
                                      titleEdc,
                                      noteEdc,
                                      jumlahAnggotaEdc,
                                      tanggalPendakianEdc,
                                      tanggalTurunEdc,
                                      nomorHPEdc,
                                      alamatEdc,
                                    );
                                  } else if (value == 'delete') {
                                    _firestore.collection('registrations').doc(document.id).delete();
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Hapus'),
                                  ),
                                ],
                                child: Icon(Icons.more_vert_outlined),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            data['note'],
                            textAlign: TextAlign.justify,
                            maxLines: 5,
                            style: const TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddBottomSheet(BuildContext context) {
    teamController.clear();
    jumlahAnggotaController.clear();
    tanggalPendakianController.clear();
    tanggalTurunController.clear();
    nomorHPController.clear();
    alamatController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: teamController,
                  decoration: const InputDecoration(hintText: 'Team Pendakian'),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: jumlahAnggotaController,
                  decoration: const InputDecoration(hintText: 'Jumlah Anggota'),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: tanggalPendakianController,
                  decoration: const InputDecoration(hintText: 'Tanggal Pendakian'),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: tanggalTurunController,
                  decoration: const InputDecoration(hintText: 'Tanggal Turun'),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: nomorHPController,
                  decoration: const InputDecoration(hintText: 'Nomor HP'),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: alamatController,
                  decoration: const InputDecoration(hintText: 'Alamat'),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await _firestore.collection('registrations').add({
                              'title': teamController.text,
                              'note': '',
                              'jumlahAnggota': jumlahAnggotaController.text,
                              'tanggalPendakian': tanggalPendakianController.text,
                              'tanggalTurun': tanggalTurunController.text,
                              'nomorHP': nomorHPController.text,
                              'alamat': alamatController.text,
                              'timestamp': FieldValue.serverTimestamp(),
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Data berhasil disimpan')),
                            );
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$e')),
                            );
                          }
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditBottomSheet(
      BuildContext context,
      String documentId,
      TextEditingController titleEdc,
      TextEditingController noteEdc,
      TextEditingController jumlahAnggotaEdc,
      TextEditingController tanggalPendakianEdc,
      TextEditingController tanggalTurunEdc,
      TextEditingController nomorHPEdc,
      TextEditingController alamatEdc,
      ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    TextFormField(
    controller: titleEdc,
    decoration: const InputDecoration(hintText: 'Title'),
    ),
    const SizedBox(height: 10.0),
    TextFormField(
    controller: noteEdc,
    decoration: const InputDecoration(hintText: 'Note'),
    ),
    const SizedBox(height: 10.0),
    TextFormField(
    controller: jumlahAnggotaEdc,
    decoration: const InputDecoration(hintText: 'Jumlah Anggota'),                ),
      const SizedBox(height: 10.0),
      TextFormField(
        controller: tanggalPendakianEdc,
        decoration: const InputDecoration(hintText: 'Tanggal Pendakian'),
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        controller: tanggalTurunEdc,
        decoration: const InputDecoration(hintText: 'Tanggal Turun'),
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        controller: nomorHPEdc,
        decoration: const InputDecoration(hintText: 'Nomor HP'),
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        controller: alamatEdc,
        decoration: const InputDecoration(hintText: 'Alamat'),
      ),
      const SizedBox(height: 10.0),
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await _firestore.collection('registrations').doc(documentId).update({
                    'title': titleEdc.text,
                    'note': noteEdc.text,
                    'jumlahAnggota': jumlahAnggotaEdc.text,
                    'tanggalPendakian': tanggalPendakianEdc.text,
                    'tanggalTurun': tanggalTurunEdc.text,
                    'nomorHP': nomorHPEdc.text,
                    'alamat': alamatEdc.text,
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data berhasil diperbarui')),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$e')),
                  );
                }
              }
            },
            child: const Text('Update'),
          ),
        ),
      ),
    ],
    ),
    ),
      );
        },
    );
  }
}


