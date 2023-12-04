//
//  InputView.swift
//  ToDo
//
//  Created by Josileudo on 11/29/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    var title: String
    var placeHolder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if(isSecureField) {
                SecureField(placeHolder, text: $text)
                    .padding(.horizontal)
                    .font(.system(size: 14))
                    .frame(height: 50)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
            } else {
                TextField(placeHolder, text: $text)
                    .padding(.horizontal)                   
                    .font(.system(size: 14))
                    .frame(height: 50)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    
            }
            
            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputView(text: .constant("test"), title: "Username", placeHolder: "Write here", isSecureField: false)
        }
        .previewLayout(.sizeThatFits)
    }
}
