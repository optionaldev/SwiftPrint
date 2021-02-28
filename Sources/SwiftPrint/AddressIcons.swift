//
// The  project.
// Created by optionaldev on 28/02/2021.
// Copyright © 2021 optionaldev. All rights reserved.
// 

internal struct Constants {
    
    static let icons = ["💜", "💛", "💚", "💙", "❤️", "💟", "❇️", "㊗️", "🚹", "🚺", "🚼",
                        "🅰️", "⏺", "🔴", "🔵", "🔶", "🔥", "👚", "👗", "🍷", "🍔", "🦊",
                        "🍋", "🍎", "🍏", "🌵", "🔮", "🥑", "💎", "💊", "🧸", "🖼", "🥎"]
}

internal struct AddressIcons {
    
    init() {}
    
    var currentIndex: Int = 0
    
    var addressToIconDictionary: [String: String] = [:]
    
    mutating func icon(for addressString: String) -> String? {
        if let icon = addressToIconDictionary[addressString] {
            return icon
        } else {
            if currentIndex < Constants.icons.count - 1 {
                addressToIconDictionary[addressString] = Constants.icons[currentIndex]
                currentIndex += 1
                return addressToIconDictionary[addressString]
            } else {
                addressToIconDictionary[addressString] = Constants.icons[0]
                currentIndex = 1
                return addressToIconDictionary[addressString]
            }
        }
    }
}
