//
//  DetailViewController.swift
//  ImageLoadingProject
//
//  Created by Albert Ahmadiev on 26.11.2020.
//

import UIKit

class DetailViewController: UIViewController, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let imageView = UIImageView(frame: self.imageViewFrame())
                        imageView.image = image
                        imageView.contentMode = .scaleAspectFit
                        imageView.clipsToBounds = true
                        self.sv.addSubview(imageView)
                        self.progressView.isHidden = true
                    }
                } else {
                    fatalError("Cannot load the image")
                }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            DispatchQueue.main.async {
                self.progressView.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            }
    }
    
    var imageURL: URL?
    
    @IBOutlet weak var sv: UIScrollView!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    private func imageViewFrame() -> CGRect {
        view.bounds.inset(by: UIEdgeInsets(top: view.layoutMargins.top, left: 0, bottom: view.layoutMargins.bottom, right: 0))
    }
    
    private func loadImage(){
        guard let url = imageURL else { return }

        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue())
                
        session.downloadTask(with: url).resume()
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
