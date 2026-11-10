//
//  ContentView.swift
//  iExpensive2
//
//  Created by André on 28/10/2026.
//

import SwiftUI

struct itemCaro: Identifiable, Codable{
    let id: UUID
    let nombre: String
    let tipo: String
    let coste: Double
}

@Observable
class Caros {
    var items = [itemCaro](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
        
    }
    
    init(){
        if let guardarItem = UserDefaults.standard.data(forKey: "items"){
            if let decodedItem = try? JSONDecoder().decode([itemCaro].self, from: guardarItem){
                items = decodedItem
                return
            }
        }
    }
    
}

struct ContentView: View {
    /*
    @State private var mostrarHoja = false
    @State private var nom = ""
    */
    
    @State private var caro = Caros()
    
    @State private var mostrarAnhadirGastos = false
    
    var body: some View {
        /*
        VStack{
            
            TextField("nombre",text: $nom).textFieldStyle(.roundedBorder)
            
            Button("Mostrar HOJA 1"){
                mostrarHoja.toggle()
            }
            .sheet(isPresented: $mostrarHoja){
                SegundaVista(nombre : $nom)
            }
            
        }*/
        NavigationStack{
            List{
                ForEach(caro.items, id: \.id){item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.nombre).font(.headline)
                            Text(item.tipo)
                        }
                        Spacer()
                        Text(item.coste, format: .currency(code: "EUR"))
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(item.nombre), \(item.coste.formatted(.currency(code: "EUR")))")
                    .accessibilityHint(item.tipo)
                }.onDelete(perform: eliminarItems)
                
                }.navigationTitle("Lista elementos")
                .toolbar {
                    NavigationLink{
                        AddView(gastos: caro)
                    } label: {
                        Label("Añadir gasto", systemImage: "plus")
                    }
                }
                    /*
                    Button("Añadir gasto", systemImage: "plus"){
                        mostrarAnhadirGastos = true
                    }
                }
                
                .sheet(isPresented: $mostrarAnhadirGastos){
                    AddView(gastos: caro)
                }
                 */
        }
        
    }
    
    func eliminarItems(at fuera: IndexSet){
        caro.items.remove(atOffsets: fuera)
    }
    
}


#Preview {
    ContentView()
}
