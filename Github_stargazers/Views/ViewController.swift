//
//  ViewController.swift
//  Github_stargazers
//
//  Created by Ana Cvasniuc on 24/03/25.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var repositoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gradientBackground()
    }
    
    func gradientBackground() {
        let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)  // Inizio dall'alto
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)    // Fine in basso
            
            view.layer.insertSublayer(gradientLayer, at: 0)
    }


    @IBAction func searchOwner(_ sender: UIButton) {
       
        guard let owner = ownerTextField.text, !owner.isEmpty,
        let repo = repositoryTextField.text, !repo.isEmpty else {
                showErrorAlert()
            return
        }
        
       if let vc = storyboard?.instantiateViewController(withIdentifier: "UsersTableView") as? UsersTableView{
            vc.owner = owner
            vc.repo = repo
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
                print("Errore: Identificatore dello storyboard non trovato!")
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Errore", message: "Inserisci Owner e Repository", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

