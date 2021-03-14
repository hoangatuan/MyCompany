//
//  RestManager.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/10/20.
//

import Foundation

class RestManager {
    enum HttpMethod: String {
        case get
        case post
        case put
        case delete
    }
    
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    var session: NetworkSession
    var httpBody: Data?
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return url
            }
            
            var queryItems = [URLQueryItem]()
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) // " " = %20
                queryItems.append(item)
            }
            
            urlComponents.queryItems = queryItems
            guard let updatedURL = urlComponents.url else {
                return url
            }
            
            return updatedURL
        }
        
        return url
    }
    
    private func getHttpBody() -> Data? {
        if httpBodyParameters.allValues().isEmpty {
            return nil
        }
        
        guard let contentType = requestHttpHeaders.value(forkey: "Content-Type") else {
            return nil
        }
        
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys]) // Convert to JSON
        } else if contentType.contains("application/x-www-form-urlencoded") {
            // Build query string: "firstname= &age ="
            let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }.joined(separator: "&")
            
            return bodyString.data(using: .utf8)
        } else {
            return httpBody
        }
    }
    
    private func prepareRequest(withURL url: URL, httpBody: Data?, httpMethod: HttpMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        request.httpBody = httpBody
        return request
    }
    
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HttpMethod,
                     completion: @escaping (Results) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let targetURL = self.addURLQueryParameters(toURL: url)
            let httpBody = self.getHttpBody()
            let request = self.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod)
            
            self.session.getData(urlRequest: request, completion: completion)
        }
    }
}

extension RestManager {
    // MARK: - Handle Request
    struct RestEntity {
        private var values: [String: String] = [:]
        
        mutating func add(value: String, forkey key: String) {
            values[key] = value
        }
        
        func value(forkey key: String) -> String? {
            return values[key]
        }
        
        func allValues() -> [String: String] {
            return values
        }
        
        func totalItems() -> Int {
            return values.count
        }
    }
    
    // MARK: - Handle Response
    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        var headers = RestEntity()
        
        init(fromURLResponse response: URLResponse?) {
            guard let response = response else {
                return
            }
            
            self.response = response
            httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
                for (key, value) in headerFields {
                    headers.add(value: "\(value)", forkey: "\(key)")
                }
            }
        }
    }
    
    struct Results {
        var data: Data?
        var response: Response?
        var error: Error?
        
        init(withData data: Data?, response: Response?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        init(withError error: Error) {
            self.error = error
        }
    }
}
