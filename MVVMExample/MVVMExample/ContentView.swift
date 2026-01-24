//
//  ContentView.swift
//  MVVMExample
//
//  Created by Koray Urun on 24.01.2026.
//

import SwiftUI

// 1. Model (DATA) -> There is not any logic just data
struct User {
    var name: String
    var age: Int
    var isMember: Bool
}

// 2. View Model (LOGIC) -> data processing, API calls
// best practice using @Observable instead of ObservableObject, no need using @Published

@Observable
class UserViewModel {
    // View ın gözlemleyeceği ana veri
    var user : User
    
    // UI için sadece geçici durumlar (örnek : yükleniyor mu)
    var isLoading : Bool = false
    
    init(){
        self.user = User(name: "Koray", age: 22, isMember: false)
    }
    
    // İş mantığı fonksiyonları
    func registerUser(){
        isLoading = true
        // Simüle edilmiş ağ isteği
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.user.isMember = true
            self.isLoading = false
        }
    }
}

// Parent View (Ana Ekran - Source of Truth)
// ViewModel in oluşturulduğu ve yaşadığı yerdir.
// Best Practice: ViewModel'i hayatta tutmak için @State kullanılır (Eskiden StateObject idi)

struct UserProfileView: View {
    // 1. ViewModel'i burada yaratıyoruz ve sahipliği (@State) bu View'da
    @State private var viewModel = UserViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            if viewModel.isLoading{
                ProgressView()
            } else {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(viewModel.user.isMember ? .green : .gray)
                Text(viewModel.user.name)
                    .font(.title)
                
                Text(viewModel.user.isMember ? "Premium Member" : "Standard Member")
                    .foregroundStyle(.secondary)
                
                // 2. Alt görünüme ViewModel'i düz parametre olarak geçiriyoruz.
                // $ işareti veya environmentObject kullanmaya gerek yok
                EditUserSheet(viewModel : viewModel)
                
            }
        }
        .padding()
    }
}

// SUBVIEW- Child View ( düzenleme ve @Bindable)
// Best Practice : ViewModel'i let veya var olarak düz alırız. Düzenleme yapmak (Binding oluşturmak) için
// içeride @Bindable kullanırız

struct EditUserSheet: View {
    // DIKKAT : @ObservableObject yok, @Binding yok, Düz sınıf referansı
    var viewModel : UserViewModel
    
    var body: some View {
        
        // Düz gelen sınıfı, TextField ile bağlayabilmek için ($) için
        // @Bindable wrapper ına sarıyoruz
        @Bindable var vm = viewModel
        
        Form{
            
            Section("User Info"){
                // Artık $vm diyerek binding alabiliriz
                TextField("Name", text: $vm.user.name)
                Stepper("Age: \(vm.user.age)", value: $vm.user.age)
            }
            
            Section("Actions"){
                Toggle("Membership State", isOn: $vm.user.isMember)
                Button("Renew Membership"){
                    // Binding gerekmediği için direkt viewModel'i kullanabiliriz
                    viewModel.registerUser()
                }
            }
            
        }
        
        
        
    }
}
    
#Preview { UserProfileView() }

