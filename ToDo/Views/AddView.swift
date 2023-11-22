//
//  AddView.swift
//  ToDo
//
//  Created by Josileudo on 11/3/23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldValue: String = ""
    
    var fieldColor: UIColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    var buttonBackgroundColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Anything task here", text: $textFieldValue)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(fieldColor))
                    .cornerRadius(16)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .frame(height: 40)
                        .frame(maxWidth: 100)
                        .background(Color(buttonBackgroundColor))
                        .cornerRadius(16)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an Title ✒️")
    }
    
    func saveButtonPressed() {
        listViewModel.addItem(title: textFieldValue)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }.environmentObject(ListViewModel())
    }
}
