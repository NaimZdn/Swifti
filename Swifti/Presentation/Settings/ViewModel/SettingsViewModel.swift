//
//  SettingsViewModel.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import Foundation
import UserNotifications
import SwiftUI
import UIKit

class SettingsViewModel: ObservableObject {
    @Published var isNotificationEnabled = false
    
    private let notifications = [
    Notification(identifier: "lunchtime", title: "C'est l'heure de s'entrainer !", body: "Ca te dit une petite session d'entrainement pour bien commencer la journée ?", hour: 8, minutes: 00, isDaily: true),
    Notification(identifier: "evening", title: "Moment détente", body: "Détend-toi en venant éplucher l'actualité autour de Swift ", hour: 18, minutes: 00, isDaily: true)
    ]
    
    init(appSettings: AppSettings) {
        self.isNotificationEnabled = appSettings.isNotificationEnabled
        checkForPermission()
     
    }
    
    func disabledNotification() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                center.removeAllDeliveredNotifications()
                center.removeAllPendingNotificationRequests()
                center.setNotificationCategories([])
                center.requestAuthorization(options: [.alert, .sound]) { _, _ in }
            }
        }
    }
    
    private func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                DispatchQueue.main.async {
                    self.dispatchNotification()
                    self.isNotificationEnabled = true
                }
            case .denied:
                DispatchQueue.main.async {
                    self.isNotificationEnabled = false
                }
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                DispatchQueue.main.async {
                    self.isNotificationEnabled = false
                }
            }
        }
    }
    
    private func dispatchNotification() {
        for notification in notifications {
            let notificationCenter = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = .default
            
            let calendar = Calendar.current
            var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
            dateComponents.hour = notification.hour
            dateComponents.minute = notification.minutes
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: notification.isDaily)
            let request = UNNotificationRequest(identifier: notification.identifier, content: content, trigger: trigger)
            
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [notification.identifier])
            notificationCenter.add(request)
            
        }
    }
    
    func openAppSettings() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .denied {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(settingsUrl) else {
                    return
                }
                
                DispatchQueue.main.async {
                    UIApplication.shared.open(settingsUrl)
                }
            } else {
                self.dispatchNotification()
            }
        }
    }
}
