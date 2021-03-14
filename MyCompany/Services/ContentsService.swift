//
//  ContentsService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/25/20.
//

import Foundation

enum RequestError: String, Error {
    case wrongURL = "Wrong URL. Please try again later"
    case decodeFail = "Decode Failed. Please try again later"
    case serverFail = "Server doesn't response. Please try again later"
    case connectToServerFailed = "Can not connect to server. Please check internet connection"
}

final class ContentsService: ServiceProtocol {
    static let shared = ContentsService()
    
    func getNewContent(newID: String,
                       completion: @escaping (NewContent) -> Void,
                       onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetContentOfNew + newID
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func postNewComment(newID: String,
                        comment: String,
                        completion: @escaping (Comment) -> Void,
                        onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.PostCommentURL
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.httpBodyParameters.add(value: newID, forkey: "newID")
        rest.httpBodyParameters.add(value: UserDataDefaults.shared.employeeID, forkey: "employeeID")
        rest.httpBodyParameters.add(value: comment, forkey: "comment")
        
        let createDate = Date().timeIntervalSince1970.description
        rest.httpBodyParameters.add(value: createDate, forkey: "createDate")
        performRequest(rest: rest, url: url, httpMethod: .post, completion: completion, onError: onError)
    }
}
