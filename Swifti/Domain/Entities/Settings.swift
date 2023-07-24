//
//  Settings.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import Foundation

enum Label: String, CaseIterable {
    case notification = "Activer les notifications"
    case rate = "Noter l'application"
    case about = "À propos"
    case privacy = "Politique de confidentialité"
    case term = "Conditions d'utilisations"
    
    var icon: String {
        switch self {
        case .notification:
            return "bell"
        case .rate:
            return "star"
        case .about:
            return "question"
        case .privacy:
            return "book"
        case .term:
            return "rules"
        }
    }
}

enum Techno: String, CaseIterable {
    case swift = "Swift"
    case swiftUi = "Swift UI"
    //case combine = "Combine"
    //case alamofire = "Alamofire"
    case coreData = "Core Data"
    case figma = "Figma"
}

enum Term: String, CaseIterable {
    case applicationUse = "Utilisation de l'application"
    case applicationContent = "Contenu de l'application"
    case userBehavior = "Comportement de l'utilisateur"
    case confidentiality = "Confidentialité"
    case applicationUpdates = "Modifications de l'application"
    case responsability = "Responsabilité"
    case intellectualProperty = "Droits de propriété intellectuelle"
    case changes = "Modifications des conditions d'utilisation"
    case contactUs = "Contactez-nous"
    
    var content: String {
        switch self {
        case .applicationUse:
            return "L'application Swifti est conçue pour vous aider à apprendre à coder en utilisant le langage Swift. Vous pouvez utiliser l'application à des fins personnelles et non commerciales. Vous ne pouvez pas utiliser l'application d'une manière qui enfreint les lois et réglementations applicables."
        case .applicationContent:
            return "Tout le contenu de l'application Swifti, y compris les textes, les images, les vidéos et autres médias exeptés les images illustrants les articles, est la propriété de Zidouni Naïm et est protégé par les lois sur les droits d'auteur. Vous ne pouvez pas copier, reproduire, distribuer ou modifier le contenu de l'application sans notre autorisation écrite."
        case .userBehavior:
            return "En utilisant l'application Swifti, vous acceptez de ne pas : \na. Utiliser l'application d'une manière qui pourrait perturber, endommager ou compromettre son fonctionnement ou la sécurité du réseau.\nb. Utiliser l'application pour envoyer du spam, du contenu abusif, offensant, ou illégal.\nc. Accéder à des parties de l'application qui ne sont pas publiques ou qui ne vous sont pas autorisées.\nd. Utiliser l'application pour collecter des informations personnelles d'autres utilisateurs sans leur consentement."
        case .confidentiality:
            return "Votre vie privée est importante pour nous. Veuillez consulter notre politique de confidentialité pour comprendre comment nous collectons, utilisons, stockons et protégeons vos informations personnelles lorsque vous utilisez l'application Swifti."
        case .applicationUpdates:
            return "Nous nous réservons le droit de mettre à jour, modifier ou suspendre l'application Swifti à tout moment, sans préavis."
        case .responsability:
            return "L'utilisation de l'application Swifti se fait à vos propres risques. Nous ne garantissons pas que l'application sera exempte d'erreurs, de virus ou d'autres problèmes techniques. Nous ne sommes pas responsables des dommages directs, indirects, spéciaux, consécutifs ou exemplaires découlant de l'utilisation de l'application."
        case .intellectualProperty:
            return "Tous les droits de propriété intellectuelle liés à l'application Swifti sont la propriété de Zidouni Naïm. Vous ne pouvez pas utiliser nos marques, logos ou autres éléments de propriété intellectuelle sans notre autorisation écrite."
        case .changes:
            return "Nous nous réservons le droit de mettre à jour ou de modifier ces conditions d'utilisation à tout moment. Toute modification sera publiée dans l'application. Nous vous encourageons à consulter régulièrement ces conditions d'utilisation pour vous tenir informé des modifications éventuelles."
        case .contactUs:
            return "Si vous avez des questions concernant cette politique de confidentialité ou si vous souhaitez exercer vos droits liés à vos informations personnelles, veuillez nous contacter à l'adresse suivante : support@swifti.io."
        }
    }
}

enum PrivacyPolicy: String, CaseIterable {
    case dataSecurity = "Information Collection and Use"
    case sharingInformation = "Partage des informations"
    case link = "Information Sharing"
    case changes = "Changes to this Privacy Policy"
    case consent = "Your Consent"
    
    var content: String {
        switch self {
        case .sharingInformation:
            return "NNous ne partagerons pas vos informations personnelles avec des tiers sans votre consentement explicite, sauf dans les cas prévus par la loi."
        case .dataSecurity:
            return "Nous prenons la sécurité de vos informations personnelles au sérieux et mettons en place des mesures techniques et organisationnelles pour protéger vos données contre toute utilisation abusive, perte, accès non autorisé, divulgation ou altération."
        case .link:
            return "Notre application peut contenir des liens vers des sites tiers. Nous ne sommes pas responsables des pratiques de confidentialité de ces sites et vous encourageons à consulter les politiques de confidentialité de ces sites tiers avant de fournir vos informations personnelles."
        case .changes:
            return "Nous nous réservons le droit de mettre à jour ou de modifier cette politique de confidentialité à tout moment. Toute modification sera publiée dans l'application. Nous vous encourageons à consulter régulièrement cette politique de confidentialité pour vous tenir informé des modifications éventuelles."
        case .consent:
            return "En utilisant l'application, vous acceptez la politique de confidentialité de l'application et êtes d'accord avec ses termes et conditions."
        }
    }
}

enum Link: String,CaseIterable {
    case linkedin
    case github
    
    var isPresented: Bool {
        switch self {
        case .linkedin:
            return false
        case .github:
            return false
        }
    }
    
    var link: String {
        switch self {
        case .linkedin:
            return "https://www.linkedin.com/in/naim-zidouni/"
        case .github:
            return "https://github.com/NaimZdn"
        }
    }
}
