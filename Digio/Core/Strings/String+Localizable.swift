//
//  String+Localizable.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: "", comment: "")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(
            format: NSLocalizedString(self, tableName: "Localizable", value: "", comment: ""),
            arguments: args
        )
    }
}
