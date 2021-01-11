//
//  PrivacyView.swift
//  Jot
//
//  Created by Josh Nelson on 1/10/21.
//

import SwiftUI

struct PrivacyView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        
//        dismiss button
        
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    isPresented = false
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.brand)
                        .frame(width: 60, height: 48)
                        .background(Color.bg)
                        .cornerRadius(8)
                        .opacity(1)
                })
                Spacer()
            }
            .padding(.bottom, 24)
            
//            content
            
            Text("Privacy and Data Usage")
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 24)
            
            Text("Jottie does not view, see, modify, keep, or use your data in anyway. Anything you write in Jot is lost as soon as you hit clear. We do not view or monitor anything you write on Jottie.")
                .padding(.bottom, 16)
                
            Text("This is your space.")
            
            Spacer()
        }
        .padding()
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView(isPresented: .constant(true))
    }
}
