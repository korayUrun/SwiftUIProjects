1. Protocols (Sözleşmeler / Standartlar)

Nedir? En üst katmandır. Sistemin "ne yapacağını" söyler ama "nasıl yapacağını" asla bilmez.

Hiyerarşideki Yeri: En soyut (Abstract) katman.

Görevi: Bir arayüz (interface) sunmak. Örneğin; "Para çekme fonksiyonu olmalı."

Bağlantı: Concrete Class'lar bu protokolü imzalar (implement eder). ViewModel'ler sadece bu protokollere güvenir.


2. Concrete Classes (Gerçek İşçiler / Uygulayıcılar)

Nedir? Protokolde söz verilen işleri gerçekten yapan sınıflardır.

Hiyerarşideki Yeri: En alt/operasyonel katman.

Görevi: Mantığı (logic) işletmek. API'ye gitmek, veritabanına yazmak.

Bağlantı: Protokole "uyarlar" (Conform). AppContainer tarafından oluşturulup saklanırlar.


3. AppContainer (Kasa / Depo)

Nedir? Tüm Concrete Class'ların yaratıldığı ve canlı tutulduğu yerdir.

Hiyerarşideki Yeri: Yönetim merkezi.

Görevi: Bağımlılıkları tek bir yerden yönetmek. Uygulama boyunca hangi servislerin yaşayacağına karar verir.

Bağlantı: İçinde somut nesneleri (Concrete Classes) barındırır ama dış dünyaya onları birer Dependencies (Protokol) maskesiyle sunar.


4. Dependencies (Filtreler / Erişim İzinleri)

Nedir? AppContainer ile ViewModel arasındaki güvenlik duvarıdır.

Hiyerarşideki Yeri: Ara katman (Interface Segregation).

Görevi: AppContainer'ın içindeki 50 tane servisin hepsini değil, sadece ilgili ekrana lazım olan 2-3 tanesini göstermek.

Bağlantı: AppContainer bu protokolleri imzalar. ViewModel ise sadece bu protokolü "tip" olarak bekler.




Aralarındaki Bağlantı Hiyerarşisi (Görsel Akış)

Bu yapıyı bir senaryo ile birbirine bağlayalım:


Tanımlama: Önce Protocol yazılır. ("Ödeme yapılabilmeli")

Gerçekleştirme: Bir Concrete Class bu protokolü doldurur. ("Mastercard ile ödeme kodu")

Kaydetme: AppContainer bu sınıfı hafızasına alır. (let payment = MastercardService())

Kısıtlama: Bir Dependencies protokolü oluşturulur. ("Bu ekran sadece ödeme servisini görebilir")

Enjekte Etme: ViewModel sadece o kısıtlı protokolü (Dependencies) ister. AppContainer kendini bu maskeyle içeri atar.
