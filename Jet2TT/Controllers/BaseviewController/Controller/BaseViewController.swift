

import UIKit
import NVActivityIndicatorView



class BaseViewController: UIViewController,NVActivityIndicatorViewable{

    let NAVIGATION_BACK_BUTTON = 1
    let NAVIGATION_SIGNOUT_BUTTON = 2

    var activityIndicatorView : NVActivityIndicatorView!
    let animationType:NVActivityIndicatorType = NVActivityIndicatorType.lineScale
    
    var isBackButtonHidden:Bool?
    var isLogoutButtonHidden:Bool?
    
    var baseVwModel: BaseViewModel? {
        didSet {
            initBaseModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    // Cann't be override by subclass
    final func initBaseModel() {
        
        // Native binding
        
        baseVwModel?.showAlertClosure = { [weak self] (_ type:AlertType) in
            DispatchQueue.main.async {
                if type == .success, let message = self?.baseVwModel?.alertMessage  {
                    let configAlert : AlertUI = ("", message)
                    UIAlertController.showAlert(configAlert)
                } else {
                    let message = self?.baseVwModel?.errorMessage ?? "Some Error occured"
                    let configAlert : AlertUI = ("", message)
                    UIAlertController.showAlert(configAlert)
                }
            }
        }
            
        baseVwModel?.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.baseVwModel?.isLoading ?? false
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
                 isLoading ? self?.showLoader() : self?.hideLoader()
            }
        }
    }
    
    //MARK:SHOW AND HIDE LOADER
    func showLoader() {
        startAnimating(CGSize(width: 60.0, height: 60.0), message: "", messageFont: nil, type: self.animationType, color: .darkGray , padding: 0.0, displayTimeThreshold: 0, minimumDisplayTime: nil, backgroundColor: .clear)
    }
    
    func hideLoader() {
        stopAnimating()
    }
}





