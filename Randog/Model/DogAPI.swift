//
//  DogAPI.swift
//  Randog
//
//  Created by xu daitong on 7/8/21.
//

import UIKit


class DogAPI {
    enum Endpoint {
        
        case randomDogImageFromAll
        case randomImageFromBreed (String)
        case breedsOfDog
        
    
        var url: URL{
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String{
            switch self {
            
            case .randomDogImageFromAll:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageFromBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .breedsOfDog:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    class func requestRandomImageAddress(breed: String,completionHandler: @escaping(DogProtocol?, Error?) -> Void){
        print("test point 2")
        var randomImageEndPoint = Endpoint.randomDogImageFromAll.url
        if breed != "All" {
            randomImageEndPoint = Endpoint.randomImageFromBreed(breed).url
        }

        print(" test point (3)")
        print(randomImageEndPoint)
        let task = URLSession.shared.dataTask(with: randomImageEndPoint) { data, response, error in
            guard let data = data else{
                completionHandler(nil,error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogProtocol.self, from: data)
            print(imageData.status)
            completionHandler(imageData, nil)
            print("testpoint 5")
    }
        task.resume()
    }
    
    
    // pass in the url, and then request image from url link
    class func requestImage(url: URL, completionHandler: @escaping(UIImage?, Error?) -> Void){
        print("testpoint 4")
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
    class func requestBreeds(completionHandler: @escaping([String], Error?) -> Void){
        let breedsURL = Endpoint.breedsOfDog.url
        let task = URLSession.shared.dataTask(with: breedsURL) { data, response, error in
            guard let data = data else{
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsData = try! decoder.decode(BreedsListProtocol.self, from: data)
            let breedsList = breedsData.message.keys.map({$0})
            completionHandler(breedsList, nil)
            
        }
        task.resume()
    }
    
    
    
    
}
