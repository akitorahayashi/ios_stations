//
//  BookAPIClient.swift
//  ios-stations
//

import Alamofire

protocol BookAPIClientProtocol {
    func fetchBooks(offset: Int, completion: @escaping ([Book]?) -> Void)
}

class BookAPIClient: BookAPIClientProtocol {
    static let shared = BookAPIClient()
    // APIのエンドポイント
    private let baseURL = "https://railway.bookreview.techtrain.dev/public/books"
    
    
    func fetchBooks(offset: Int, completion: @escaping ([Book]?) -> Void) {
        AF.request(baseURL, method: .get)
                    .validate()
                    .responseDecodable(of: [Book].self) { response in
                        switch response.result {
                        case .success(let books):
                            completion(books)
                        case .failure(let error):
                            completion(nil)
                        }
                    }
    }
}
