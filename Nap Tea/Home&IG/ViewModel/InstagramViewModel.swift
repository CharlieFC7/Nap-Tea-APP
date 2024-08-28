//
//  InstagramViewModel.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/23.
//

import Foundation
import SwiftUI

class InstagramViewModel: ObservableObject {
    
    
    @Published var igData = [InstagramInformation]()
    private let service: InstagramService
    
    init(service: InstagramService) {
        let igData = InstagramData.shared.igData
        self.igData = igData

        self.service = service
        
        Task { await fetchIgData() }
        
    }
    
    func fetchIgData() async {
        do{
            self.igData = try await service.fetchIgData()
        } catch {
            print("DEBUG: Failed to fetch isData with error: \(error.localizedDescription)")
        }
    }
    
}


class InstagramService {
    func fetchIgData() async throws -> [InstagramInformation] {
        return InstagramData.shared.igData
    }
}
