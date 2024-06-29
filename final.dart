import 'dart:io';

class Pelanggan {
  String nama;
  String alamat;

  Pelanggan(this.nama, this.alamat);
}

class Item {
  int id;
  String nama;
  int harga;
  int stok;

  Item(this.id, this.nama, this.harga, this.stok);
}

class TransaksiPenjualan {
  Pelanggan pelanggan;
  Item item;
  int barang;

  TransaksiPenjualan(this.pelanggan, this.item, this.barang);
}

class ManajemenInventaris {
  List<Item?> daftarItem;
  int jumlahItem;

  ManajemenInventaris(int kapasitas)
      : daftarItem = List<Item?>.filled(kapasitas, null),
        jumlahItem = 0;

  void tambahItem(Item item) {
    if (jumlahItem < daftarItem.length) {
      if (!cekId(item.id)) {
        daftarItem[jumlahItem] = item;
        jumlahItem++;
      } else {
        print('ID Item sudah ada, masukkan ID yang berbeda.');
      }
    } else {
      print('Kapasitas inventaris penuh!');
    }
  }

  bool cekId(int id) {
    for (int i = 0; i < jumlahItem; i++) {
      if (daftarItem[i]!.id == id) {
        return true;
      }
    }
    return false;
  }

  void hapusItem(int id) {
    for (int i = 0; i < jumlahItem; i++) {
      if (daftarItem[i]!.id == id) {
        daftarItem[i] = daftarItem[jumlahItem - 1];
        daftarItem[jumlahItem - 1] = null;
        jumlahItem--;
        break;
      }
    }
  }

  void perbaruiStok(int id, int stokBaru) {
    for (int i = 0; i < jumlahItem; i++) {
      if (daftarItem[i]!.id == id) {
        daftarItem[i]!.stok = stokBaru;
        break;
      }
    }
  }

  void tampilkanPeyimpanan() {
    print('Inventaris:');
    for (int i = 0; i < jumlahItem; i++) {
      print('ID: ${daftarItem[i]!.id}, Nama: ${daftarItem[i]!.nama}, Harga: ${daftarItem[i]!.harga}, Stok: ${daftarItem[i]!.stok}');
    }
  }

  Item? cariItemById(int id) {
    for (int i = 0; i < jumlahItem; i++) {
      if (daftarItem[i]!.id == id) {
        return daftarItem[i];
      }
    }
    return null;
  }

  void urutkanBarangById() {
    for (int i = 0; i < jumlahItem - 1; i++) {
      for (int j = 0; j < jumlahItem - i - 1; j++) {
        if (daftarItem[j]!.id > daftarItem[j + 1]!.id) {
          var temp = daftarItem[j];
          daftarItem[j] = daftarItem[j + 1];
          daftarItem[j + 1] = temp;
        }
      }
    }
  }
}

class PencatatanPenjualan {
  List<TransaksiPenjualan?> daftarTransaksi;
  int jumlahTransaksi;

  PencatatanPenjualan(int kapasitas)
      : daftarTransaksi = List<TransaksiPenjualan?>.filled(kapasitas, null),
        jumlahTransaksi = 0;

  void catatTransaksi(TransaksiPenjualan transaksi) {
    if (jumlahTransaksi < daftarTransaksi.length) {
      daftarTransaksi[jumlahTransaksi] = transaksi;
      jumlahTransaksi++;
    } else {
      print('Kapasitas daftar transaksi penuh!');
    }
  }

  void tampilkanTransaksi() {
    print('Daftar Transaksi:');
    for (int i = 0; i < jumlahTransaksi; i++) {
      print('Pelanggan: ${daftarTransaksi[i]!.pelanggan.nama}, Item: ${daftarTransaksi[i]!.item.nama}, Jumlah beli : ${daftarTransaksi[i]!.barang}');
    }
  }

  List<TransaksiPenjualan?> cariTransaksiByNama(String nama) {
    List<TransaksiPenjualan?> hasilCari = [];
    for (int i = 0; i < jumlahTransaksi; i++) {
      if (daftarTransaksi[i]!.item.nama == nama) {
        hasilCari.add(daftarTransaksi[i]);
      }
    }
    return hasilCari;
  }
}

void main() {
  var inventaris = ManajemenInventaris(10);
  var pencatatanPenjualan = PencatatanPenjualan(10);

  while (true) {
    print('Menu:');
    print('1. Tambah Item ke Inventaris');
    print('2. Hapus Item dari Inventaris');
    print('3. Perbarui Stok Item');
    print('4. Tampilkan Inventaris');
    print('5. Catat Transaksi Penjualan');
    print('6. Tampilkan Transaksi');
    print('7. Cari Item berdasarkan ID');
    print('8. Urutkan Item berdasarkan ID');
    print('9. Cari Transaksi berdasarkan Nama Item');
    print('10. Keluar');

    stdout.write('Pilih opsi: ');
    int pilihan = int.parse(stdin.readLineSync()!);

    switch (pilihan) {
      case 1:
        stdout.write('Masukkan ID Item: ');
        int id = int.parse(stdin.readLineSync()!);
        stdout.write('Masukkan Nama Item: ');
        String nama = stdin.readLineSync()!;
        stdout.write('Masukkan Harga Item: ');
        int harga = int.parse(stdin.readLineSync()!);
        stdout.write('Masukkan Stok Item: ');
        int stok = int.parse(stdin.readLineSync()!);
        inventaris.tambahItem(Item(id, nama, harga, stok));
        break;
      case 2:
        stdout.write('Masukkan ID Item yang akan dihapus: ');
        int idHapus = int.parse(stdin.readLineSync()!);
        inventaris.hapusItem(idHapus);
        break;
      case 3:
        stdout.write('Masukkan ID Item yang akan diperbarui stoknya: ');
        int idStok = int.parse(stdin.readLineSync()!);
        stdout.write('Masukkan Stok Baru: ');
        int stokBaru = int.parse(stdin.readLineSync()!);
        inventaris.perbaruiStok(idStok, stokBaru);
        break;
      case 4:
        inventaris.tampilkanPeyimpanan();
        break;
      case 5:
        stdout.write('Masukkan Nama Pelanggan: ');
        String namaPelanggan = stdin.readLineSync()!;
        stdout.write('Masukkan Alamat Pelanggan: ');
        String alamatPelanggan = stdin.readLineSync()!;
        stdout.write('Masukkan ID Item yang dijual: ');
        int idItem = int.parse(stdin.readLineSync()!);
        stdout.write('Masukkan jumlah barang yang di beli : ');
        int jumlah = int.parse(stdin.readLineSync()!);
        Item? itemTerjual = inventaris.cariItemById(idItem);
        if (itemTerjual != null && itemTerjual.stok >= jumlah) {
          itemTerjual.stok -= jumlah; // Mengurangi stok item
          pencatatanPenjualan.catatTransaksi(TransaksiPenjualan(Pelanggan(namaPelanggan, alamatPelanggan), itemTerjual, jumlah));
        } else if (itemTerjual != null && itemTerjual.stok < jumlah) {
          print('Stok item tidak mencukupi untuk pesanan.');
        } else {
          print('Item dengan ID tersebut tidak ditemukan.');
        }
        break;
      case 6:
        pencatatanPenjualan.tampilkanTransaksi();
        break;
      case 7:
        stdout.write('Masukkan ID Item yang dicari: ');
        int idCari = int.parse(stdin.readLineSync()!);
        var itemDitemukan = inventaris.cariItemById(idCari);
        if (itemDitemukan != null) {
          print('ID: ${itemDitemukan.id}, Nama: ${itemDitemukan.nama}, Harga: ${itemDitemukan.harga}, Stok: ${itemDitemukan.stok}');
        } else {
          print('Item dengan ID tersebut tidak ditemukan.');
        }
        break;
      case 8:
        inventaris.urutkanBarangById();
        inventaris.tampilkanPeyimpanan();
        break;
      case 9:
        stdout.write('Masukkan Nama Item untuk mencari transaksi: ');
        String namaItem = stdin.readLineSync()!;
        var hasilCari = pencatatanPenjualan.cariTransaksiByNama(namaItem);
        print('Hasil Pencarian Transaksi:');
        for (var transaksi in hasilCari) {
          print('Pelanggan: ${transaksi!.pelanggan.nama}, Item: ${transaksi.item.nama}, Jumlah barang yang dibeli : ${transaksi.barang}');
        }
        break;
      case 10:
        return;
      default:
        print('Pilihan tidak valid.');
    }
  }
}
