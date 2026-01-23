//
//  ContentView.swift
//  MvvmWrappersWorking
//
//  Created by Koray Urun on 23.01.2026.
//

import SwiftUI
    
class BookingViewModel : ObservableObject {
    @Published var passengerName = ""
    @Published var email = ""
    @Published var phone = ""
    
    var isValid : Bool {
        !passengerName.isEmpty && !email.isEmpty && !phone.isEmpty
    }
    
    func savingBooking() {
        print("Passenger with name \(passengerName) has been booked")
    }
}


struct BookingView : View {
    // ViewModel'i burada YARATIYORUZ (Sahibi biziz -> @StateObject)
    @StateObject var viewModel = BookingViewModel()
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Passenger Information"){
                    TextField("Name", text: $viewModel.passengerName)
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    TextField("Phone", text : $viewModel.phone)
                        .keyboardType(.phonePad)
                }
                
                Section{
                    // TODO: Disable submit button if invalid
                    Button("Complete Booking"){
                        viewModel.savingBooking()
                    }.disabled(!viewModel.isValid)
                } footer: {
                    // TODO: Show validation errors (Ufak bir ipucu)
                    if !viewModel.isValid {
                        Text("Please fill all required fields")
                            .foregroundStyle(.red)
                    }
                }
            } .navigationTitle("New Reservation")
        }
    }
}
    
#Preview { BookingView() }


