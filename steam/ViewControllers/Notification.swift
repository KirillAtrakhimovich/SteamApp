import Foundation
import UserNotifications

class Notification: NSObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print(Constants.declinedNotifications)
            }
        }
    }

    func scheduleNotification() {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        contentSettings(content: content)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600 , repeats: true)
        let identifier = Constants.identifier
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("\(Constants.error) \(error.localizedDescription)")
            }
        }
    }
    
    func contentSettings(content: UNMutableNotificationContent) {
        
        let userActions = Constants.userActions
        
        content.title = Constants.title
        content.body = Constants.body
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.badge,.banner,.sound])
    }
}

extension Notification {
    struct Constants {
        static let userActions = "User Actions"
        static let title = "Steam"
        static let body = "Steam has new discounts for you, just check it!"
        static let identifier = "Local Notification"
        static let declinedNotifications = "User has declined notifications"
        static let error = "Error"
    }
}
