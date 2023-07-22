//
//  SwiftiApp.swift
//  Swifti
//
//  Created by Zidouni on 22/07/2023.
//

import SwiftUI

@main
struct SwiftiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
        }
    }
}
