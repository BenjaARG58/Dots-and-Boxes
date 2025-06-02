# Kutu Kapmaca - Flutter Oyunu

Bu proje, iki oyunculu klasik "Dots and Boxes" (Kutu Kapmaca) oyununun Flutter ile geliştirilmiş mobil/web uygulamasıdır. Oyuncular sırayla çizgiler çizer, kutuyu tamamlayan puan kazanır. Oyun sonunda kazanan renk ve skor ekranı otomatik olarak gösterilir.

## Projedeki Sayfalar ve Görevleri

- LoginPage: Kullanıcı giriş ekranıdır. Oyunun başlangıç noktasıdır. Logo ve animasyonlu "Kutu Kapmaca" yazısı içerir. İki butonla "Yeni Oyun" ve "Nasıl Oynanır" sayfalarına yönlendirme yapılır.
- GamePage: Oyunun oynandığı ana sayfadır. Oyuncular sıralı olarak çizgi çizer, kutuları tamamlarsa puan alır. Kazanan otomatik olarak belirlenir ve ekranın üst kısmında yazılır.
- HowToPlayPage: Oyunun nasıl oynandığını açıklayan bilgilendirme ekranıdır. Oyunun mantığı, kazanma koşulları ve çizgi kuralları anlatılır.
- AppDrawer: Uygulamanın tüm sayfalarına erişim sağlayan yan menüdür. İçerisinde logo, navigasyon linkleri ve telif bilgisi bulunur.

## Drawer Menüsündeki Logo

- Kullanılan Logo URL'si:
  https://i.imgur.com/1hwwXl0.png
- Görsel FutureBuilder ile yüklenir ve Image.network ile görüntülenir.

## Login Bilgileri

- Projede login kimlik doğrulaması yapılmamaktadır.
- Kullanıcı bilgisi alınmaz veya saklanmaz.
- Giriş ekranı yalnızca yönlendirme amaçlıdır.
- Veri tabanı veya shared_preferences kullanılmamıştır.

## Grup Üyelerinin Katkısı

- Berşan Kurtcephe: Projenin tüm kodlaması, tasarımı, sayfa yapıları, animasyonlar ve mantık geliştirmesi bireysel olarak gerçekleştirilmiştir.

## Diğer Anlatmak İstediklerimiz

- Kazanan otomatik belirlenir ve ekran üstünde yazı olarak gösterilir.
- Oyun bitince tüm noktalar kazananın rengine döner.
- Başlıkta animated_text_kit ile animasyon uygulanmıştır.
- Hem mobil hem web uyumluluğu vardır.

## Projeyi Başlatmak için

flutter pub get  
flutter run

Web için:

flutter run -d chrome
