//
//  AuthViewModelProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

protocol AuthViewModelProtocol {
    var onAuthSuccess: (() -> Void)? { get set }
    var onAuthError: ((String) -> Void)? { get set }
    func authenticate(login: String, password: String)
}
