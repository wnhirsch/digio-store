//
//  StoreProductsHeader.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import SnapKit
import UIKit

class StoreProductsHeader: UIView, CodeView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "store.products".localized
        label.textColor = .digioPrimary
        label.textAlignment = .left
        label.font = .systemFont(ofSize: .size20, weight: .bold)
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
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size24)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .digioWhite
    }
}
