//
//  Protocols.swift
//  DependencyIntejctionWorking
//
//  Created by Koray Urun on 5.02.2026.
//

protocol AccountServiceProtocol {
    func getBalance() -> Double
}

protocol PaymentServiceProtocol {
    func makeTransfer(amount : Double, to: String) -> Bool
}

protocol SecurityServiceProtocol {
    func getTwoFactorStatus() -> Bool
    func updateBiometrics(isEnabled: Bool)
}

protocol ProfileServiceProtocol {
    func getUsername() -> String
}
