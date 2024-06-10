//
//  Extension+UIViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit

extension UIViewController {    
    func setNavigationBar(tintColor: UIColor, title: String?) {
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
    }
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }
}
