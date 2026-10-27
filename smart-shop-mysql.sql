SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS ai_chat_log, shipping_tracking, order_items, orders, carts, products, categories, users;

CREATE TABLE users (
  id_user BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL DEFAULT 'Customer',
  no_telp VARCHAR(255) NULL,
  alamat TEXT NULL,
  UNIQUE KEY users_email_unique (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE categories (
  id_kategori BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nama_kategori VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL,
  UNIQUE KEY categories_slug_unique (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE products (
  id_produk BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_kategori BIGINT UNSIGNED NOT NULL,
  nama_produk VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL,
  harga INT UNSIGNED NOT NULL,
  diskon TINYINT UNSIGNED NOT NULL DEFAULT 0,
  stok INT UNSIGNED NOT NULL DEFAULT 0,
  deskripsi TEXT NOT NULL,
  gambar VARCHAR(255) NULL,
  flag_status VARCHAR(255) NULL,
  terjual INT UNSIGNED NOT NULL DEFAULT 0,
  ilustrasi VARCHAR(255) NOT NULL DEFAULT 'tee',
  warna JSON NOT NULL,
  latar JSON NOT NULL,
  UNIQUE KEY products_slug_unique (slug),
  CONSTRAINT products_kat_fk FOREIGN KEY (id_kategori) REFERENCES categories (id_kategori) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE carts (
  id_cart BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_user BIGINT UNSIGNED NOT NULL,
  id_produk BIGINT UNSIGNED NOT NULL,
  jumlah INT NOT NULL DEFAULT 1,
  CONSTRAINT carts_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON DELETE CASCADE,
  CONSTRAINT carts_produk_fk FOREIGN KEY (id_produk) REFERENCES products (id_produk) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE orders (
  id_order BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_user BIGINT UNSIGNED NOT NULL,
  kode VARCHAR(255) NOT NULL,
  tanggal_order DATE NOT NULL,
  total_harga INT NOT NULL,
  metode_pembayaran VARCHAR(255) NOT NULL,
  bukti_bayar VARCHAR(255) NULL,
  status_pesanan VARCHAR(255) NOT NULL,
  kurir VARCHAR(255) NOT NULL,
  ongkir INT NOT NULL DEFAULT 0,
  nama_penerima VARCHAR(255) NOT NULL,
  telepon VARCHAR(255) NOT NULL,
  alamat_pengiriman TEXT NOT NULL,
  UNIQUE KEY orders_kode_unique (kode),
  CONSTRAINT orders_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE order_items (
  id_item BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_order BIGINT UNSIGNED NOT NULL,
  id_produk BIGINT UNSIGNED NULL,
  nama_produk VARCHAR(255) NOT NULL,
  jumlah_beli INT NOT NULL,
  harga_satuan INT NOT NULL,
  CONSTRAINT items_order_fk FOREIGN KEY (id_order) REFERENCES orders (id_order) ON DELETE CASCADE,
  CONSTRAINT items_produk_fk FOREIGN KEY (id_produk) REFERENCES products (id_produk) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE shipping_tracking (
  id_tracking BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_order BIGINT UNSIGNED NOT NULL,
  status_terkini VARCHAR(255) NOT NULL,
  catatan_kurir TEXT NULL,
  waktu_update DATETIME NOT NULL,
  CONSTRAINT track_order_fk FOREIGN KEY (id_order) REFERENCES orders (id_order) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE ai_chat_log (
  id_log BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_user BIGINT UNSIGNED NULL,
  pertanyaan TEXT NOT NULL,
  jawaban TEXT NOT NULL,
  waktu DATETIME NOT NULL,
  CONSTRAINT chat_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO users (id_user,nama,email,password,role,no_telp,alamat) VALUES (1,'Admin Smart Shop','admin@smartshop.test','$2y$12$QeK1MEjNU1WAWJSIfI3Jbu8x9KMFIxa8rCb1.P51mRVxcwnAhnt1K','Admin','081200000001','Jl. Gatot Subroto No. 10, Medan');
INSERT INTO users (id_user,nama,email,password,role,no_telp,alamat) VALUES (2,'Sari Dewi','sari@example.com','$2y$12$WInftKXNCC/KOf/DUe8Zge4FOpQiziY3T4BWdekXgzhBp0dUo0hcS','Customer','081234567801','Jl. Sisingamangaraja No. 25, Medan');
INSERT INTO users (id_user,nama,email,password,role,no_telp,alamat) VALUES (3,'Budi Santoso','budi@example.com','$2y$12$KEl.uYWgHTPzQ2PMRCYPzurZTs1aXWpK1dtzOYe6QgXT6Lvce5vzi','Customer','081234567802','Jl. Setia Budi No. 8, Medan');
INSERT INTO users (id_user,nama,email,password,role,no_telp,alamat) VALUES (4,'Rina Marlina','rina@example.com','$2y$12$Qmlcl9BlVEuh9AX8/xDAW.T90H3iyOk4EgrLWBUkNxjBC6nysc/cy','Customer','081234567803','Jl. Merak Jingga No. 3, Medan');
INSERT INTO users (id_user,nama,email,password,role,no_telp,alamat) VALUES (5,'nina','nisa@gmail.com','$2y$12$WtdGWSh9n/.P4Iz4RPrFNuwqagrBE3ll4lophOyHTPP8jl2fPkHiG','Customer','085425456111',NULL);
INSERT INTO users (id_user,nama,email,password,role,no_telp,alamat) VALUES (6,'nina','nina@gmail.com','$2y$12$VdRAgWO9X9M5J2U2Y3.rMOj9i0/XrRwJI79NDt7r9MD7KgVk//wPa','Customer','082363550001','rambayan,sigli');
INSERT INTO categories (id_kategori,nama_kategori,slug) VALUES (1,'Fashion','fashion');
INSERT INTO categories (id_kategori,nama_kategori,slug) VALUES (2,'Kosmetik','kosmetik');
INSERT INTO categories (id_kategori,nama_kategori,slug) VALUES (3,'Sepatu & Sandal','sepatu');
INSERT INTO categories (id_kategori,nama_kategori,slug) VALUES (4,'Tas','tas');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (1,1,'Kemeja Linen Putih','kemeja-linen-putih',189000,0,25,'Kemeja linen adem dan ringan, cocok untuk kerja maupun santai. Tersedia ukuran S sampai XL.',NULL,NULL,64,'shirt','["#ffffff","#cbd5e1"]','["#e0f2fe","#bae6fd"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (2,1,'Kaos Oversize Basic','kaos-oversize-basic',99000,15,80,'Kaos katun combed 24s yang lembut, potongan oversize yang nyaman dipadukan dengan apa saja.',NULL,'Flash Sale',210,'tee','["#fdba74","#ea580c"]','["#fff7ed","#fed7aa"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (3,1,'Dress Midi Floral','dress-midi-floral',259000,0,18,'Dress midi motif bunga dengan bahan jatuh dan tidak mudah kusut. Pas untuk acara santai.',NULL,'New Arrival',12,'dress','["#f9a8d4","#db2777"]','["#fdf2f8","#fbcfe8"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (4,1,'Celana Kulot Crinkle','celana-kulot-crinkle',149000,30,40,'Celana kulot crinkle pinggang karet, tidak perlu disetrika dan nyaman dipakai seharian.',NULL,'Flash Sale',143,'pants','["#86efac","#16a34a"]','["#ecfdf5","#a7f3d0"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (5,2,'Lip Tint Matte Rose','lip-tint-matte-rose',69000,0,120,'Lip tint matte warna rose yang tahan lama, ringan di bibir, tidak lengket.',NULL,'New Arrival',38,'lipstick','["#fb7185","#be123c"]','["#fff1f2","#fecdd3"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (6,2,'Serum Vitamin C 10%','serum-vitamin-c-10',125000,20,55,'Serum vitamin C 10% membantu mencerahkan kulit dan menyamarkan noda hitam. Aman untuk kulit sensitif.',NULL,'Flash Sale',187,'serum','["#fcd34d","#ea580c"]','["#fffbeb","#fde68a"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (7,2,'Sunscreen SPF 50 PA++++','sunscreen-spf-50-pa',89000,0,90,'Sunscreen gel ringan tanpa white cast, perlindungan maksimal dari sinar UVA dan UVB.',NULL,NULL,256,'tube','["#e0f2fe","#38bdf8"]','["#f0f9ff","#bae6fd"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (8,2,'Cushion Foundation Natural','cushion-foundation-natural',149000,0,35,'Cushion dengan coverage natural dan hasil akhir seperti kulit sendiri. Sudah termasuk refill.',NULL,NULL,97,'compact','["#f9a8d4","#be185d"]','["#fdf4ff","#f5d0fe"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (9,3,'Sneakers Putih Classic','sneakers-putih-classic',329000,15,30,'Sneakers putih model klasik dengan sol empuk. Mudah dipadukan dengan outfit apa pun.',NULL,'Flash Sale',175,'sneaker','["#ffffff","#cbd5e1"]','["#ede9fe","#ddd6fe"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (10,3,'Sandal Slide Nyaman','sandal-slide-nyaman',99000,0,70,'Sandal slide dengan sol anti slip dan bantalan empuk, nyaman dipakai di rumah atau jalan santai.',NULL,NULL,132,'slide','["#5eead4","#0d9488"]','["#f0fdfa","#99f6e4"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (11,3,'Sepatu Lari Ringan','sepatu-lari-ringan',459000,0,22,'Sepatu lari super ringan dengan midsole responsif dan upper yang breathable.',NULL,'New Arrival',29,'runner','["#38bdf8","#1d4ed8"]','["#eff6ff","#bfdbfe"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (12,3,'Flat Shoes Kulit','flat-shoes-kulit',219000,0,28,'Flat shoes dari kulit sintetis premium, tampilan rapi untuk ke kantor.',NULL,NULL,58,'flat','["#f5d0a9","#b45309"]','["#fef3c7","#fcd9a8"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (13,4,'Totebag Kanvas','totebag-kanvas',79000,30,99,'Totebag kanvas tebal dengan kantong dalam berresleting. Muat laptop 14 inci.',NULL,'Flash Sale',302,'tote','["#fef3c7","#d6b370"]','["#ecfccb","#bef264"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (14,4,'Ransel Urban Anti Air','ransel-urban-anti-air',289000,0,26,'Ransel bahan anti air dengan kompartemen laptop dan port USB untuk mengisi daya.',NULL,'New Arrival',41,'backpack','["#818cf8","#312e81"]','["#e0e7ff","#c7d2fe"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (15,4,'Sling Bag Mini','sling-bag-mini',159000,0,45,'Sling bag mini praktis untuk membawa ponsel, dompet, dan kunci saat bepergian.',NULL,NULL,119,'sling','["#c4b5fd","#7c3aed"]','["#f5f3ff","#ddd6fe"]');
INSERT INTO products (id_produk,id_kategori,nama_produk,slug,harga,diskon,stok,deskripsi,gambar,flag_status,terjual,ilustrasi,warna,latar) VALUES (16,4,'Tas Selempang Elegan','tas-selempang-elegan',249000,0,20,'Tas selempang kulit sintetis dengan tampilan elegan dan tali yang bisa diatur panjangnya.',NULL,NULL,74,'shoulder','["#b45309","#451a03"]','["#fff7ed","#fed7aa"]');
INSERT INTO carts (id_cart,id_user,id_produk,jumlah) VALUES (1,2,2,1);
INSERT INTO orders (id_order,id_user,kode,tanggal_order,total_harga,metode_pembayaran,bukti_bayar,status_pesanan,kurir,ongkir,nama_penerima,telepon,alamat_pengiriman) VALUES (1,2,'SS-0001','2026-10-20',453650,'Transfer','bukti-ss-0001.jpg','Selesai','JNE Reguler',15000,'Sari Dewi','081234567801','Jl. Sisingamangaraja No. 25, Medan');
INSERT INTO orders (id_order,id_user,kode,tanggal_order,total_harga,metode_pembayaran,bukti_bayar,status_pesanan,kurir,ongkir,nama_penerima,telepon,alamat_pengiriman) VALUES (2,3,'SS-0002','2026-10-23',255300,'COD',NULL,'Dikirim','J&T Express',18000,'Budi Santoso','081234567802','Jl. Setia Budi No. 8, Medan');
INSERT INTO orders (id_order,id_user,kode,tanggal_order,total_harga,metode_pembayaran,bukti_bayar,status_pesanan,kurir,ongkir,nama_penerima,telepon,alamat_pengiriman) VALUES (3,4,'SS-0003','2026-10-24',471000,'COD',NULL,'Diproses','SiCepat Halu',12000,'Rina Marlina','081234567803','Jl. Merak Jingga No. 3, Medan');
INSERT INTO orders (id_order,id_user,kode,tanggal_order,total_harga,metode_pembayaran,bukti_bayar,status_pesanan,kurir,ongkir,nama_penerima,telepon,alamat_pengiriman) VALUES (4,2,'SS-0004','2026-10-25',304000,'Transfer','bukti-ss-0004.jpg','Menunggu Verifikasi','JNE Reguler',15000,'Sari Dewi','081234567801','Jl. Sisingamangaraja No. 25, Medan');
INSERT INTO orders (id_order,id_user,kode,tanggal_order,total_harga,metode_pembayaran,bukti_bayar,status_pesanan,kurir,ongkir,nama_penerima,telepon,alamat_pengiriman) VALUES (5,3,'SS-0005','2026-10-25',128600,'Transfer','bukti-ss-0005.jpg','Menunggu Verifikasi','J&T Express',18000,'Budi Santoso','081234567802','Jl. Setia Budi No. 8, Medan');
INSERT INTO orders (id_order,id_user,kode,tanggal_order,total_harga,metode_pembayaran,bukti_bayar,status_pesanan,kurir,ongkir,nama_penerima,telepon,alamat_pengiriman) VALUES (6,6,'SS-0006','2026-10-27',70300,'COD',NULL,'Dikirim','JNE Reguler',15000,'nina','082363550001','rambayan,sigli');
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (11,1,9,'Sneakers Putih Classic',1,279650);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (12,1,15,'Sling Bag Mini',1,159000);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (21,2,2,'Kaos Oversize Basic',2,84150);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (22,2,5,'Lip Tint Matte Rose',1,69000);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (31,3,11,'Sepatu Lari Ringan',1,459000);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (41,4,6,'Serum Vitamin C 10%',1,100000);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (42,4,1,'Kemeja Linen Putih',1,189000);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (51,5,13,'Totebag Kanvas',2,55300);
INSERT INTO order_items (id_item,id_order,id_produk,nama_produk,jumlah_beli,harga_satuan) VALUES (52,6,13,'Totebag Kanvas',1,55300);
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (1,1,'Menunggu Verifikasi','Pembayaran diterima, menunggu verifikasi admin.','2026-10-20 09:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (2,1,'Diproses','Pesanan sedang dikemas oleh penjual.','2026-10-20 14:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (3,1,'Dikirim','Paket diserahkan ke kurir dan sedang dalam perjalanan.','2026-10-20 19:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (4,1,'Selesai','Paket telah diterima oleh yang bersangkutan.','2026-10-21 00:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (5,2,'Diproses','Pesanan sedang dikemas oleh penjual.','2026-10-23 09:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (6,2,'Dikirim','Paket sedang dibawa kurir menuju alamat Anda. Siapkan uang pas.','2026-10-23 14:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (7,3,'Diproses','Pesanan sedang dikemas oleh penjual.','2026-10-24 09:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (8,4,'Menunggu Verifikasi','Menunggu admin memeriksa bukti pembayaran.','2026-10-25 09:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (9,5,'Menunggu Verifikasi','Menunggu admin memeriksa bukti pembayaran.','2026-10-25 09:00:00');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (10,6,'Diproses','Pesanan COD diterima dan sedang dikemas.','2026-10-27 13:54:13');
INSERT INTO shipping_tracking (id_tracking,id_order,status_terkini,catatan_kurir,waktu_update) VALUES (11,6,'Dikirim','Paket diserahkan ke kurir dan sedang dalam perjalanan.','2026-10-27 13:57:48');
INSERT INTO ai_chat_log (id_log,id_user,pertanyaan,jawaban,waktu) VALUES (1,2,'Rekomendasi outfit santai?','Coba kaos oversize + celana kulot.','2026-10-25 10:12:00');

SET FOREIGN_KEY_CHECKS=1;
