//
//  NewsService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import Foundation

final class NewsService: ServiceProtocol {
    static let shared = NewsService()
    
    func getListNews(at page: Int, type: NewType,
                     completion: @escaping ([New], Int) -> Void,
                     onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetNewsPerPage + "\(page)" + "&type=" + "\(type.rawValue)"
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func likeNew(newID: String,
                 onSuccess: @escaping (New) -> Void,
                 onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.LikeNewURL
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.httpBodyParameters.add(value: newID, forkey: "newID")
        rest.httpBodyParameters.add(value: UserDataDefaults.shared.employeeID, forkey: "employeeID")
        
        performRequest(rest: rest, url: url, httpMethod: .post, completion: onSuccess, onError: onError)
    }
    
    func dislikeNew(newID: String,
                    onSuccess: @escaping (New) -> Void,
                    onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.DislikeNewURL
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.httpBodyParameters.add(value: newID, forkey: "newID")
        rest.httpBodyParameters.add(value: UserDataDefaults.shared.employeeID, forkey: "employeeID")
        
        performRequest(rest: rest, url: url, httpMethod: .post, completion: onSuccess, onError: onError)
    }
    
    func searchViewByTitle(title: String, type: NewType,
                           completion: @escaping ([New], Int) -> Void,
                           onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.SearchNewByTitle + "\(title)" + "&type=" + "\(type.rawValue)"
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
}
