//
//  ImageView.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        .accessibilityAddTraits(.isImage)
    }
}

struct ImageView_Previews: PreviewProvider {
    @State static private var imageURL = URL(string: "https://mcdn.wallpapersafari.com/medium/37/54/u6EoIC.png")!
    
    static var previews: some View {
        ImageView(imageURL: imageURL)
    }
}
