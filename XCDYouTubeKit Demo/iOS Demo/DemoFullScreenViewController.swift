//
//  DemoFullScreenViewController.swift
//  XCDYouTubeKit iOS Demo
//
//  Created by Soneé John on 10/17/19.
//  Copyright © 2019 Cédric Luthi. All rights reserved.
//

import UIKit
import AVKit
import XCDYouTubeKit

extension String {
	var youtubeID: String? {
		let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

		let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
		let range = NSRange(location: 0, length: count)

		guard let result = regex?.firstMatch(in: self, range: range) else {
			return nil
		}

		return (self as NSString).substring(with: result.range)
	}
}

extension DemoFullScreenViewController: VideoPickerControllerDelegate {
	func videoPickerController(_ videoPickerController: VideoPickerController!, didSelectVideoWithIdentifier videoIdentifier: String!) {
		self.videoIdentifierTextField.text = videoIdentifier
		UserDefaults.standard.set(videoIdentifier, forKey: "VideoIdentifier")
	}
}

extension DemoFullScreenViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.loadAndPlay(textField)
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		UserDefaults.standard.set(self.videoIdentifierTextField.text, forKey: "VideoIdentifier")
	}
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		UserDefaults.standard.set(0, forKey: "CurrentPlayback")
		return true
	}
	
}

class DemoFullScreenViewController: UIViewController {
	
    @IBOutlet weak open var lowQualitySwitch: UISwitch!
    @IBOutlet weak open var videoIdentifierTextField: UITextField!
	@IBOutlet weak open var timeTextField: UITextField!
	var ob: NSKeyValueObservation?
	private var timeObserverToken: Any?
	
	var timer: RepeatingTimer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.videoIdentifierTextField.text = UserDefaults.standard.string(forKey: "VideoIdentifier")
		self.timeTextField.text = "\(UserDefaults.standard.double(forKey: "CurrentPlayback"))"
	}
    
	@IBAction open func endEditing(_ sender: Any!) {
		self.view.endEditing(true)
	}
	
	@IBAction open func loadAndPlay(_ sender: Any!) {
		guard let youtubeId = self.videoIdentifierTextField.text?.youtubeID else { return }
		XCDYouTubeClient.default().getVideoWithIdentifier(youtubeId) { (video, error) in
			guard error == nil else {
				Utilities.shared.displayError(error! as NSError, originViewController: self)
				return
			}
			AVPlayerViewControllerManager.shared.lowQualityMode = self.lowQualitySwitch.isOn
			AVPlayerViewControllerManager.shared.video = video
			if let currentTime = UserDefaults.standard.double(forKey: "CurrentPlayback") as? Double {
				self.seek(to: currentTime - 10)
			}
			AVPlayerViewControllerManager.shared.controller.player?.play()
		}
	}
	
	@IBAction open func play() {
		AVPlayerViewControllerManager.shared.controller.player?.play()
	}
	
	@IBAction open func seek(_ sender: Any!) {
		if let durationString = timeTextField.text, let duration = Double(durationString) {
			seek(to: duration)
		}
	}
	
	func seek(to time: Double) {
		let durationAsTime = CMTime(seconds: time, preferredTimescale: 1)
		AVPlayerViewControllerManager.shared.controller.player?.seek(to: durationAsTime)
	}
	
	@IBAction open func timer(_ sender: Any!) {
		if timer == nil {
			timer = RepeatingTimer(timeInterval: 30)
			timer?.eventHandler = { [weak self] in
				AVPlayerViewControllerManager.shared.controller.player?.pause()
				self?.cancelTimer()
			}
			timer?.resume()
			showSimpleAlert("Bật hẹn giờ")
		} else {
			cancelTimer()
		}
	}
	
	func cancelTimer(){
		timer?.suspend()
		timer = nil
		showSimpleAlert("Tắt hẹn giờ")
	}
	
	func showSimpleAlert(_ onTimer: String) {
		let alert = UIAlertController(title: nil, message: onTimer, preferredStyle: UIAlertController.Style.alert)

		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
				//Cancel Action
			}))

		self.present(alert, animated: true, completion: nil)
	}
}
