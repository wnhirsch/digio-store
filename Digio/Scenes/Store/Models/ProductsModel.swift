//
//  ProductsModel.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import Foundation

struct ProductsModel: Codable {
    let spotlight: [SpotlightItem]
    let products: [ProductModel]
    let cash: CashModel
}

// MARK: - Spotlight Item Model

struct SpotlightItem: Codable {
    let name: String
    let bannerURL: String
    let description: String
}

// MARK: - Product Model

struct ProductModel: Codable {
    let name: String
    let imageURL: String
    let description: String
}

// MARK: - Cash Model

struct CashModel: Codable {
    let title: String
    let bannerURL: String
    let description: String
}
