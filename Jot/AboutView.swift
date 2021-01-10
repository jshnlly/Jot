//
//  AboutView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.brand)
                        .frame(width: 60, height: 48)
                        .background(Color.accent)
                        .cornerRadius(8)
                        .opacity(1)
                })
                
                Spacer()
                HStack {
                    Image("Logo")
                }
                
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("twitter button")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.brand)
                        .frame(width: 60, height: 48)
                        .background(Color.accent)
                        .cornerRadius(8)
                        .opacity(1)
                })
                
                
            }
            .padding()
            
            ScrollView {
                Spacer()
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("About Jot")
                                .font(.system(size: 22, weight: .medium))
                            Spacer()
                            Image(systemName: "info.circle")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.brand)
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        
                        Rectangle()
                            .frame(height: 1.6)
                            .foregroundColor(.brand)
                            .padding()
                        
                        Text("Jot is a simple note-taking application designed and developed by Josh Nelson. Jot was designed as a solution to creating unlimited notes that would only get used once and then deleted.")
                            .padding()
                        
                        Text("If you use the Notes app to write or format Email’s, Tweets, importantMessages, Jot is for you. No more cluttered notes files with snippets of info that only gets used once.")
                            .padding()
                        
                        Text("Jot something, copy-it, paste-it, and forget. It’s as simple as that.")
                            .padding()
                        
                        Text("Happy Jotting!")
                            .padding()
                            .padding(.bottom, 8)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Privacy and Data Usage")
                                    .font(.system(size: 22, weight: .medium))
                                Spacer()
                                Image(systemName: "lock")
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundColor(.brand)
                            }
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                            
                            Rectangle()
                                .frame(height: 1.6)
                                .foregroundColor(.brand)
                                .padding()
                            
                            Text("Jot does not view, see, modify, keep, or use your data in anyway. Anything you write in Jot is lost as soon as you hit clear. We do not view or monitor anything you write on Jot.")
                                .padding()

                            
                             Text("This is your space.")
                                 .padding()

                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Privacy and Data Usage")
                                    .font(.system(size: 22, weight: .medium))
                                Spacer()
                                Image(systemName: "lock")
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundColor(.brand)
                            }
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                            
                            Rectangle()
                                .frame(height: 1.6)
                                .foregroundColor(.brand)
                                .padding()
                            
                            Text("Jot does not view, see, modify, keep, or use your data in anyway. Anything you write in Jot is lost as soon as you hit clear. We do not view or monitor anything you write on Jot.")
                                .padding(8)

                            
                             Text("This is your space.")
                                 .padding( 8)
                        }

                    }
                }
            }
            
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
