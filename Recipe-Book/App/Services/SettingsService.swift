//
//  UserSettings.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 17.10.2020.
//

import Foundation

final class SettingsService {
    private enum SettingsKeys: String {
        case userModel
    }
    
    static var userModel: User! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? User else {
                return nil
            }
            return decodedModel
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userModel.rawValue
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
