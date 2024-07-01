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

extension ReuseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: ReuseIdentifier { }
