//
//  DetailPosterView.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import UIKit
import WebKit
import SnapKit
import Toast

final class DetailPosterView: UIView {
    var data: MovieVideos?
    private var includeWebView: Bool
    
    init(includeWebView: Bool) {
        self.includeWebView = includeWebView
        super.init(frame: .zero)
        setupSubview()
        configureLayout()
    }
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let webView = WKWebView()
    
    lazy var tableView = {
        let view = UITableView()
        view.backgroundColor = .backgroundColor
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        return view
    }()
    
    func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        if includeWebView {
            webView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(20)
                $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
                $0.height.equalTo(400)
            }
            
            tableView.snp.makeConstraints {
                $0.top.equalTo(webView.snp.bottom)
                $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            }
        } else {
            tableView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom)
                $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            }
        }
    }
    
    func setupSubview() {
        addSubview(titleLabel)
        if includeWebView {
            addSubview(webView)
        }
        addSubview(tableView)
    }
    
    func configureView(data: TrendingResult) {
        titleLabel.text = data.title
    }
    
    func configureTitleLabel() {
        titleLabel.text = "영화 둘러보기"
    }
    
    func configureWebView() {
        guard let data, let key = data.results.first?.key, let url = URL(string: "https://www.youtube.com/watch?v=\(key)") else { return }
        webView.load(URLRequest(url: url))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
