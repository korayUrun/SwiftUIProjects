//
//  ContentView.swift
//  SwiftDataWorking
//
//  Created by Koray Urun on 4.02.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Verileri tarihe göre sıralı çekiyoruz
    @Query(sort : \TodoItem.createdAt, order: .reverse) private var items : [TodoItem]
    
    // Veritabanı işlemleri için context
    @Environment(\.modelContext) private var modelContext
    
    @State private var newTaskTitle = ""
    

    var body: some View {
            NavigationStack {
                List {
                    TextField("Yeni görev...", text: $newTaskTitle)
                        .onSubmit(addItem)

                    ForEach(items) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            if item.isCompleted { Image(systemName: "checkmark") }
                        }
                        .onTapGesture { item.isCompleted.toggle() }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("SwiftData Tasks")
            }
        }

        private func addItem() {
            guard !newTaskTitle.isEmpty else { return }
            let newItem = TodoItem(title: newTaskTitle)
            modelContext.insert(newItem) // Kaydetme işlemi otomatik tetiklenir
            newTaskTitle = ""
        }

        private func deleteItems(offsets: IndexSet) {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
#Preview {
    ContentView()
}


/*
 
 1. NEDEN SwiftData ?
 Eskiden CoreData'da .xcdatamodeld dosyalarıyla uğraşılıyordu.
 SwiftData ile :
 a. Pure Swift : Sadece standart sınıflar ve makrolar kullanılır
 b. Otomatik Senkronizasyon: Modeldeki bir değişiklik anında UI'ya yansır
 c. CloudKit Entegrasyonu: Neredeyse sıfır efor ile verileri iCloud'a taşıyabiliriz.
 d. Type Safety: NSManagedObject casting işlemleri ile uğraşmayız
 
 2. Temel Bileşenleri
 SwiftData üç ana sütun üzerine kuruludur:
 a. Model : @Model makrosu ile işaretlediğin standart bir Swift sınıfı. Şemayı belirler
 b. ModelContainer: Veritabanının "deposu". Hangi modellerin saklanacağını ve nerede saklanacağını bilir
 c. ModelContext: Verilerle etkileşime girdiğin (ekleme,silme,güncelleme) alan.
 Genelde mainContext üzerinden işlem yaparız
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
