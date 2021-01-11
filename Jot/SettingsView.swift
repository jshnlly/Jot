//
//  SettingsView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("darkMode") private var darkMode = false
    @Binding var titleView: Bool
    @Binding var showSettings: Bool
    @State var showingAbout = false

    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "doc.text")
                            .padding(.trailing, 8)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.brand)
                        Toggle(isOn: $titleView) {
                            Text("Start Notes with Title")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .brand))

                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color.accent)
                    .cornerRadius(8)
                    
                    HStack {
                        Image(systemName: "moon")
                            .padding(.trailing, 8)
                            .font(.system(size: 22, weight: .medium)).foregroundColor(.brand)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7))
                        Toggle(isOn: $darkMode){
                            Text("Dark Mode")
                        }
                        .foregroundColor(.textColor)
                        .toggleStyle(SwitchToggleStyle(tint: .brand))
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color.accent)
                    .cornerRadius(10)
                    
                    Button(action: {
                        showingAbout.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "info.circle")
                                .padding(.trailing, 8)
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.brand)

                            Text("About Jottie")
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
                        .background(Color.accent)
                        .cornerRadius(8)
                        .foregroundColor(.textColor)
                    })
                    .sheet(isPresented: $showingAbout, content: {
                        AboutView(aboutPresented: $showingAbout)
                            .preferredColorScheme(darkMode ? .dark : .light)
                    })
                    
                }
                .padding()
            }
            .background(Color.sheet)
            .cornerRadius(10)
            .padding()
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(titleView: .constant(true), showSettings: .constant(true))
    }
}
