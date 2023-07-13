//
//  ViewModel.swift
//  SwiftUIAPICalls
//
//  Created by Kitwana Akil on 7/13/23.
//

import Foundation
import SwiftUI

struct Course: Hashable, Codable {
    var name: String
    let image: String
    
}

class ViewModel: ObservableObject {
    @Published var courses: [Course] = []
    
    func fetch() {
        
        //Get the data from the API
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            // Convert the JSON
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        
    }
}
