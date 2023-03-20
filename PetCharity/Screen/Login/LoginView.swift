//
//  LoginView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import SwiftUI

// MARK: - 登录View
struct LoginView: View {
    
    @EnvironmentObject private var systemData: SystemDataModel
    
    @StateObject private var loginData = LoginViewModel()
    @State private var showErrorAlert = false
    @State private var message: String = ""
    
    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 16, content: {
                titleView
                
                welcomeView
                
                inputBoxView
                
                swButton
                
                submitButton
            })
            .padding()
            .padding(.top, 4)
            .padding(.bottom, 8)
            .background(Color("AppBg2").opacity(0.75))
            .cornerRadius(12)
            .frame(width: systemData.width / 4, height: systemData.height / 4)
            .offset(x: systemData.width / 5)
        }
        .frame(width: systemData.width,height: systemData.height)
        .background(loginBg)
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("错误!"), message: Text(message), dismissButton: .default(Text("OK")))
        }
        
        
        
    }
}

// MARK: - 子View
private extension LoginView {
    @ViewBuilder private var titleView: some View {
        Text("后台管理系统")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.myLinearGradient1())
    }
    
    @ViewBuilder private var welcomeView: some View {
        HStack {
            Text(loginData.shouldShowForgetPassword ? "找回登录密码" :  "欢迎登录")
                .font(.title3)
                .opacity(0.5)
                .transformEffect(.identity)
            Spacer()
        }
    }
    
    
    @ViewBuilder private var inputBoxView: some View {
        Label(title: {
            
            TextField("手机号", text: $loginData.username )
                .keyboardType(.numberPad)
        }, icon: {
            Image(systemName: "person.circle")
                .frame(width: 32)
        })
        .opacity(0.5)
        Divider()
        
        if loginData.shouldShowForgetPassword {
            Label(title: {
                SecureField("验证码", text: $loginData.code)
                    .keyboardType(.numberPad)
            }, icon: {
                Image(systemName: "message.circle")
                    .frame(width: 32)
            })
            .opacity(0.5)
            .transition(
                .asymmetric(
                    insertion: .opacity.animation(.easeInOut(duration: 0.3).delay(0.3)),
                    removal: .opacity
                )
            )
            Divider()
        }
        
        Label(title: {
            SecureField(loginData.shouldShowForgetPassword ? "新密码" : "密码", text: $loginData.password)
        }, icon: {
            Image(systemName: "lock.circle")
                .frame(width: 32)
        })
        .opacity(0.5)
        .transition(.opacity)
        Divider()
        
        if loginData.shouldShowForgetPassword {
            Label(title: {
                SecureField("重复密码", text: $loginData.password2)
            }, icon: {
                Image(systemName: "lock.circle")
                    .frame(width: 32)
            })
            .opacity(0.5)
            .transition(
                .asymmetric(
                    insertion: .opacity.animation(.easeInOut(duration: 0.3).delay(0.3)),
                    removal: .opacity
                )
            )
            Divider()
        }
        
    }
    
    var swButton: some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.6)) {
                    loginData.clearData()
                    loginData.shouldShowForgetPassword.toggle()
                }
            }, label: {
                Text(loginData.shouldShowForgetPassword ? "返回登录" :  "忘记密码")
                    .opacity(0.25)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                    .transformEffect(.identity)
            })
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        
    }
    
    var submitButton: some View {
        Button(action: login) {
            Text(loginData.shouldShowForgetPassword ? "找回密码" : "登录")
                .foregroundColor(.white)
                .frame(width: 200)
                .padding(.vertical, 8)
                .background(.myLinearGradient1())
                .cornerRadius(4)
                .transformEffect(.identity)
        }
        .buttonStyle(.plain)
        .font(.caption)
        .buttonBorderShape(.roundedRectangle)
        .padding(.top, -10)
        
    }
    
    var loginBg: some View {
        Image("LoginBg")
            .resizable()
            .frame(height: systemData.height)
            .ignoresSafeArea(.all, edges: .all)
    }
    
    func login() -> Void {
        
        AdminApi.login(loginData.username, loginData.password) { result in
            switch result {
            case let .success(data):
                if data.code == 200 {
                    // 登录成功
                    if let userData = data.data {
                        withAnimation {
                            UserDefaults.standard.set(userData.rawValue, forKey: .adminUser)
                            UserDefaults.standard.set(userData.token, forKey: .token)
                            UserDefaults.standard.set(true, forKey: .isLogin)
                            NetworkManager.shared.setToken(userData.token ?? "")
                        }
                        
                    }
                } else if data.code == 204 {
                    showErrorAlert = true
                    message = "手机号、密码错误"
                    
                } else if data.code == 400 {
                    showErrorAlert = true
                    message = "手机号、密码格式错误"
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

