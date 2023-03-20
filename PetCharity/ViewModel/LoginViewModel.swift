//
//  LoginViewModel.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = "" {
        didSet {
            if username.count > 11 {
                username = oldValue
            } else {
                // 判断输入内容是否为纯数字
                if !username.validate("^[0-9]*$") {
                    username = oldValue
                }
            }
        }
    }
    @Published var password = "" {
        didSet {
            if password.count > 20 {
                password = oldValue
            }
        }
    }
    @Published var password2 = "" {
        didSet {
            if password2.count > 20 {
                password2 = oldValue
            }
        }
    }
    @Published var code = "" {
        didSet {
            if code.count > 6 {
                code = oldValue
            } else {
                // 判断输入内容是否为纯数字
                if !code.validate("^[0-9]*$") {
                    code = oldValue
                }
            }
        }
    }
    
    @Published var shouldShowForgetPassword = false
    
    func clearData() {
        username = ""
        password = ""
        password2 = ""
        code = ""
    }
}
