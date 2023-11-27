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
    @State var alertTitle: String = ""
    @State var alertShow: Bool = false
    
    var fieldColor: UIColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
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
                        .background(Color.accentColor)
                        .cornerRadius(16)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an Title ✒️")
        .alert(isPresented: $alertShow, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsApropriate() {
            listViewModel.addItem(title: textFieldValue)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsApropriate() -> Bool {
        if textFieldValue.count < 3 {
            alertTitle = "Your task need of more \(3 - textFieldValue.count) characters."
            alertShow.toggle()
            return false
        }
            
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }.environmentObject(ListViewModel())
    }
}
