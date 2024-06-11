//
//  ReuseIdentifier.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit

protocol ReuseIdentifier: AnyObject {
    static var identifier: String { get }
}

extension UIViewController: ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
