//
//  UsersTableView.swift
//  Github_stargazers
//
//  Created by Ana Cvasniuc on 24/03/25.
//

import UIKit
import Combine

class UsersTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var owner: String?
    var repo: String?
    
    private var cancellables = Set<AnyCancellable>()
    private var stargazersVM = StargazersViewModel()
    @Published var users: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBindings()
        
        // Registra la cella XIB
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        
        if let owner = owner, let repo = repo {
            stargazersVM.fetchStargazers(owner: owner, repo: repo)
        }
    }
    
    private func setupBindings() {
        stargazersVM.$stargazers
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.tableView.reloadData()
                }
                .store(in: &cancellables)
            
        stargazersVM.$errorMessage
                .receive(on: DispatchQueue.main)
                .sink { [weak self] message in
                    if let message = message {
                        self?.showErrorAlert(message)
                    }
                }
                .store(in: &cancellables)
    }
    
    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Errore", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stargazersVM.stargazers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        
        let stargazer = stargazersVM.stargazers[indexPath.row]
        cell.configure(with: stargazer.login, imageUrl: stargazer.avatar_url)
       
        return cell
    }
}

