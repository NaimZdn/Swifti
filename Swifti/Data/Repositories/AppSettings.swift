//
//  AppSettings.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import Foundation
import SwiftUI

class AppSettings: ObservableObject {
    @AppStorage("isNotificationEnabled") var isNotificationEnabled = false    
}
