//
//  StargazersViewModel.swift
//  Github_stargazers
//
//  Created by Ana Cvasniuc on 24/03/25.
//

import UIKit
import Combine

class StargazersViewModel {
    @Published var errorMessage: String?
    @Published var stargazers: [User] = []
    @Published var cancellables = Set<AnyCancellable>()
    
    func fetchStargazers(owner: String, repo: String) {
        
        
        guard let url = URL(string: "https://api.github.com/repos/\(owner)/\(repo)/stargazers")
            else {
                errorMessage = "URL non valido"
            return
        }
            
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
    
                if case .failure(let error) = completion {
                    self?.errorMessage = "Errore nel caricamento: \(error.localizedDescription)" }
                }, receiveValue: { [weak self] stargazers in
                    self?.stargazers = stargazers
                })
                .store(in: &cancellables)
    }
}
