//
//  HomeViewController.swift
//  Instagram
//
//  Created by Paratthakorn Sribunyong on 30/12/2563 BE.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {

    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self,forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier )
        tableView.register(IGFeedPostHeaderTableViewCell.self,forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier )
        tableView.register(IGFeedPostGeneralTableViewCell.self,forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier )
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        handleNotAuthenticated()
        do {
          try Auth.auth().signOut()
        }
        catch {
            print("Failed ot sign out")
        }
        
    }
    
    private func handleNotAuthenticated() {
        // Check auth status
        if Auth.auth().currentUser == nil {
            // Show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            
        }
    }
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
}
