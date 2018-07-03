//
//  AppDelegate.swift
//  swiftyJoe
//
//  Created by Joe Malysz on 1/10/17.
//  Copyright © 2017 JMalysz. All rights reserved.
//

import UIKit
import Mixpanel
import mParticle_Apple_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // INITIALIZE MIXPANEL AND IDENTIFY BY DISTINCT_ID
        
        Mixpanel.initialize(token:"d58acaea9e48a1728aa6ad5618402842");
        
        //declare Tweaks
        let allTweaks: [TweakClusterType] =
            [MixpanelTweaks.floatTweak,
             MixpanelTweaks.intTweak,
             MixpanelTweaks.boolTweak,
             MixpanelTweaks.stringTweak]
        MixpanelTweaks.setTweaks(tweaks: allTweaks)
        let mixpanel = Mixpanel.mainInstance()
        mixpanel.identify(distinctId: mixpanel.distinctId)
        
        // INITIALIZE MPARTICLE
        let mParticleOptions = MParticleOptions(key: "8773e49bf04b424796bfc631a465e6bd", secret: "z2WYKF7FhmZGogh-q6jw_hXi4iEyWn8jQGenwaBEbfQwmroZkahlVYh-NXDit-Dt")
        
        //CREATE IDENTITY OBJECT
        let request = MPIdentityApiRequest()
        request.email = "email@example.com"
        mParticleOptions.identifyRequest = request
        mParticleOptions.onIdentifyComplete = { (apiResult, error) in
            NSLog("Identify complete. userId = %@ error = %@", apiResult?.user.userId.stringValue ?? "Null User ID", error?.localizedDescription ?? "No Error Available")
        }
        
        //Start the SDK
        MParticle.sharedInstance().start(with: mParticleOptions)
        let identityRequest = MPIdentityApiRequest.withEmptyUser()
        //the MPIdentityApiRequest provides convenience methods for common identity types
        identityRequest.email = mixpanel.distinctId
        identityRequest.customerId = mixpanel.distinctId
        //alternatively, you can use the setUserIdentity method and supply the MPUserIdentity type
        identityRequest.setUserIdentity(mixpanel.distinctId, identityType: MPUserIdentity.other)
        MParticle.sharedInstance().identity.identify(identityRequest, completion: {(apiResult, error) -> Void in
            if ((error) != nil) {
                //retry the request or otherwise handle the error, see below
            } else {
                //Continue with login, and you can also access the new/updated user:
                var user = apiResult?.user
            }
        })
        MParticle.sharedInstance().logEvent("Food order", eventType: MPEventType.transaction, eventInfo: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
extension MixpanelTweaks {
    public static let floatTweak =
        Tweak(tweakName: "floatTweak",
              defaultValue: 20.5, min: 0, max: 30.1)
    public static let intTweak =
        Tweak(tweakName: "intTweak",
              defaultValue: 10, min: 0)
    public static let boolTweak =
        Tweak(tweakName: "boolTweak",
              defaultValue: true)
    public static let stringTweak =
        Tweak(tweakName: "stringTweak",
              defaultValue: "hello")
}
