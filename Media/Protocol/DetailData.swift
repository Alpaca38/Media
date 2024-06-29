//
//  Identifier.swift
//  Media
//
//  Created by 조규연 on 6/29/24.
//

import Foundation

protocol DetailData {
    var identifier: Int { get }
    var path: String? { get }
    var title: String { get }
    var overView: String { get }
}
