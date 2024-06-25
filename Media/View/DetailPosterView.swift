//
//  DetailPosterView.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import UIKit
import SnapKit
import Toast

class DetailPosterView: BaseView {
    lazy var titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        self.addSubview(label)
        return label
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = 200
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        self.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
