//
//  AddView.swift
//  iExpensive2
//
//  Created by André on 28/10/2026.
//

import SwiftUI


struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = "Nuevo Gasto"
    @State private var type = "Personal"
    @State private var cuenta = 0.0
    
    var gastos : Caros
    
    let tipos = ["Personal","Empresa"]
    
    var body: some View {
        
        NavigationStack{
            Form{
                //TextField("Nombre", text: $name)
                
                Picker("Tipo", selection: $type){
                    ForEach(tipos, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("Cuenta", value: $cuenta, format: .currency(code: "EUR")).keyboardType(.decimalPad)

            }   .navigationTitle($name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar{
                    /*
                    Button("Guardar"){
                        let item = itemCaro(id: UUID(),nombre: name,tipo: type, coste: cuenta)
                        gastos.items.append(item)
                        dismiss()
                    }
                     */
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancelar"){
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction){
                        Button("Guardar"){
                            let item = itemCaro(id: UUID(),nombre: name,tipo: type, coste: cuenta)
                            gastos.items.append(item)
                            dismiss()
                        }
                    }
                    
                }
            
        }
     
        
    }
}

#Preview {
    AddView(gastos: Caros())
}
