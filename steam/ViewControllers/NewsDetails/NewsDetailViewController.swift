//
//  NewsDetailViewController.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 21.09.22.
//

import Foundation
import UIKit

class NewsDetailViewController: NiblessViewController {
    
    private var newsDetailView = NewsDetailView()
    
    override func loadView() {
        view = newsDetailView
    }
    

}
