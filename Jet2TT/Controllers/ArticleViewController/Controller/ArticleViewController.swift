//
//  ViewController.swift
//  Jet2TT
//
//  Created by Subhash Kumar on 5/8/20.
//  Copyright © 2020 Subhash Kumar. All rights reserved.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class ArticleViewController: BaseViewController {
    
    
    // MARK: Variables
    lazy var viewModel: ArticleViewModel = {
        let obj = ArticleViewModel(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    @IBOutlet weak var lblForPages: UILabel!
    let spinner = UIActivityIndicatorView()
    @IBOutlet weak var tblView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Spinner Function
        self.spinnerFunction()
        lblForPages.isHidden = true
        //Closure Setup:--
        self.setupClosures()
        //Api Calling :--
        viewModel.getArticals()
    }
    func spinnerFunction(){
        spinner.style = .medium
        spinner.color = .darkGray
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblView.bounds.width, height: CGFloat(40))
        spinner.tintColor = .darkGray
        tblView.tableFooterView = spinner
        tblView.tableFooterView?.isHidden = true
        
    }
    // MARK: Setup
    func setupClosures() {
        viewModel.redirectControllerClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
                self?.spinner.stopAnimating()
                self?.tblView.tableFooterView?.isHidden = true
                //self?.movetoDashbaord(animation: true)
            }
        }
    }
}

@available(iOS 13.0, *)
extension ArticleViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrForArticles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: ArticleCell.className, for: indexPath) as! ArticleCell
        if let articles = viewModel.arrForArticles?[indexPath.row]{
            if let userValue = articles.user,userValue.count > 0{
                cell.imageForUser.setShowActivityIndicator(true)
                cell.imageForUser.setIndicatorStyle(.medium)
                cell.imageForUser.sd_setImage(with: URL(string: userValue[0].avatar ?? ""), placeholderImage: UIImage(named: ""))
                cell.lblForUsername.text = "\(userValue[0].name ?? "") \(userValue[0].lastname ?? "")"
                cell.lblForDesignation.text = userValue[0].designation ?? ""
                
                if  let isoDate = userValue[0].createdAt{
                    let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    let date = dateFormatter.date(from: isoDate)!
                  
                    if let time = Date().offset(from:date) as? String {
                        cell.lblForPostTime.text = time
                    }
                }
                lblForPages.isHidden = false
                lblForPages.text = "\(Int(indexPath.row / 10) + 1) Page"

            }
            if let media = articles.media, media.count > 0 {
                if let image = media[0].image {
                    cell.imageForArticle.setShowActivityIndicator(true)
                    cell.imageForArticle.setIndicatorStyle(.medium)
                    cell.imageForArticle.sd_setImage(with: URL(string:image), placeholderImage: UIImage(named: ""))
                    cell.constraintsForArticleImageHeight.constant = 133
                }else{
                    cell.constraintsForArticleImageHeight.constant = 0
                }
            }
            
            
            cell.lblForArticleDescription.text = articles.content ?? ""
            cell.lblForLikeCount.text = "\(articles.likes ?? 0) \(articles.likes == 1 ? "Like" : "Likes")"
            cell.lblForCommentCount.text = "\(articles.comments ?? 0) \(articles.comments == 1 ? "omment" : "omments")"
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.arrForArticles?.count ?? 0) - 1  {
            if viewModel.isMoreData == true {
                spinner.startAnimating()
                self.tblView.tableFooterView?.isHidden = false
              //  self.tblView.tableFooterView = spinner
                self.perform(#selector(self.loadMore), with: nil, afterDelay: 1.0)
            }
        }
        //spinner.stopAnimating()
    }
    @objc func loadMore(){
        viewModel.page += 1
         viewModel.getArticals()
    }
    
}
//MARK : UITableViewCell Class:--

class ArticleCell: UITableViewCell {
    @IBOutlet weak var imageForUser:UIImageView!
    @IBOutlet weak var imageForArticle:UIImageView!
    
    @IBOutlet weak var lblForUsername:UILabel!
    @IBOutlet weak var lblForDesignation:UILabel!
    @IBOutlet weak var lblForPostTime:UILabel!
    @IBOutlet weak var lblForArticleDescription:UILabel!
    @IBOutlet weak var lblForLikeCount:UILabel!
    @IBOutlet weak var lblForCommentCount:UILabel!
    @IBOutlet weak var constraintsForArticleImageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
