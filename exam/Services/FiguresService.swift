//
//  FiguresService.swift
//  exam
//
//  Created by Moises Lugo on 16/02/22.
//

import Foundation


protocol FiguresServiceProtocol {
    func getFigures(completion: @escaping (_ success: Bool, _ results: MarvelFigures?, _ error: String?) -> ())
}

class FiguresService: FiguresServiceProtocol {
    func getFigures(completion: @escaping (Bool, MarvelFigures?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://gateway.marvel.com:443/v1/public/characters?apikey=ce8544d03f56de188782fd696c81b02e751c958f&hash=e42ddc85b41c95895af900f8c98d7d0b", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(MarvelFigures.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Firgures to model")
                }
            } else {
                completion(false, nil, "Error: Figures GET Request failed")
            }
        }
    }
}
