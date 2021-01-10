//
//  SettingsView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI

struct SettingsView: View {
    @State var darkMode = false
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
                        Image(systemName: darkMode ? "sun.min" : "moon")
                            .padding(.trailing, 8)
                            .font(.system(size: 22, weight: .medium)).foregroundColor(.brand)
                            .animation(.easeInOut)
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

                            Text("About Jot")
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
                        AboutView()
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
