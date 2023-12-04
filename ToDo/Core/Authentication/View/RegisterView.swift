//
//  RegisterView.swift
//  ToDo
//
//  Created by Josileudo on 11/29/23.
//

import SwiftUI

struct RegisterView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("ToDoIcon")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .padding(.vertical, 30)
            
            VStack {
                InputView(text: $email, title: "Email", placeHolder: "Email").autocapitalization(.none)
                InputView(text: $username, title: "Full Username", placeHolder: "Username").autocapitalization(.none)
                InputView(text: $password, title: "Password", placeHolder: "Password", isSecureField: true)
                InputView(text: $confirmPassword, title: "Confirm password", placeHolder: "Password",  isSecureField: true)
            }
            .padding(.horizontal)
            
            // MARK: Register button
            Button(action: {
                Task {
                    try await authViewModel.createUser(withEmail: email, username: username, password: password)
                }
            }, label: {
                Text("Register")
                    .frame(width: UIScreen.main.bounds.width - 130, height: 40)
                    .foregroundColor(Color.white)
            })
            .background(Color.accentColor)
            .cornerRadius(10)
            .padding(.top, 10)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.7)
            
            Spacer()
            
            // MARK: Go to login
            Button {
                
            } label: {
                Text("Do you already a count? Go to Login.")
                    .bold()
            }
            .font(.system(size: 14))
        }
    }
}

extension RegisterView: AuthFormProtocol {
    var formIsValid: Bool {
        return
            !username.isEmpty
            && email.contains("@")
            && password.count > 5
            && confirmPassword == password
            && confirmPassword.count > 5
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
