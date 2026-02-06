//
//  View.swift
//  DependencyIntejctionWorking
//
//  Created by Koray Urun on 6.02.2026.
//

import SwiftUI

struct MainDashBoardView : View {
    // Container'ı dışarıdan alıyoruz
    let container : AppContainer
    
    var body : some View {
        
        /*
         Neden HomeView(vm: HomeViewModel(deps: container)) yazdık?

         Bu, Interface Segregation'ın sihridir!

         Senin AppContainer sınıfın HomeDependencies protokolüne uyuyor mu? Evet. * HomeViewModel ne bekliyor? HomeDependencies protokolüne uyan herhangi bir şey.
         */
        
        // Ana sayfa : sadece HomeDependencies paketini veriyoruz
        HomeView(vm : HomeViewModel(deps : container))
            .tabItem{ Label("Ana Sayfa", systemImage: "house")}
        
        // Transfer Sayfası : Sadece TransferDependencies paketini veriyoruz
        TransferView(vm : TransferViewModel(deps: container))
            .tabItem{Label("Transfer", systemImage: "arrow.right.arrow.left")}
        
        
    }
    
    
}


struct HomeView : View {
    @StateObject var vm : HomeViewModel
    
    var body : some View {
        VStack(spacing : 20) {
            Text("Hoş geldin, \(vm.userName)")
            Text("Bakiyeniz: \(vm.balance)")
                .font(.title).bold()
        }
    }
}

struct TransferView : View {
    @StateObject var vm : TransferViewModel
    
    var body : some View {
        Button("100 TL gönder") {
            vm.sendMoney()
        }
        .buttonStyle(.borderedProminent)
    }
    
}

#Preview {
    MainDashBoardView(container: AppContainer())
}
