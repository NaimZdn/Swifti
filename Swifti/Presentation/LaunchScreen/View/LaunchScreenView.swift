//
//  LaunchScreenView.swift
//  Swifti
//
//  Created by Zidouni on 22/07/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("logo")
                .foregroundColor(.primaryColor)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
