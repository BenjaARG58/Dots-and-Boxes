# Kutu Kapmaca - Flutter Oyunu

Kutu Kapmaca, iki oyunculu klasik "Dots and Boxes" (Kutu Kapmaca) oyununun Flutter ile geliştirilmiş mobil/web uygulamasıdır. Oyuncular sırayla çizgiler çizer, kutuyu tamamlayan puan kazanır. Oyun sonunda kazanan renk ve skor ekranı otomatik olarak gösterilir.

## 🚀 Projenin Amacı

Bu projenin temel amacı:

* Firebase Authentication ile kullanıcı kimliği doğrulaması yapmak
* Supabase kullanarak oyun skorlarını kaydetmek
* Flutter ile sade ve kullanıcı dostu bir oyun arayüzü sunmak

## 🔧 Kullanılan Teknolojiler

* **Flutter** – Arayüz ve oyun mantığı
* **Firebase Authentication** – Giriş/Kayıt sistemi
* **Firestore** – Kullanıcı bilgileri ve profil verisi
* **Supabase** – Oyun skoru kaydı ("score": "12-8" formatında)
* **SharedPreferences** – Yerel oturum bilgisi saklama
* **animated\_text\_kit** – Giriş ekranında yazı animasyonu
* **Provider** – Tema ve durum yönetimi

## 📃 Projedeki Sayfalar ve Görevleri

### 🔐 LoginPage

* Kullanıcı giriş ekranıdır. Oyunun başlangıç noktadır.
* Logo görseli ve animasyonlu "Kutu Kapmaca" yazısı içerir.
* "Yeni Oyun" ve "Nasıl Oynanır" sayfalarına yönlendirme butonları bulunur.

### 🎮 GamePage

* Oyunun oynandığı ana sayfadır.
* Oyuncular sırayla çizgi çeker, kutuları tamamlarsa puan kazanır.
* Kazanan oyuncu otomatik olarak belirlenir ve skor görseli ekranın üstünde yazı olarak gösterilir.
* Skor bilgisi Supabase'e "12-8" formatında kaydedilir.

### ❓ HowToPlayPage

* Oyunun kuralları, mantığı ve kazanma koşulları açıklanır.

### ☰ AppDrawer

* Uygulamadaki tüm sayfalara erişim sağlayan yan menüdür.
* Logo, sayfa bağlantıları ve çıkış butonu içerir.

## 🔖 Drawer Menüsü ve Logo

* Kullanılan Logo URL'si: `https://i.imgur.com/1hwwXl0.png`
* Logo, `FutureBuilder` ile yüklenir ve `Image.network` ile görüntülenir.

## 🔐 Login Bilgileri

* Firebase Authentication kullanılmıştır.
* Kullanıcı UID, ad, soyad, eposta `SharedPreferences` ile saklanır.
* Sosyal giriş (Google ve GitHub) desteklenmektedir.

## ☁️ Firestore ve Supabase Örnek Veri Yapıları

### Firestore: Kullanıcı Profili

```json
{
  "uid": "7wdOfGpgBmtWF4N1Fmmuow3FwtBx1",
  "email": "hgencoglu@gmail.com",
  "birthdate": "01.01.1990",
  "birthplace": "Malatya",
  "city": "İstanbul",
  "createdAt": "2025-04-07T10:07:34Z"
}
```

### Supabase: Oyun Skoru

```json
{
  "uid": "7wdOfGpgBmtWF4N1Fmmuow3FwtBx1",
  "score": "12-8",
  "timestamp": "2025-04-07T11:08:47Z"
}
```

## 🌜 Tema Özelliği

* Uygulama, `ThemeProvider` ile karanlık ve aydınlık tema desteğine sahiptir.
* Tüm sayfalarda tutarlı tema uygulanmıştır.

## 🚪 Oyunun Bitimi

* Kazanan oyuncu otomatik belirlenir.
* Tüm noktalar kazananın rengine boyanır.
* Skor kaydı otomatik olarak Supabase'e gönderilir.

## 📄 Projeyi Çalıştırmak İçin

```bash
flutter pub get
flutter run
```

### Web için:

```bash
flutter run -d chrome
```

## 🧵 Geliştirici

**Berşan Kurtcephe** – Projenin tüm kodlaması, tasarımı ve mantığı bireysel olarak geliştirilmiştir.
