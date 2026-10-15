//
//  AdMobInterstitialVideoAdapter.swift
//  MediationADOP
//
//  Created by Odin.송황호 on 4/29/24.
//

import UIKit

import APSSPSDK


final public class ADOPInterstitialVideoAdapter: APSSPInterstitialVideoAdapterProtocol {
   
    private var interstitialVideoAd: ADOPMediationInterstitialVideoAd?
    
    public weak var delegate: APSSPInterstitialVideoAdapterDelegate?
    
    public weak var rootViewController: UIViewController?
    
    deinit {
        APLogger.debug("ADOPInterstitialVideoAdapter deinit")
    }

    public init(placementDic: [String: String], rootViewController: UIViewController?, info: [String : Any?]) {
        let placementId = placementDic[APSSPPlacementKey.adUnitID.rawValue] ?? ""
        interstitialVideoAd = ADOPMediationInterstitialVideoAd(placementId: placementId)
        self.interstitialVideoAd?.delegate = self
    }
    
    public func present(from: UIViewController, completion: @escaping () -> Void) {
        interstitialVideoAd?.present(from: from) { completion() }
    }
    
    public func connectDelegate(delegate: APSSPInterstitialVideoAdapterDelegate) {
        self.delegate = delegate
        self.interstitialVideoAd?.load()
    }

    public func disconnectDelegate() {
        interstitialVideoAd?.delegate = nil
        delegate = nil
    }
}


extension ADOPInterstitialVideoAdapter: APSSPInterstitialVideoAdapterDelegate {
    
    public func interstitialVideoLoadSuccess() {
        delegate?.interstitialVideoLoadSuccess()
    }
    
    public func interstitialVideoLoadFail(error: APSSPNetworkError, errorMessage: String?) {
        delegate?.interstitialVideoLoadFail(error: error, errorMessage: errorMessage)
    }
    
    public func interstitialVideoShowSuccess(message: String) {
        delegate?.interstitialVideoShowSuccess(message: message)
    }
    
    public func interstitialVideoShowFail(message: String) {
        delegate?.interstitialVideoShowFail(message: message)
    }
    
    public func interstitialVideoClicked(message: String) {
        delegate?.interstitialVideoClicked(message: message)
    }
    
    public func interstitialVideoClosed(message: String) {
        delegate?.interstitialVideoClosed(message: message)
    }
}
