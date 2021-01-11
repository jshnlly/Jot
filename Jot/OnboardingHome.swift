//
//  OnboardingHome.swift
//  Jot
//
//  Created by Josh Nelson on 1/10/21.
//

import SwiftUI

struct OnboardingHome: View {
    @State var slider1 = false
    @State var slider2 = false
    
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Welcome to Jot")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.brand)
                        
                        Text("The simple and ease to use note taking app meant to replace your single-use note files.")
                            .lineLimit(2)
                        Spacer()
                        
                  
                        
                    }
                    .padding(.top, 48)
                    .padding()
                    Image("onboarding")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding()

                }
                
                HStack {
                
                    Spacer()
                    
                    Button(action: {
                        slider1 = true
                    }, label: {
                        HStack {
                            Text("Start Jotting")
                                .font(.system(size: 20, weight: .medium))
                            Image(systemName: "arrow.right")
                                .padding(.leading, 8)
                                .font(.system(size: 24, weight: .medium))
                        }
                        .padding()
                        .background(Color.brand)
                        .cornerRadius(10)
                            
                    })
                }
                .padding(16)
                .padding(.top, 120)
            }
        }
        .offset(x: slider1 ? -screen.width : 0)
        .animation(.easeIn)
        
        
    }
}

struct OnboardingHome_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHome()
    }
}
