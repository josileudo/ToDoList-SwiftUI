//
//  LoginView.swift
//  ToDo
//
//  Created by Josileudo on 11/29/23.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // MARK: Image
            Image("ToDoIcon")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .padding(.vertical, 30)
            
            // MARK: Fields
            VStack(spacing: 12) {
                InputView(
                    text: $email,
                    title: "Email",
                    placeHolder: "Write your email"
                )
                    .autocapitalization(.none)
                
                InputView(
                    text: $password,
                    title: "Password",
                    placeHolder: "Write your passsword",
                    isSecureField: true
                )
            }
            .padding(.horizontal)
            .padding(.top, 28)
                        
            // MARK: Forgot password
            Button(action: {
                
            }, label: {
                Text("Forgot password")
                    .frame(height: 40)
                    .foregroundColor(Color.accentColor)
                    .cornerRadius(8)
            })
            
            // MARK: Button
            Button(action: {
                Task {
                    try await authViewModel.signIn(withEmail: email, password: password)
                }
            }, label: {
                Text("Sign In")
                    .frame(width: UIScreen.main.bounds.width - 130, height: 40)
                    .foregroundColor(Color.white)
            })
            .background(Color.accentColor)
            .disabled(!formIsValid)
            .cornerRadius(10)
            .padding(.top, 10)
            .opacity(formIsValid ? 1.0 : 0.7)
            
            Spacer()
            
            // MARK: Register
            NavigationLink {
                RegisterView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Do you haven't a count? Sign Up")
                    .bold()
            }
            .font(.system(size: 14))
        }
    }
}

extension LoginView: AuthFormProtocol {
    var formIsValid: Bool {
        return
            !email.isEmpty
            && email.contains("@")
            && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
                .preferredColorScheme(.light)
        }
        NavigationView {
            LoginView()
                .preferredColorScheme(.dark)
        }
    }
}
