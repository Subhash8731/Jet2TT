

import Foundation
import UIKit

protocol UserServiceProtocol {
   func getArticles(with viewModel:BaseViewModel?,page:Int,limit:Int, completion:@escaping (Any?) -> Void)
   
}

public class UserService: APIService, UserServiceProtocol {
    
    func getArticles(with viewModel:BaseViewModel?,page:Int,limit:Int, completion:@escaping (Any?) -> Void){
       // viewModel?.isLoading = true
        let path = "page=\(page)&limit=\(limit)"
        let param = [:] as [String: Any]
       // let param = ["page":page,"limit":limit] as [String: Any]
        super.startService(with: .get, path: path, maptype: false, parameters: param, files: []) { (result) in
            DispatchQueue.main.async {
                viewModel?.isLoading = false
                switch result {
                case .Success(let data):
                    if let response = data as? Array<Dictionary<String,Any>> {
                        let arrForVitals = Articles.modelsFromDictionaryArray(array: response)
                        completion(arrForVitals)
                    }
                case . Error(let message):
                    viewModel?.isSuccess = false
                    viewModel?.errorMessage = message
                    completion(nil)
                }
            }
        }
    }
}

