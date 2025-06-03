# Kutu Kapmaca - Flutter Mobil Oyunu

Kutu Kapmaca, iki oyuncu arasında oynanan, noktaları birleştirerek kutular oluşturma oyunudur. Amaç, tahtadaki en fazla kutuyu yapan oyuncu olmaktır.

## 🚀 Projenin Amacı

Kutu Kapmaca oyunu projesi, kullanıcıların hem zihinsel becerilerini geliştirmelerine hem de eğlenceli ve rekabetçi bir oyun deneyimi yaşamalarına olanak tanımak amacıyla tasarlanmıştır. Bu proje, stratejik düşünme, dikkat toplama, öngörüde bulunma ve hızlı karar verme gibi bilişsel yetenekleri desteklemeyi hedefler. Oyuncular, oyunun temel dinamikleri olan sıra tabanlı hamle sistemi, kutu kapatma mantığı ve puanlama yapısı sayesinde, her hamlelerinde düşünerek hareket etmeye yönlendirilir. Böylece oyun, yalnızca rastgele tıklamalardan ibaret olmaktan çıkar ve kullanıcıyı düşünmeye teşvik eden bir yapıya kavuşur.


## 🔧 Teknik Detaylar

* 🚀 Flutter
Uygulamanın ana geliştirme platformudur. Tüm kullanıcı arayüzü, oyun mekaniği ve navigasyon yapısı Flutter ile oluşturulmuştur. Platformlar arası (mobil ve web) uyumluluk göz önünde bulundurularak tasarlanmıştır.

* 🔐 Firebase Authentication
Kullanıcıların e-posta/şifre, Google ve GitHub gibi yöntemlerle giriş yapabilmesi için kimlik doğrulama işlemleri Firebase altyapısı kullanılarak gerçekleştirilmiştir. Giriş yapılan kullanıcıya özel skorlar tutulur.

* 🗄️ Supabase
Oyun skorlarının saklandığı bulut tabanlı veritabanıdır. Her kullanıcının skoru bireysel olarak saklanır. Supabase üzerinden CRUD işlemleri gerçekleştirilmiş, sıralı skor listeleri oluşturulmuştur.

* 🔗 Google Sign-In & GitHub Auth
Üçüncü parti giriş seçenekleri olarak Google ve GitHub kimlik doğrulama sistemleri entegre edilmiştir. Firebase Authentication sistemi üzerinden kontrol edilir.

* 🔄 State Management
Uygulama durumu, Flutter’ın `setState()` yapısıyla yönetilmiştir. Oyun sırası, kutuların sahipliği ve skor durumu dinamik olarak güncellenmektedir. Ekstra state management kütüphaneleri kullanılmamıştır.

* 📱 Responsive Tasarım
Flutter’ın layout yapıları (Column, Row, Expanded, ListView) kullanılarak hem küçük ekranlı telefonlarda hem de büyük ekranlı cihazlarda düzgün görüntülenecek esnek bir yapı inşa edilmiştir.

* 🗓️ Veri Formatlama
`intl` paketi kullanılarak skorların oluşturulma tarihleri kullanıcı dostu bir formatta (`03.06.2025 14:30`) gösterilmiştir.

---
## 🧪 Kullanılan Teknolojiler

| Teknoloji | Açıklama |
|-----------|----------|
| **Flutter** | Uygulamanın temel geliştirme platformudur. Hem mobil hem web desteği ile kullanılabilir yapıdadır. |
| **Dart** | Flutter uygulamalarının geliştirilmesinde kullanılan programlama dilidir. |
| **Firebase Authentication** | Kullanıcıların e-posta/şifre, Google ve GitHub hesaplarıyla güvenli giriş yapmasını sağlar. |
| **Supabase** | Skorların saklandığı, PostgreSQL tabanlı bulut veritabanı çözümüdür. RESTful API üzerinden veri işlemleri yapılmıştır. |
| **Google Sign-In** | Firebase üzerinden Google hesapları ile oturum açmayı sağlar (özellikle web sürümünde `client_id` ile çalışır). |
| **GitHub Auth** | Firebase aracılığıyla GitHub hesapları ile kullanıcı doğrulaması yapılmasını sağlar. |
| **intl** | Tarih ve saat formatlarını kullanıcıya uygun biçimde göstermek için kullanılmıştır. |
| **Material Icons** | Oyun ekranında ikonlarla kullanıcıya görsel geri bildirim sağlamak için kullanılmıştır. |

---



## 📃 Projedeki Sayfalar ve Görevleri

### 🔐 LoginPage (login_page.dart)
* Kullanıcıların e-posta ve şifre ile giriş yaptığı ekrandır.
* Firebase Authentication ile kimlik doğrulama yapılır.
* Google ve GitHub ile sosyal giriş desteklenir.
* Başarılı girişten sonra kullanıcı ana sayfaya yönlendirilir.
* Giriş sonrası `Navigator.pushReplacement` ile `HomePage`'e geçiş yapılır.
* Hatalar kullanıcıya Türkçe açıklamalarla gösterilir.

### 🧾 RegisterPage (register_page.dart)
* Yeni kullanıcıların kayıt olmasını sağlayan sayfadır.
* Firebase üzerinde e-posta ve şifre ile kullanıcı kaydı yapılır.
* Giriş ekranına geri dönme ve şifreyi görünür yapma seçenekleri vardır.
* `TextFormField` yapıları ile kullanıcıdan bilgi alınır ve doğrulama yapılır.

### 🏠 HomePage (home_page.dart)
* Uygulama içindeki merkezi ana ekrandır.
* "Yeni Oyun", "Son Skorlar", "Nasıl Oynanır" ve "Profil" sayfalarına yönlendirme yapılır.
* Üst bölümde kullanıcıya hoş geldin mesajı ve uygulama logosu yer alır.
* Firebase’den oturum açmış kullanıcı bilgisi alınarak gösterilir.

### 🎮 GamePage (game_page.dart)
* Oyunun oynandığı ana sayfadır.
* 5x5 noktalı ızgarada oyuncular sırayla çizgi çeker.
* Kutu kapanırsa ilgili oyuncuya puan yazılır.
* Oyun sonunda kazanan otomatik belirlenir ve üstte yazıyla bildirilir.
* Oyun skoru `"Mavi-Pembe"` formatında Supabase veritabanına kaydedilir.
* "Oyunu Sıfırla" butonu ile yeni oyuna başlanabilir.

### 📊 ScoreListPage (score_list_page.dart)
* Giriş yapan kullanıcıya ait tüm geçmiş skorları listeler.
* Supabase veritabanından `score_text` ve `created_at` bilgisi çekilir.
* Skorlar iki sütun halinde (Mavi Takım – Pembe Takım) olarak gösterilir.
* Skorların tarihi kullanıcı dostu biçimde (`dd.MM.yyyy HH:mm`) biçimlendirilir.

### ❓ HowToPlayPage (how_to_play_page.dart)
* Kutu Kapmaca oyununun kuralları ve oynanış mantığı anlatılır.
* Kullanıcıya sade bir dille bilgilendirme yapılır.
* Sayfa üzerinden oyunla ilgili bilgi edinilmesi amaçlanır.

### 🙋 ProfilePage (profile_page.dart)
* Giriş yapan kullanıcıya ait profil bilgilerini görüntüler.
* Firebase kullanıcı bilgileri çekilerek ekrana yansıtılır.
* Kullanıcı e-postası, UID ve çıkış yap butonu yer alır.
* "Çıkış Yap" butonuyla Firebase oturumu kapatılır ve login ekranına yönlendirme yapılır.

### ☰ AppDrawer (app_drawer.dart)
* Uygulama genelinde kullanılan navigasyon menüsüdür.
* Drawer yapısıyla sol menüden diğer sayfalara geçiş yapılmasını sağlar.
* Kullanıcı profili (logo) üstte gösterilir.
* Menüde: "Kare Kapmaca", "Son Oyunlar", "Nasıl Oynanır", "Profil", "Çıkış Yap" gibi bağlantılar bulunur.
* Firebase oturumu kapatıldığında `LoginPage`'e yönlendirme yapılır.

### 🧩 supabase_service.dart
* Supabase bağlantı işlemlerini yöneten yardımcı servistir.
* Supabase istemcisi (`SupabaseClient`) burada yapılandırılır.
* Projenin farklı yerlerinden Supabase veritabanına erişim bu dosya üzerinden sağlanır.

### 🏁 main.dart
* Uygulamanın başlangıç noktasıdır.
* Firebase ve Supabase başlatmaları burada yapılır (`initializeApp`, `Supabase.initialize`).
* Uygulama yönlendirme rotaları (`/login`, `/home`, `/game` vs.) burada tanımlanır.
* İlk açılışta `LoginPage` veya `HomePage`'e yönlendirme yapılır.


### 🧱 BasePage (base_page.dart)

* Uygulamadaki sayfalara ortak yapı sağlayan temel bir bileşendir.
* Genellikle tüm sayfalarda tekrar eden `AppBar`, `Drawer` veya `SafeArea` gibi widget’ları tek noktada yönetmek için kullanılır.
* Bu yapı sayesinde her yeni sayfa, `BasePage` üzerinden miras alınarak tutarlı görünüm elde eder.
* Kod tekrarı azaltılır, genel düzen korunur.
* `child` parametresiyle her sayfaya özgü içerik dinamik olarak yerleştirilebilir.

### 🔧 FirebaseOptions (firebase_options.dart)

* Firebase bağlantı ayarlarının otomatik olarak oluşturulduğu dosyadır.
* `flutterfire configure` komutu ile oluşturulmuştur.
* Firebase projesine ait `apiKey`, `projectId`, `messagingSenderId`, `appId` gibi hassas bilgileri içerir.
* Uygulamanın Firebase’e bağlanabilmesi için `main.dart` dosyasında `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` satırıyla çağrılır.
* Web, Android ve iOS platformları için ayrı ayrı yapılandırmalar içerir.



---


## ☁️ Firestore ve Supabase Örnek Veri Yapıları

### Firestore: Kullanıcı Profili

```json
{
  "uid": "aO0RDciUmCfbaGJpPhlVF92T0X22",
  "email": "hgencoglu@gmail.com",
  "birthdate": "01.01.1990",
  "birthplace": "Malatya",
  "city": "İstanbul",
  "createdAt": "2025-04-07T10:07:34Z"
  "password": "123456"
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
