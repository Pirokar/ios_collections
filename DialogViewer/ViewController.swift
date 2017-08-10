//
//  ViewController.swift
//  DialogViewer
//
//  Created by Vladimir Rybalka on 10/08/2017.
//  Copyright © 2017 Vladimir Rybalka. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var sections = [
        ["header": "Первая ведьма", "content": "Эй, встретимся позже, когда вас будет трое?"],
        ["header": "Вторая ведьма", "content": "Когда все тени удлинятся..."],
        ["header": "Третья ведьма", "content": "Тогда я приду перед закатом."],
        ["header": "Первая ведьма", "content": "Когда?"],
        ["header": "Вторая ведьма", "content": "Когда будет грязь"],
        ["header": "Третья ведьма", "content": "Думаю, тогда же мы увидим и Мак там"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(ContentCell.self, forCellWithReuseIdentifier: "CONTENT")
        collectionView!.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HEADER")
        
        var contentInset = collectionView!.contentInset
        contentInset.top = 20
        collectionView?.contentInset = contentInset
        
        let layout = collectionView?.collectionViewLayout
        let flow = layout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20)
        flow.headerReferenceSize = CGSize(width: 100, height: 25)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordsInSection(section: section).count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let words = wordsInSection(section: indexPath.section)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CONTENT", for: indexPath) as! ContentCell
        
        cell.maxWidth = collectionView.bounds.size.width
        cell.text = words[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(kind == UICollectionElementKindSectionHeader) {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HEADER", for: indexPath) as! HeaderCell
            cell.maxWidth = collectionView.bounds.size.width
            cell.text = sections[indexPath.section]["header"]
            
            return cell
        }
        abort()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let words = wordsInSection(section: indexPath.section)
        let size = ContentCell.sizeForContentString(s: words[indexPath.row], forMaxWidth: collectionView.bounds.size.width)
        
        return size
    }
    
    func wordsInSection(section: Int) -> [String] {
        let content = sections[section]["content"]
        let spaces = NSCharacterSet.whitespacesAndNewlines
        let words = content?.components(separatedBy: spaces)
        
        return words!
    }
}

