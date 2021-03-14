//
//  NetworkSession.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/20/20.
//

import Foundation

protocol NetworkSession {
    func getData(urlRequest: URLRequest, completion: @escaping (RestManager.Results) -> Void)
}

extension URLSession: NetworkSession {
    func getData(urlRequest: URLRequest, completion: @escaping (RestManager.Results) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            let result = RestManager.Results(withData: data,
                                             response: RestManager.Response(fromURLResponse: response),
                                             error: error)
            completion(result)
        })
        
        task.resume()
    }
}

class MockSession: NetworkSession {
    var result: RestManager.Results

    init(result: RestManager.Results) {
        self.result = result
    }
    
    func getData(urlRequest: URLRequest, completion: @escaping (RestManager.Results) -> Void) {
        completion(result)
    }
}
