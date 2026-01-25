//
//  ContentView.swift
//  MVVMShoppingCart
//
//  Created by Koray Urun on 25.01.2026.
//

import SwiftUI

// Model (Data)
struct Product : Identifiable {
    var id  = UUID()
    var name : String
    var price : Double
}

// ViewModel
class ProductViewModel : ObservableObject{
    // Sepet değiştiğinde herkes duysun diye @Published
    @Published var selectedProducts : [Product] = []
    
    // Total amount
    //Kod, 0'dan başlayıp her bir ürünün fiyatını mevcut toplama ekler ve sonucu toplamTutar olarak döndürür.
    var totalAmount : Double {
        selectedProducts.reduce(0){$0 + $1.price}
    }
    
    func add(product : Product){
        selectedProducts.append(product)
    }
    
    func clean(){
        selectedProducts.removeAll()
    }
}

// ROOT VIEW
//Burası en kritik yer. ViewModel'i ilk ve tek kez burada yaratıp (@StateObject), .environmentObject modifier'ı ile tüm alt görünümlere "ışınlıyoruz".

struct AnaMagazaApp : View {
    // 1. Veri kaynağını burada yaratıyoruz
    @StateObject var cart = ProductViewModel()
    
    var body : some View {
        TabView {
            ProductListView()
                .tabItem {Label("Products", systemImage: "list.dash")}
            
            SepetDetayView()
                .tabItem {Label("My cart (\(cart.selectedProducts.count))", systemImage: "cart")
            }
        }
        //// 2. ENJEKSİYON: Tüm TabView ve altındakiler artık bu veriye erişebilir
        .environmentObject(cart)
    }
}


// Child View 1 (Veriyi değiştiren ekran)
// burada cart ı parametre olarak almadık, havadan yakaladık

struct ProductListView : View {
    // Tüketim : @EnvironmentObject ile veriyi havada yakalıyoruz
    // Başlangıç değeri atanmaz (= SepetViewModel() DENMEZ)
    @EnvironmentObject var cart : ProductViewModel
    
    let ornekUrunler = [
            Product(name: "Laptop", price: 25000),
            Product(name: "Mouse", price: 500),
            Product(name: "Klavye", price: 1500)
        ]
    
    var body: some View {
            NavigationView {
                List(ornekUrunler, id: \.id) { urun in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(urun.name).font(.headline)
                            Text("\(Int(urun.price)) TL")                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Ekle") {
                            // Veriyi burada değiştiriyoruz
                            cart.add(product: urun)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .navigationTitle("Mağaza")
            }
        }
}

struct SepetDetayView: View {
    // Yine aynı şekilde havadan yakalıyoruz
    @EnvironmentObject var sepetVM: ProductViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if sepetVM.selectedProducts.isEmpty {
                    ContentUnavailableView("Sepet Boş", systemImage: "cart")
                } else {
                    List {
                        ForEach(sepetVM.selectedProducts) { urun in
                            HStack {
                                Text(urun.name)
                                Spacer()
                                Text("\(Int(urun.price)) TL")
                            }
                        }
                        
                        Section {
                            HStack {
                                Text("Toplam")
                                Spacer()
                                Text("\(Int(sepetVM.totalAmount)) TL")
                                    .bold()
                            }
                        }
                    }
                    
                    Button("Sepeti Boşalt") {
                        withAnimation {
                            sepetVM.clean()
                        }
                    }
                    .tint(.red)
                    .padding()
                }
            }
            .navigationTitle("Sepetim")
        }
    }
}

















#Preview {
    AnaMagazaApp()
}
