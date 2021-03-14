//
//  ContentBottomViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/27/20.
//

import Foundation

final class ContentBottomViewModel: ObservableObject {
    @Published var onPostCommentFailed: Bool = false
    @Published var onLikeFailed: Bool = false
    @Published var new: New = New(newID: "", title: "", imageURL: "", createDate: 0, type: 0, likes: [], dislikes: [], comments: 0)

    var messageError: String = ""
    
    func postNewComment(of newID: String,
                        comment: String,
                        onSuccess: @escaping(Comment) -> Void) {
        ContentsService.shared.postNewComment(newID: newID, comment: comment,
                                              completion: { comment in
                                                onSuccess(comment)
                                              },
                                              onError: { [weak self] error in
                                                self?.onPostCommentFailed = true
                                                self?.messageError = error.rawValue
                                              })
    }
    
    func likeNew(of newID: String) {
        NewsService.shared.likeNew(newID: newID, onSuccess: { [weak self] new in
            self?.new = new
        }, onError: { [weak self] error in
            self?.onLikeFailed = true
            self?.messageError = error.rawValue
        })
    }
    
    func dislikeNew(of newID: String) {
        NewsService.shared.dislikeNew(newID: newID, onSuccess: { [weak self] new in
            self?.new = new
        }, onError: { [weak self] error in
            self?.onLikeFailed = true
            self?.messageError = error.rawValue
        })
    }
    
    func didReaction(reactionsArray: [String]) -> Bool {
        return reactionsArray.contains(UserDataDefaults.shared.employeeID)
    }
}
