//
//  ConcreteClasses.swift
//  DependencyIntejctionWorking
//
//  Created by Koray Urun on 6.02.2026.
//

class BankManager : AccountServiceProtocol, PaymentServiceProtocol {
    func getBalance() -> Double {return 12500.50}
    
    func makeTransfer(amount: Double, to: String) -> Bool {
        print("\(amount) TL, \(to) hesabınıza gönderildi.")
        return true
    }
}

class SecurityManager : SecurityServiceProtocol {
    func getTwoFactorStatus() -> Bool {
        return true
    }
    
    func updateBiometrics(isEnabled: Bool) {
        print("Biometric status: \(isEnabled)")
    }
}

class ProfileManager : ProfileServiceProtocol {
    func getUsername() -> String {
        return "Senior_iOS_Dev"
    }
}
