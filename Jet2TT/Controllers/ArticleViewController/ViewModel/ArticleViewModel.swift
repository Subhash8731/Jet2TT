//
//  ArticleViewModel.swift
//  Jet2TT
//
//  Created by Subhash Kumar on 5/8/20.
//  Copyright © 2020 Subhash Kumar. All rights reserved.
//

import UIKit

class ArticleViewModel: BaseViewModel {
    var userService: UserServiceProtocol
     let refreshControl = UIRefreshControl()
    var page = 1
    var limit = 10
    var arrForArticles : [Articles]?
    var isMoreData:Bool = false
    var isRefreshing:Bool = false
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    
    func getArticals() {
        if !self.checkReachability(){
            self.arrForArticles = CoreDataStackManager.sharedManager.getAllArticles()
                self.redirectControllerClosure?()
            return
        }
        if page == 1 && isRefreshing == false {
            self.isLoading = true
        }
        userService.getArticles(with: self, page: page, limit: limit, completion: { (result) in
            self.isLoading = false
            if let res = result as?  [Articles]{
                CoreDataStackManager.sharedManager.saveArticle(with: res)
//                for obj in res{
//                    obj.saveData()
//                }
                self.isRefreshing = false
                self.refreshControl.endRefreshing()
                if self.page == 1 {
                    self.arrForArticles = res
                }else{
                    self.arrForArticles?.append(contentsOf: res)
                }
                if res.count > 0 {
                    self.isMoreData = true
                    // self.pageIndex = self.pageIndex + 1
                }else{
                    self.isMoreData = false
                }
                
                self.redirectControllerClosure?()
            }
        })
    }
}
