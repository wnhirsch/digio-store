//
//  ReusableView.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}
