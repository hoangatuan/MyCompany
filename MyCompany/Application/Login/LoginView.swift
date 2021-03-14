//
//  ContentView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/8/20.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(width: 100, height: 100, alignment: .center)
                Image("icon_admin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    TextFieldInputUsername(textfieldValue: $username, viewModel: loginViewModel)
                    TextFieldInputPassword(textfieldValue: $password, viewModel: loginViewModel)
                }.padding()
                
                ButtonLogin(viewModel: loginViewModel)
                    .alert(isPresented: $loginViewModel.isLoginFail, content: {
                        Alert(title: Text(loginViewModel.errorMessage),
                              message: nil,
                              dismissButton: .none)
                    })
                
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct TextFieldInputUsername: View {
    private let placeHolder = "Username"
    
    @Binding var textfieldValue: String
    var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(.leading)
                
                VStack {
                    TextField(placeHolder, text: $textfieldValue)
                        
                        .onChange(of: textfieldValue, perform: { value in
                            viewModel.username = value
                        }).padding()
                }
            }.background(Color(UIColor.ColorE9E9E9))
            .cornerRadius(10)
            
            HStack {
                Spacer().frame(width: 24, height: 1, alignment: .leading).padding([.leading, .trailing])
                VStack {
                    Divider()
                }
            }
        }
    }
}

struct TextFieldInputPassword: View {
    private let placeHolder = "Password"
    
    @Binding var textfieldValue: String
    var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "lock.circle")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(.leading)
                
                SecureField(placeHolder, text: $textfieldValue)
                    .onChange(of: textfieldValue, perform: { value in
                        viewModel.password = value
                    }).padding()
            }.background(Color(UIColor.ColorE9E9E9))
            .cornerRadius(10)
            
            HStack {
                Spacer().frame(width: 24, height: 1, alignment: .leading).padding([.leading, .trailing])
                VStack {
                    Divider()
                }
            }
        }
    }
}

struct ButtonLogin: View {
    private let buttonSignInTilte: String = "SIGN IN"
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Button(action: {
            viewModel.login()
        }, label: {
            Text(buttonSignInTilte)
                .foregroundColor(Color(UIColor.ColorFF88A7))
                .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
        }).frame(width: UIScreen.main.bounds.width - 32)
        .background(Color.white)
        .cornerRadius(30.0)
        .shadow(color: Color(UIColor.ColorFF88A7), radius: 8, x: 0, y: 0)
        .padding()
    }
}
