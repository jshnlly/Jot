//
//  ContentView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var title = ""
    @State var note = "Jot something..."
    @State var clearPosition = false
    @State private var showArrow = false
    @State private var keyboardSize: CGFloat = 0
    @State var showSettings = false
    @State var titleView = true
    @State var frameSize = false
    @State var placeholderString = "Jot something..."
    @State private var sharing = false
    @State var showCopy = false
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack {
                        VStack {
                            TextField("Add a title",text: $title)
                                .padding(.leading, 16)
                                .padding(.top, 16)
                                .font(.system(size: 24, weight: .semibold))
                                .opacity(titleView ? 1 : 0)
                            
                            TextEditor(text: $note)
                                .padding(.leading, 12)
                                .padding(.top, 12)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(note != placeholderString ? .textColor : .placeholder)
                                .frame(height: frameSize ? 750 : 300 )
                                .onTapGesture {
                                            if note == placeholderString {
                                              self.note = ""
                                            }
                                          }
                        }
                    }
                }
                
                HStack(spacing: 12){
                    Button(action: {
                        if showArrow {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }, label: {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.brand)
                            .frame(width: 60, height: 48)
                            .background(Color.accent)
                            .cornerRadius(8)
                            .opacity(showArrow ? 1 : 0)
                            .animation(.easeInOut)
                    })
                    .disabled(clearPosition == true)
                    
                    Button(action: {
                        showSettings.toggle()
                    }, label: {
                        Image(systemName: "gear")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.brand)
                            .frame(width: 60, height: 48)
                            .background(Color.accent)
                            .cornerRadius(8)
                            .opacity(showArrow ? 0 : 1)
                            .animation(.easeInOut)
                    })
                    .disabled(clearPosition == true)
                    
                    Button(action: {
                        UIPasteboard.general.string = note
                        let av = UIActivityViewController(activityItems: [ UIPasteboard.general.string ?? "no data"], applicationActivities: nil)
                        
                        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.brand)
                            .frame(width: 60, height: 48)
                            .background(Color.accent)
                            .cornerRadius(8)
                            .opacity(1)
                    })
                    .disabled(clearPosition == true)
                    
                    Button(action: {
                        withAnimation {
                            showCopy.toggle()
                        }
                        UIPasteboard.general.string = note
                    }, label: {
                        HStack {
                            Image(systemName: "doc.on.doc")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.brand)
                        }
                        .padding(4)
                        .frame(width: 60, height: 48)
                        .background(Color.accent)
                        .cornerRadius(8)
                    })
                    .disabled(clearPosition == true)
                    
                    Button(action: {
                        if note.count > 20 || title.count != 0  {
                            clearPosition.toggle()
                        } else {
                         note = "Jot something..."
                        }
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.brand)
                        }
                        .frame(width: 60, height: 48)
                        .background(Color.accent)
                        .cornerRadius(8)
                        
                    })
                    .disabled(clearPosition == true)
                }
                .padding(16)
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                        return
                    }
                    showArrow = true
                    self.keyboardSize = keyboardFrame.height
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                    
                    frameSize = true
                    showArrow.toggle()
                }
            }
            .animation(.easeInOut)
            
            Rectangle()
                .foregroundColor(.overlay)
                .opacity(clearPosition || showSettings || showCopy ? 0.6 : 0)
                .edgesIgnoringSafeArea(.all)
                .animation(.easeInOut)
                .onTapGesture {
                    if showSettings || showCopy {
                    showSettings = false
                    showCopy = false
                    }
                }
            
                
                VStack {
                    VStack {
                        Text("Are you sure you want to clear?")
                            .font(.system(size: 20, weight: .medium))
                            .padding(4)
                        Text("This cannot be undone.")
                            .foregroundColor(Color(#colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 1)))
                        Button(action: {
                            title = ""
                            note = "Jot something..."
                            clearPosition.toggle()
                        }, label: {
                            Text("Clear Note")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.error)
                                .frame(width: screen.width - 64, height: 44)
                                .background(Color.accent)
                                .cornerRadius(8)
                        })
                        .padding(.bottom, 8)
                        .padding(.top, 8)

                        Button(action: {
                            clearPosition.toggle()
                        }, label: {
                            Text("Cancel")
                                .font(.system(size: 18, weight: .regular))
                                .frame(width: screen.width - 64, height: 44)
                                .background(Color.accent)
                                .cornerRadius(8)
                        })
                    }
                    .padding()
                    .frame(width: screen.width - 32, height: 220, alignment: .center)
                    .background(Color.sheet)
                    .cornerRadius(10)
                    .offset(y: clearPosition ? 24 : -300)
                    .animation(.easeInOut)
                    
                    Spacer()
                    
                    SettingsView(titleView: $titleView, showSettings: $showSettings)
                        .offset(y: showSettings ? 0 : 450)
                        .animation(.easeInOut)
                    
            }
            
            CopyAlertView()
                .offset(y: showCopy ? 0 : -200)
                .opacity(showCopy ? 1 : 0)
                .animation(Animation.easeInOut.repeatCount(1, autoreverses: true))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let placeholder = Color("placeholder")
    static let brand = Color("brand")
    static let error = Color("error")
    static let sheet = Color("sheet")
    static let accent = Color("accent")
    static let overlay = Color("overlay")
    static let textColor = Color("textColor")
}

let screen = UIScreen.main.bounds

