//
//  MainViewController.swift
//  Randog
//
//  Created by xu daitong on 7/8/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DogAPI.requestRandomImageAddress(completionHandler: fetchRandomImageAddress(imageData:error:))
    }
    
    func fetchRandomImageAddress(imageData: DogProtocol?, error: Error?) {
    
            guard let imageURL = URL(string: imageData?.message ?? "") else{
                print("error: getting image URL" + "x1")
                return
            }
            DogAPI.requestImage(url: imageURL, completionHandler: self.fetchImage(image:error:))
        }
    
    func fetchImage(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    @IBAction func refreshButtomPressed(_ sender: UIButton) {
        DogAPI.requestRandomImageAddress(completionHandler: fetchRandomImageAddress(imageData:error:))
    }
    
    
}
