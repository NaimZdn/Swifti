//
//  ArticlesLabel.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct ArticlesLabel: View {
    var cover: String
    var title: String
    var subject: String
    var gradient: LinearGradient
    var content: String
    
    var body: some View {
        HStack(spacing: 15) {
            ImageView(imageURL: URL(string: cover)!)
                .scaledToFill()
                .frame(maxWidth: 120, maxHeight: 90)
                .cornerRadius(5)
                .clipped()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.articlesLabelTitle)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        
                    InformationLabel(subject: subject, gradient: gradient)
                }
                .padding(.top, 2)
                Spacer()
               
                Text(content)
                    .font(.articlesLabelCaption)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
    
            }
            .frame(maxWidth: .infinity, maxHeight: 90, alignment: .leading)
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: 120)
        .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

struct ArticlesLabel_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesLabel(cover: "https://mcdn.wallpapersafari.com/medium/37/54/u6EoIC.png", title: "Mettre en place une veille efficace", subject: "Actuces", gradient: Color.gradientYellow, content: "Lorem ipsum")
    }
}
