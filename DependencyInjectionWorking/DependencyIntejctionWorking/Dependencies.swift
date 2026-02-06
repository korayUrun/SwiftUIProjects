//
//  Dependencies.swift
//  DependencyIntejctionWorking
//
//  Created by Koray Urun on 6.02.2026.
//

// Burada her ekranın ihtiyacı olan protokolleri içeren "Bağımlılık Paketlerini oluşturuyoruz"
// SOLID in I si Interface Segregation (Ayrıştırma)


// Ana ekran sadece bakiye ve kullanıcı adını görsün, ödeme yapamasın
protocol HomeDepedencies {
    var accountService : AccountServiceProtocol {get}
    var profileService : ProfileServiceProtocol {get}
}

// Transfer ekranı sadece ödeme ve hesap bakiyesini görsün
protocol TransferDepedencies {
    var accountService : AccountServiceProtocol {get}
    var paymentService : PaymentServiceProtocol {get}
}

// Ayarlar ekranı sadece güvenlik ve profil görsün
protocol SettingsDepedencies {
    var profileService : ProfileServiceProtocol {get}
    var securityService : SecurityServiceProtocol {get}
}
