//
//  ItemDataLoader.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 06/12/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import Foundation
import UIKit

protocol ItemDataLoader {
    func loadData(callback: @escaping ([ListItem]) -> Void, onError: @escaping (String) -> Void)
    func loadImage(of item: ListItem, callback: @escaping (UIImage) -> Void)
}

class LocalDataLoader: ItemDataLoader {
    let bundle: Bundle
    let jsonDecoder: JSONDecoder
    init(mainBundle: Bundle) {
        self.bundle = mainBundle
        self.jsonDecoder = JSONDecoder()
    }
    
    func loadData(callback: @escaping ([ListItem]) -> Void, onError: @escaping (String) -> Void) {
        DispatchQueue.global().async { [self] in
            var errorMessage: String? = nil
            var result: [ListItem]? = nil
            
            if let url = self.bundle.url(forResource: "listItems", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    result = try self.jsonDecoder.decode(Array<ListItem>.self, from: data)
                } catch {
                    errorMessage = "Error converting data"
                }
            }
            else {
                errorMessage = "Error reading data"
            }
            
            DispatchQueue.main.async {
                if let res = result {
                    callback(res)
                }
                else {
                    onError(errorMessage ?? "Unknown error")
                }
            }
        }
    }
    
    func loadImage(of item: ListItem, callback: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            if let image = UIImage(named: item.imageSrc) {
                DispatchQueue.main.async {
                    callback(image)
                }
            }
        }
    }
}

class NetworkDataLoader: ItemDataLoader {
    let jsonDecoder: JSONDecoder = JSONDecoder()
    
    func loadData(callback: @escaping ([ListItem]) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: "http://192.168.1.158/thesis/listItems.json") else {
            onError("Error creating url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: [ListItem]? = nil
            var errorMessage = error?.localizedDescription
            if (errorMessage == nil) {
                do {
                    result = try self.jsonDecoder.decode(Array<ListItem>.self, from: data!)
                } catch {
                    errorMessage = "Error converting data"
                }
            }
            
            DispatchQueue.main.async {
                if let res = result {
                    callback(res)
                }
                else {
                    onError(errorMessage ?? "Unknown error")
                }
            }
        }.resume()
    }
    
    func loadImage(of item: ListItem, callback: @escaping (UIImage) -> Void) {
        guard let url = URL(string: item.imageSrc) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if data != nil, let image = UIImage(data: data!) {
                DispatchQueue.main.async {
                    callback(image)
                }
            }
        }.resume()
    }
}
