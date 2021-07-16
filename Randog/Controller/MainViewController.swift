//
//  MainViewController.swift
//  Randog
//
//  Created by xu daitong on 7/8/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breedChoice: String = "All"
    
    var breeds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
//        DogAPI.requestRandomImageAddress(completionHandler: fetchRandomImageAddress(imageData:error:))

    }
    override func viewWillAppear(_ animated: Bool) {
        DogAPI.requestBreeds(completionHandler: self.fetchBreeds(breedsList:error:))
    }
    
    
    func fetchRandomImageAddress(imageData: DogProtocol?, error: Error?) {
            
            print("test point 1")
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
    
    func fetchBreeds(breedsList: [String], error: Error?) {
        var sortedBreeds = breedsList.sorted()
        sortedBreeds.insert("All", at: 0)
        DispatchQueue.main.async {
            self.breeds = sortedBreeds
            self.pickerView.reloadAllComponents()
        }
    }
    @IBAction func refreshButtomPressed(_ sender: UIButton) {
        DogAPI.requestRandomImageAddress(breed: breedChoice,completionHandler: fetchRandomImageAddress(imageData:error:))
    }
}


extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(breeds)
        return breeds.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        breedChoice = breeds[row]
    }
    
    
    
    
    
}
