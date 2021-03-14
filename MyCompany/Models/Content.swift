//
//  Content.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/25/20.
//

import Foundation

final class Content: Codable, Identifiable {
    let id: String
    let content: String
    let font: String
    let size: Double
    let imageURL: String
}
