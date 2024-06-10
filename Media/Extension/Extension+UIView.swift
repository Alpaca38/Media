//
//  Extension+UIView.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
