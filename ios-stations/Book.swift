//
//  Book.swift
//  ios-stations
//

struct Book: Decodable {
    let id: String
    let title: String
    let author: String
    let description: String
    let imageUrl: String?
}
