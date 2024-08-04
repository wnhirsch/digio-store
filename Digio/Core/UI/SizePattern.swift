//
//  SizePattern.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Foundation
import SnapKit

extension CGFloat {
    /// alpha = 0.1
    static let alpha10 = 0.1
    /// alpha = 0.2
    static let alpha20 = 0.2
    /// alpha = 0.25
    static let alpha25 = 0.25
    /// alpha = 0.3
    static let alpha30 = 0.3
    /// alpha = 0.4
    static let alpha40 = 0.4
    /// alpha = 0.5
    static let alpha50 = 0.5
    /// alpha = 0.6
    static let alpha60 = 0.6
    /// alpha = 0.7
    static let alpha70 = 0.7
    /// alpha = 0.76
    static let alpha75 = 0.75
    /// alpha = 0.8
    static let alpha80 = 0.8
    /// alpha = 0.9
    static let alpha90 = 0.9
    
    /// size = 2
    static let size2: CGFloat = 2
    /// size = 4
    static let size4: CGFloat = 4
    /// size = 8
    static let size8: CGFloat = 8
    /// size = 12
    static let size12: CGFloat = 12
    /// size = 16
    static let size16: CGFloat = 16
    /// size = 20
    static let size20: CGFloat = 20
    /// size = 24
    static let size24: CGFloat = 24
    /// size = 28
    static let size28: CGFloat = 28
    /// size = 32
    static let size32: CGFloat = 32
    /// size = 80
    static let size80: CGFloat = 80
}

extension CGSize {
    
    /// width = 670 | height = 320
    static let spotlightImage: CGSize = .init(width: 670, height: 320)
    /// width = 670 | height = 192
    static let cashImage: CGSize = .init(width: 670, height: 192)
    /// width = 120 | height = 120
    static let productImage: CGSize = .init(width: 120, height: 120)
    
    func insideWidth(_ width: CGFloat) -> CGSize {
        return .init(width: width, height: floor(width * self.height / self.width))
    }
}
