//
//  LoadingView.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import UIKit
import SnapKit

class LoadingView: UIView, CodeView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .digioPrimary
        activityIndicator.hidesWhenStopped = false
        return activityIndicator
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .digioPrimary
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: .size16)
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(activityIndicator)
        addSubview(messageLabel)
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(activityIndicator.snp.bottom).inset(CGFloat.size16)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size16)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
    
    func setup(message: String?) {
        messageLabel.text = message
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
