//
//  StoreProductsCell.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import Kingfisher
import SnapKit
import UIKit

class StoreProductsCell: UICollectionViewCell, CodeView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.size28)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
        
        contentView.backgroundColor = .digioWhite
        contentView.layer.cornerRadius = CGFloat.size12
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.digioBlack.cgColor
        layer.shadowOpacity = .init(.alpha25)
        layer.shadowOffset = CGSize(width: .size2, height: .size2)
        layer.shadowRadius = .size4
        layer.masksToBounds = true
        clipsToBounds = false
    }
    
    func setup(with link: String) {
        guard let url = URL(string: link) else { return }
        imageView.kf.setImage(with: url)
    }
}
