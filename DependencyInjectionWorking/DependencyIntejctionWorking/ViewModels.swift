//
//  ViewModels.swift
//  DependencyIntejctionWorking
//
//  Created by Koray Urun on 6.02.2026.
//

import Foundation

// Ana Ekran ViewModel
class HomeViewModel : ObservableObject {
    @Published var userName : String = ""
    @Published var balance : String = ""
    
    private let deps : HomeDepedencies
    
    init(deps : HomeDepedencies){
        self.deps = deps
        setup()
    }
    
    func setup() {
        userName = deps.profileService.getUsername()
        balance = "\(deps.accountService.getBalance()) TL"
    }
}

// Transfer ViewModel
class TransferViewModel : ObservableObject {
    private let deps : TransferDepedencies
    
    init(deps : TransferDepedencies) {
        self.deps = deps
    }
    
    func sendMoney() {
        // sadece izin verilen servislere erişebilir
        _ = deps.paymentService.makeTransfer(amount: 100, to: "TR00...12")
    }
    
    
    
    
}



