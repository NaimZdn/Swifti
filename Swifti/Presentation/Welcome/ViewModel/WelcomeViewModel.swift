//
//  WelcomeViewModel.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import Foundation
import CoreData

class WelcomeViewModel: ObservableObject {
    @Published var isUserRegistered = false
    
    func addUserAndRedirectToHome(name: String) {
        DataController.shared.addUserNameToData(name: name)
        isUserRegistered = true
    }
    
    func containsOnlySpaces(_ input: String) -> Bool {
        let trimmedInput = input.trimmingCharacters(in: .whitespaces)
        return trimmedInput.isEmpty
    }
}
