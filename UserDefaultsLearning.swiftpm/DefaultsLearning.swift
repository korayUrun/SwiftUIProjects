
import SwiftUI

struct SettingsView: View {
    // @AppStorage arka planda "isDarkMode" anahtarıyla UserDefaults'a kaydeder.
    // Eğer değer yoksa varsayılan olarak 'false' kabul eder.
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body : some View {
        
        NavigationView {
            Form {
                Section(header : Text("Görünüm")){
                    Toggle(isOn: $isDarkMode){
                        HStack{
                            Image(systemName : isDarkMode ? "moon.stars.fill" : "sun.max.fill")
                                .foregroundStyle(isDarkMode ? .purple : .orange)
                            Text("Koyu Tema")
                        }
                    }
                }
                Section {
                    Text("Şu anki mod : \(isDarkMode ? "Koyu" : "Açık")")
                }
            }
            .navigationTitle("Ayarlar")
        }
        // Tüm uygulama hiyerarşisinde temayı  uygular
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
        
        
        
        
    }
    
}
    
#Preview {
    SettingsView()
}


/*
 
 isDarkMode değişkeni değiştirildig1inde UI re-render edilir

 Uygulama kapatıp açtığında SwiftUI, @AppStorage ile işaretlenmiş değişkeni diskten okur ve UI'ı o state ile başlatır(Otomatik Senkronizasyon yapar)

 Eğer .preferredColorScheme modifier'ını App dosyasındaki (ana giriş) ContentView'a eklersek tüm uygulamanın temasının tek bir yerden kontrol edebiliriz.

 **`Tip Güvenliği (Type Safety)`**: UserDefaults doğası gereği tip güvenli değildir. Sana bir Any? döndürür, senin onu as? String diye cast etmen gerekir. Ancak @AppStorage, Swift'in Generic yapısını kullanarak bu işlemi otomatik yapar ve sana doğrudan istediğin tipi verir.

 **`Performance`**: UserDefaults veriyi diske yazarken "batching" yapar. Yani her set işleminde anında diske yazmaz, sistemi yormamak için kısa bir süre bekleyip yazar.

 **`Default Values`**: @AppStorage kullanırken verdiğin ilk değer (örn: false), sadece UserDefaults içinde o anahtar (key) hiç yoksa kullanılır. Eğer kullanıcı bir kez bile ayarı değiştirirse, artık diskteki değer önceliklidir.

 **`Suite Name (Paylaşımlı Veri)`**: Eğer bir iOS uygulaması ve onun yanında bir "Widget" geliştiriyorsan, normal UserDefaults.standard Widget ile veri paylaşamaz. Bunun için UserDefaults(suiteName: "group.com.sirketin.uygulaman") kullanman gerekir.

 ### ***@Environment(.colorScheme) Nedir ?***

 @AppStorage : kullanıcı neyi seçti ? sorusuna cevap verir (manuel seçim)

 @Environment(.colorScheme) : Şu an iPhone'un kendisi hangi modda ? sorusuna cevap verir (sistem durumu)

 @Environment(\.colorScheme) var colorScheme // .light veya .dark döner

 Genellikle profesyonel uygulamalarda kullanıcının 3 seçeneği olur:

 1. Her zaman Açık
 2. Her zaman Koyu
 3. Sistem Ayarlarına Uy (Default budur)

 Eğer "Sistem Ayarlarına Uy" seçiliyse, senin kodun @Environment'tan gelen değere bakarak kendini boyar.

 Ipucu
 SwiftUI'da bir rengi Assets.xcassets içinde tanımlarken, aynı isim altına hem "Light" hem "Dark" varyasyonlarını koyabilirsin. Eğer bunu yaparsan, ne @AppStorage ne de @Environment ile uğraşmana gerek kalır; SwiftUI arkaplanda hangi rengi seçeceğini otomatik bilir.
 
 */
