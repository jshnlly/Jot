//
//  AboutView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI

struct AboutView: View {
    @AppStorage("darkMode") private var darkMode = false
    @State var showPrivacy = false
    @Binding var aboutPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    aboutPresented = false
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
            .padding()
            
            Image("icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 128, height: 128)
                .cornerRadius(30)
                .padding(.top, 64)
            
            Text("Jot")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.brand)
            
            Text("Version 1.0")
                .padding(.top, 4)
                .font(.subheadline)
            
            Spacer()
            
            Text("Made with ☕️ and ☀️ in Detroit.")
                .padding(.bottom, 2)
            Text("© Josh Nelson – joshn.io. All rights reserved.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack {
                Button(action: {
                    showPrivacy.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "hand.raised")
                            .padding(.trailing, 8)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.brand)

                        Text("Privacy and Data Usage")
                            .foregroundColor(.textColor)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color.bg)
                    .cornerRadius(8)
                    .foregroundColor(.textColor)
                })
                .sheet(isPresented: $showPrivacy) {
                    PrivacyView(isPresented: $showPrivacy)
                        .preferredColorScheme(darkMode ? .dark : .light)
            }
                
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://qfau8kh1q4i.typeform.com/to/V3Dv6Diw")!)
                }, label: {
                    HStack {
                        Image(systemName: "envelope")
                            .padding(.trailing, 4)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.brand)

                        Text("Contact Support")
                            .foregroundColor(.textColor)
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color.bg)
                    .cornerRadius(8)
                    .foregroundColor(.textColor)
                })
                .sheet(isPresented: $showPrivacy, content: {
                    
            })
                
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://twitter.com/jnelly2")!)
                }, label: {
                    HStack {
                        Image("twitter")
                            .padding(.trailing, 8)
                            .padding(.leading, 2)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.brand)

                        Text("Follow on Twitter")
                            .foregroundColor(.textColor)
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color.bg)
                    .cornerRadius(8)
                    .foregroundColor(.textColor)
                })
            }
            .padding()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(aboutPresented: .constant(true))
    }
}
