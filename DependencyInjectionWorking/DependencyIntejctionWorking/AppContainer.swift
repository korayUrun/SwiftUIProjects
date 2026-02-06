//
//  AppContainer.swift
//  DependencyIntejctionWorking
//
//  Created by Koray Urun on 6.02.2026.
//

final class AppContainer : HomeDepedencies, TransferDepedencies, SettingsDepedencies{
    
    // Gerçek servislerimizi bir kez oluşturuyoruz
    let accountService : AccountServiceProtocol = BankManager()
    let paymentService : PaymentServiceProtocol = BankManager() // Aynı nesne iki protokolü de destekleyebilir
    let securityService : SecurityServiceProtocol = SecurityManager()
    let profileService : ProfileServiceProtocol = ProfileManager()
    
    init(){} // gerekirse burada başlatma işlemi yapılır
    
}
