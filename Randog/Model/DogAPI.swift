//
//  DogAPI.swift
//  Randog
//
//  Created by xu daitong on 7/8/21.
//

import UIKit


class DogAPI {
    enum Endpoint: String {
        case randomDogImage = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL{
            return URL(string: self.rawValue)!
        }
    }
    class func requestRandomImageAddress(completionHandler: @escaping(DogProtocol?, Error?) -> Void){
        let randomImageEndpoint = Endpoint.randomDogImage.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { data, response, error in
            guard let data = data else{
                completionHandler(nil,error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogProtocol.self, from: data)
            completionHandler(imageData, nil)
    }
        task.resume()
    }
    
    
    
    // pass in the url, and then request image from url link
    class func requestImage(url: URL, completionHandler: @escaping(UIImage?, Error?) -> Void){
        let task = URLSession.shared.downloadTask(with: url) { url, response, error in
            guard let url = url else{
                print(error!.localizedDescription + "x2")
                return
            }
            let urlData = try! Data(contentsOf: url)
            let image = UIImage(data: urlData)
            completionHandler(image,nil)
        }
        task.resume()
    }
}
