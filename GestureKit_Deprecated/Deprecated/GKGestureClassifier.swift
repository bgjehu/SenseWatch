//
//  GKGestureClassifier.swift
//  Slider
//
//  Created by Jieyi Hu on 7/11/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import CoreMotion

typealias GKGestureClassifier = (CMAccelerometerData? -> GKGesture?)

class GKPredefinedGestureClassifier : NSObject {
    
    static var simpleTree : GKGestureClassifier {
        get{
            func simpleTree (data : CMAccelerometerData?) -> GKGesture? {
                if data != nil {
                    let x = data!.acceleration.x
                    let y = data!.acceleration.y
                    let z = data!.acceleration.z
                    if sqrt(x*x+y*y+z*z) > 1.35 {
                        
                        if z > y {
                            return GKGesture.Up
                        } else {
                            return GKGesture.Down
                        }
                        
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            }
            return simpleTree
        }
    }
    static var BFTree : GKGestureClassifier {
        get{
            func BFTree (data : CMAccelerometerData?) -> GKGesture? {
                if data != nil {
                    let x = data!.acceleration.x
                    let y = data!.acceleration.y
                    let z = data!.acceleration.z
                    if z < 0.97699 {
                        if x < 0.36092 {
                            if y < 1.12199 {
                                if z < -1.17988 {
                                    if z < -1.3504 { return GKGesture.Up }
                                    else {
                                        if x < -0.5845 { return GKGesture.Down }
                                        else {
                                            if y < 0.58597 { return nil }
                                            else {
                                                if x < -0.12019 { return GKGesture.Down }
                                                else {
                                                    if y < 0.84068 { return nil }
                                                    else { return GKGesture.Down }
                                                }
                                            }
                                        }
                                    }
                                }
                                else { return nil }
                            }
                            else {
                                if y < 1.27129 {
                                    if z < -0.65485 {
                                        if z < -1.13125 {
                                            if y < 1.20909 { return GKGesture.Down }
                                            else { return GKGesture.Push }
                                        }
                                        else {
                                            if x < -0.04532 { return GKGesture.Right }
                                            else {
                                                if y < 1.13115 { return nil }
                                                else {
                                                    if y < 1.2105 { return GKGesture.Left }
                                                    else { return GKGesture.Right }
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        if z < 0.24551 {
                                            if x < -0.32903 {
                                                if z < -0.17168 {
                                                    if y < 1.16788 {
                                                        if y < 1.14905 { return GKGesture.Right }
                                                        else {
                                                            if y < 1.15447 { return nil }
                                                            else { return GKGesture.Right }
                                                        }
                                                    }
                                                    else {
                                                        if x < -0.7951 { return GKGesture.Left }
                                                        else {
                                                            if z < -0.23331 {
                                                                if y < 1.17799 {
                                                                    if y < 1.17477 { return GKGesture.Up }
                                                                    else { return nil }
                                                                }
                                                                else {
                                                                    if x < -0.4697 { return GKGesture.Up }
                                                                    else { return GKGesture.Up }
                                                                }
                                                            }
                                                            else { return GKGesture.Right }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if x < -0.61252 { return GKGesture.Left }
                                                    else {
                                                        if x < -0.42981 {
                                                            if y < 1.1665 { return nil }
                                                            else { return GKGesture.Right }
                                                        }
                                                        else {
                                                            if x < -0.35282 { return nil }
                                                            else { return nil }
                                                        }
                                                    }
                                                }
                                            }
                                            else {
                                                if x < 0.11771 {
                                                    if x < -0.15137 {
                                                        if x < -0.17156 {
                                                            if z < -0.35963 {
                                                                if x < -0.27173 { return nil }
                                                                else { return GKGesture.Right }
                                                            }
                                                            else {
                                                                if z < 0.1415 {
                                                                    if z < -0.17651 {
                                                                        if z < -0.20882 {
                                                                            if x < -0.2511 { return nil }
                                                                            else { return nil }
                                                                        }
                                                                        else { return GKGesture.Right }
                                                                    }
                                                                    else {
                                                                        if z < 0.03275 { return nil }
                                                                        else { return nil }
                                                                    }
                                                                }
                                                                else {
                                                                    if x < -0.28007 { return nil }
                                                                    else { return GKGesture.Left }
                                                                }
                                                            }
                                                        }
                                                        else { return GKGesture.Right }
                                                    }
                                                    else {
                                                        if z < -0.57392 { return nil }
                                                        else { return nil }
                                                    }
                                                }
                                                else {
                                                    if z < -0.10616 {
                                                        if z < -0.59859 { return nil }
                                                        else {
                                                            if x < 0.23186 {
                                                                if z < -0.30422 { return GKGesture.Left }
                                                                else { return nil }
                                                            }
                                                            else { return nil }
                                                        }
                                                    }
                                                    else { return GKGesture.Right }
                                                }
                                            }
                                        }
                                        else {
                                            if z < 0.56415 {
                                                if x < -0.40765 { return nil }
                                                else {
                                                    if y < 1.24315 {
                                                        if z < 0.38732 {
                                                            if y < 1.14531 { return GKGesture.Left }
                                                            else {
                                                                if x < -0.28086 {
                                                                    if y < 1.15825 { return nil }
                                                                    else { return GKGesture.Left }
                                                                }
                                                                else { return nil }
                                                            }
                                                        }
                                                        else { return GKGesture.Left }
                                                    }
                                                    else { return nil }
                                                }
                                            }
                                            else {
                                                if z < 0.5764 { return GKGesture.Up }
                                                else {
                                                    if z < 0.91422 {
                                                        if x < -0.47977 {
                                                            if y < 1.21529 { return GKGesture.Right }
                                                            else { return GKGesture.Left }
                                                        }
                                                        else {
                                                            if z < 0.62815 {
                                                                if x < -0.24159 { return GKGesture.Left }
                                                                else { return GKGesture.Right }
                                                            }
                                                            else {
                                                                if x < -0.31818 { return GKGesture.Left }
                                                                else { return GKGesture.Up }
                                                            }
                                                        }
                                                    }
                                                    else { return GKGesture.Right }
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if x < -0.20778 {
                                        if y < 1.40608 {
                                            if z < -0.15945 {
                                                if z < -0.71056 {
                                                    if z < -0.8315 {
                                                        if x < -0.64491 { return GKGesture.Right }
                                                        else { return GKGesture.Up }
                                                    }
                                                    else { return GKGesture.Right }
                                                }
                                                else {
                                                    if x < -0.26844 {
                                                        if y < 1.38731 { return GKGesture.Up }
                                                        else { return nil }
                                                    }
                                                    else {
                                                        if y < 1.32018 { return nil }
                                                        else { return GKGesture.Left }
                                                    }
                                                }
                                            }
                                            else {
                                                if x < -0.69316 { return GKGesture.Left }
                                                else {
                                                    if z < 0.4767 {
                                                        if y < 1.28436 { return GKGesture.Left }
                                                        else { return nil }
                                                    }
                                                    else { return GKGesture.Right }
                                                }
                                            }
                                        }
                                        else {
                                            if x < -0.81055 {
                                                if y < 1.6394 { return GKGesture.Left }
                                                else { return GKGesture.Up }
                                            }
                                            else {
                                                if x < -0.24719 {
                                                    if x < -0.60568 {
                                                        if z < 0.01249 { return GKGesture.Left }
                                                        else {
                                                            if y < 1.80539 { return GKGesture.Right }
                                                            else { return GKGesture.Up }
                                                        }
                                                    }
                                                    else {
                                                        if y < 1.48951 {
                                                            if x < -0.40595 {
                                                                if y < 1.45921 { return GKGesture.Right }
                                                                else {
                                                                    if x < -0.43785 { return GKGesture.Up }
                                                                    else { return GKGesture.Up }
                                                                }
                                                            }
                                                            else { return GKGesture.Up }
                                                        }
                                                        else {
                                                            if x < -0.351 {
                                                                if y < 1.8644 {
                                                                    if y < 1.66124 {
                                                                        if y < 1.60249 {
                                                                            if y < 1.52135 { return GKGesture.Right }
                                                                            else { return GKGesture.Up }
                                                                        }
                                                                        else { return GKGesture.Right }
                                                                    }
                                                                    else {
                                                                        if x < -0.57398 { return GKGesture.Right }
                                                                        else { return GKGesture.Up }
                                                                    }
                                                                }
                                                                else {
                                                                    if y < 1.96666 { return GKGesture.Right }
                                                                    else { return GKGesture.Up }
                                                                }
                                                            }
                                                            else {
                                                                if y < 1.63984 {
                                                                    if y < 1.58534 { return GKGesture.Right }
                                                                    else { return GKGesture.Up }
                                                                }
                                                                else { return GKGesture.Right }
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if y < 1.76742 { return GKGesture.Left }
                                                    else { return GKGesture.Up }
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        if z < -1.25397 { return GKGesture.Push }
                                        else {
                                            if x < -0.0956 {
                                                if z < 0.24051 { return GKGesture.Left }
                                                else {
                                                    if z < 0.56557 { return GKGesture.Right }
                                                    else { return GKGesture.Left }
                                                }
                                            }
                                            else {
                                                if y < 1.43959 {
                                                    if x < 0.05554 {
                                                        if x < -0.00369 { return GKGesture.Right }
                                                        else { return nil }
                                                    }
                                                    else {
                                                        if y < 1.29118 { return GKGesture.Right }
                                                        else { return GKGesture.Left }
                                                    }
                                                }
                                                else { return GKGesture.Right }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            if x < 1.12044 {
                                if y < 0.72179 {
                                    if z < -1.15163 {
                                        if x < 1.04765 {
                                            if x < 0.50566 {
                                                if z < -1.21204 {
                                                    if x < 0.45045 { return GKGesture.Push }
                                                    else { return GKGesture.Push }
                                                }
                                                else { return nil }
                                            }
                                            else {
                                                if y < 0.46729 {
                                                    if z < -1.22855 { return GKGesture.Push }
                                                    else { return GKGesture.Push }
                                                }
                                                else {
                                                    if y < 0.51161 { return nil }
                                                    else { return GKGesture.Push }
                                                }
                                            }
                                        }
                                        else { return GKGesture.Down }
                                    }
                                    else {
                                        if z < -0.44566 {
                                            if z < -0.91487 {
                                                if x < 0.60409 { return nil }
                                                else {
                                                    if y < 0.52826 {
                                                        if y < 0.19986 {
                                                            if x < 0.63095 { return nil }
                                                            else {
                                                                if y < -0.12499 { return nil }
                                                                else {
                                                                    if y < 0.18729 {
                                                                        if y < 0.08363 { return GKGesture.Push }
                                                                        else { return GKGesture.Push }
                                                                    }
                                                                    else { return nil }
                                                                }
                                                            }
                                                        }
                                                        else {
                                                            if y < 0.33165 {
                                                                if x < 0.65611 { return nil }
                                                                else {
                                                                    if x < 0.66579 { return GKGesture.Push }
                                                                    else {
                                                                        if y < 0.31007 {
                                                                            if z < -1.06186 { return nil }
                                                                            else {
                                                                                if z < -0.98766 { return GKGesture.Push }
                                                                                else {
                                                                                    if y < 0.30619 { return nil }
                                                                                    else { return GKGesture.Push }
                                                                                }
                                                                            }
                                                                        }
                                                                        else { return nil }
                                                                    }
                                                                }
                                                            }
                                                            else {
                                                                if x < 0.61972 { return GKGesture.Push }
                                                                else {
                                                                    if z < -1.06316 {
                                                                        if x < 0.79061 { return GKGesture.Push }
                                                                        else {
                                                                            if y < 0.37969 { return GKGesture.Push }
                                                                            else { return GKGesture.Down }
                                                                        }
                                                                    }
                                                                    else {
                                                                        if z < -0.9212 {
                                                                            if z < -0.92942 {
                                                                                if y < 0.34608 { return GKGesture.Down }
                                                                                else {
                                                                                    if y < 0.48472 {
                                                                                        if y < 0.45759 {
                                                                                            if y < 0.44219 {
                                                                                                if x < 0.92139 {
                                                                                                    if x < 0.76215 {
                                                                                                        if y < 0.38289 {
                                                                                                            if z < -1.00999 { return nil }
                                                                                                            else { return GKGesture.Down }
                                                                                                        }
                                                                                                        else { return nil }
                                                                                                    }
                                                                                                    else { return GKGesture.Push }
                                                                                                }
                                                                                                else { return nil }
                                                                                            }
                                                                                            else { return GKGesture.Push }
                                                                                        }
                                                                                        else { return nil }
                                                                                    }
                                                                                    else {
                                                                                        if x < 1.02097 {
                                                                                            if y < 0.49957 { return GKGesture.Push }
                                                                                            else {
                                                                                                if x < 0.74786 { return nil }
                                                                                                else { return nil }
                                                                                            }
                                                                                        }
                                                                                        else { return GKGesture.Down }
                                                                                    }
                                                                                }
                                                                            }
                                                                            else { return nil }
                                                                        }
                                                                        else {
                                                                            if x < 0.77104 { return GKGesture.Push }
                                                                            else { return GKGesture.Down }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else { return GKGesture.Push }
                                                }
                                            }
                                            else {
                                                if y < 0.09982 {
                                                    if x < 0.88239 {
                                                        if z < -0.59998 {
                                                            if y < -0.14013 { return GKGesture.Push }
                                                            else {
                                                                if x < 0.4751 { return nil }
                                                                else { return GKGesture.Push }
                                                            }
                                                        }
                                                        else {
                                                            if y < -0.0026 {
                                                                if x < 0.57743 { return GKGesture.Push }
                                                                else { return nil }
                                                            }
                                                            else { return GKGesture.Down }
                                                        }
                                                    }
                                                    else { return GKGesture.Push }
                                                }
                                                else { return nil }
                                            }
                                        }
                                        else {
                                            if y < 0.3081 {
                                                if z < -0.02447 {
                                                    if x < 0.6197 { return GKGesture.Down }
                                                    else {
                                                        if y < 0.22944 { return GKGesture.Right }
                                                        else { return nil }
                                                    }
                                                }
                                                else { return nil }
                                            }
                                            else {
                                                if x < 0.62134 {
                                                    if z < -0.41587 { return nil }
                                                    else {
                                                        if z < -0.37218 { return GKGesture.Left }
                                                        else {
                                                            if x < 0.45062 { return GKGesture.Left }
                                                            else { return GKGesture.Left }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if z < -0.19789 { return nil }
                                                    else {
                                                        if y < 0.67956 { return GKGesture.Left }
                                                        else { return nil }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if z < -0.97207 {
                                        if x < 0.69501 {
                                            if z < -1.39477 { return GKGesture.Push }
                                            else {
                                                if z < -1.10998 { return GKGesture.Left }
                                                else {
                                                    if x < 0.3957 { return nil }
                                                    else {
                                                        if y < 0.9385 {
                                                            if x < 0.43425 {
                                                                if y < 0.89444 { return nil }
                                                                else { return GKGesture.Left }
                                                            }
                                                            else { return GKGesture.Left }
                                                        }
                                                        else { return nil }
                                                    }
                                                }
                                            }
                                        }
                                        else {
                                            if x < 0.94722 {
                                                if y < 1.16405 { return GKGesture.Push }
                                                else { return GKGesture.Left }
                                            }
                                            else {
                                                if z < -1.1666 { return GKGesture.Down }
                                                else { return GKGesture.Push }
                                            }
                                        }
                                    }
                                    else {
                                        if x < 0.9352 {
                                            if z < 0.91328 {
                                                if z < -0.41249 {
                                                    if y < 0.97303 {
                                                        if z < -0.8888 { return GKGesture.Left }
                                                        else {
                                                            if z < -0.55811 {
                                                                if y < 0.8986 {
                                                                    if z < -0.70988 {
                                                                        if y < 0.80539 { return nil }
                                                                        else { return GKGesture.Left }
                                                                    }
                                                                    else {
                                                                        if x < 0.55725 { return nil }
                                                                        else { return GKGesture.Left }
                                                                    }
                                                                }
                                                                else { return nil }
                                                            }
                                                            else {
                                                                if y < 0.9327 { return GKGesture.Left }
                                                                else { return nil }
                                                            }
                                                        }
                                                    }
                                                    else { return GKGesture.Left }
                                                }
                                                else {
                                                    if y < 1.04411 {
                                                        if z < 0.20641 { return GKGesture.Left }
                                                        else { return GKGesture.Left }
                                                    }
                                                    else {
                                                        if y < 1.32981 {
                                                            if x < 0.78005 {
                                                                if z < 0.36005 { return GKGesture.Left }
                                                                else {
                                                                    if z < 0.41948 { return nil }
                                                                    else { return GKGesture.Right }
                                                                }
                                                            }
                                                            else {
                                                                if y < 1.07366 { return nil }
                                                                else { return GKGesture.Left }
                                                            }
                                                        }
                                                        else { return GKGesture.Left }
                                                    }
                                                }
                                            }
                                            else { return GKGesture.Right }
                                        }
                                        else {
                                            if y < 1.21376 {
                                                if x < 1.02569 { return nil }
                                                else { return GKGesture.Right }
                                            }
                                            else {
                                                if x < 1.09207 {
                                                    if x < 0.99174 {
                                                        if y < 1.33002 { return GKGesture.Left }
                                                        else { return GKGesture.Right }
                                                    }
                                                    else { return GKGesture.Right }
                                                }
                                                else { return GKGesture.Left }
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                if y < 0.28378 {
                                    if y < 0.15984 {
                                        if z < -1.06914 { return GKGesture.Push }
                                        else {
                                            if y < 0.04861 { return GKGesture.Push }
                                            else { return GKGesture.Push }
                                        }
                                    }
                                    else {
                                        if z < -0.92706 { return GKGesture.Push }
                                        else {
                                            if x < 1.23024 {
                                                if y < 0.24314 { return nil }
                                                else { return nil }
                                            }
                                            else { return GKGesture.Down }
                                        }
                                    }
                                }
                                else {
                                    if z < -0.75901 {
                                        if y < 0.92818 {
                                            if x < 1.31316 {
                                                if z < -0.98688 {
                                                    if y < 0.42058 { return GKGesture.Push }
                                                    else {
                                                        if x < 1.25736 {
                                                            if x < 1.19675 {
                                                                if y < 0.72483 {
                                                                    if z < -1.14604 { return GKGesture.Down }
                                                                    else { return nil }
                                                                }
                                                                else { return GKGesture.Push }
                                                            }
                                                            else {
                                                                if z < -1.17794 {
                                                                    if z < -1.19368 { return GKGesture.Push }
                                                                    else { return GKGesture.Down }
                                                                }
                                                                else { return GKGesture.Push }
                                                            }
                                                        }
                                                        else { return GKGesture.Down }
                                                    }
                                                }
                                                else {
                                                    if y < 0.31527 { return nil }
                                                    else { return GKGesture.Down }
                                                }
                                            }
                                            else {
                                                if z < -1.21838 {
                                                    if y < 0.47179 { return GKGesture.Push }
                                                    else {
                                                        if y < 0.6834 { return GKGesture.Down }
                                                        else {
                                                            if y < 0.78485 {
                                                                if x < 1.54873 { return GKGesture.Down }
                                                                else {
                                                                    if z < -1.26884 {
                                                                        if y < 0.71029 { return GKGesture.Push }
                                                                        else { return GKGesture.Push }
                                                                    }
                                                                    else { return GKGesture.Down }
                                                                }
                                                            }
                                                            else {
                                                                if z < -1.61243 { return GKGesture.Push }
                                                                else {
                                                                    if x < 2.14218 { return GKGesture.Down }
                                                                    else { return GKGesture.Down }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if x < 1.74265 {
                                                        if x < 1.68922 {
                                                            if y < 0.38409 {
                                                                if z < -1.09286 { return GKGesture.Push }
                                                                else { return GKGesture.Down }
                                                            }
                                                            else {
                                                                if x < 1.35166 {
                                                                    if z < -1.0034 { return GKGesture.Down }
                                                                    else { return GKGesture.Push }
                                                                }
                                                                else {
                                                                    if y < 0.67625 { return GKGesture.Down }
                                                                    else { return GKGesture.Down }
                                                                }
                                                            }
                                                        }
                                                        else { return GKGesture.Push }
                                                    }
                                                    else { return GKGesture.Down }
                                                }
                                            }
                                        }
                                        else {
                                            if z < -1.47951 { return GKGesture.Down }
                                            else { return GKGesture.Push }
                                        }
                                    }
                                    else {
                                        if y < 1.57831 {
                                            if z < 0.65936 {
                                                if x < 1.14932 { return GKGesture.Right }
                                                else {
                                                    if y < 0.38309 { return GKGesture.Right }
                                                    else { return GKGesture.Right }
                                                }
                                            }
                                            else { return GKGesture.Left }
                                        }
                                        else { return GKGesture.Left }
                                    }
                                }
                            }
                        }
                    }
                    else {
                        if x < 0.13728 {
                            if x < -0.10265 {
                                if z < 1.09567 {
                                    if z < 1.08936 {
                                        if x < -0.31146 {
                                            if x < -1.04993 { return GKGesture.Left }
                                            else {
                                                if y < 0.17773 { return GKGesture.Right }
                                                else {
                                                    if y < 0.52571 {
                                                        if x < -0.80968 { return GKGesture.Up }
                                                        else {
                                                            if z < 1.04108 {
                                                                if z < 1.01466 { return GKGesture.Up }
                                                                else { return nil }
                                                            }
                                                            else { return GKGesture.Up }
                                                        }
                                                    }
                                                    else {
                                                        if x < -0.41975 {
                                                            if x < -0.5671 {
                                                                if z < 1.03815 {
                                                                    if z < 1.0061 { return GKGesture.Up }
                                                                    else { return GKGesture.Right }
                                                                }
                                                                else {
                                                                    if x < -0.59432 { return GKGesture.Up }
                                                                    else { return nil }
                                                                }
                                                            }
                                                            else { return GKGesture.Up }
                                                        }
                                                        else {
                                                            if x < -0.33304 {
                                                                if z < 1.00661 { return nil }
                                                                else {
                                                                    if x < -0.34799 {
                                                                        if y < 0.78526 { return GKGesture.Up }
                                                                        else { return GKGesture.Right }
                                                                    }
                                                                    else { return nil }
                                                                }
                                                            }
                                                            else { return GKGesture.Up }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        else {
                                            if x < -0.16861 {
                                                if y < 0.5924 { return nil }
                                                else {
                                                    if y < 0.65327 { return GKGesture.Up }
                                                    else {
                                                        if y < 0.71256 { return nil }
                                                        else { return GKGesture.Up }
                                                    }
                                                }
                                            }
                                            else { return GKGesture.Up }
                                        }
                                    }
                                    else { return nil }
                                }
                                else {
                                    if x < -0.42832 {
                                        if x < -1.03451 {
                                            if y < 0.85804 { return GKGesture.Left }
                                            else { return GKGesture.Up }
                                        }
                                        else { return GKGesture.Up }
                                    }
                                    else {
                                        if x < -0.4114 { return nil }
                                        else {
                                            if y < 0.86185 {
                                                if x < -0.32027 { return GKGesture.Up }
                                                else {
                                                    if x < -0.28537 { return GKGesture.Up }
                                                    else {
                                                        if y < 0.46501 { return GKGesture.Up }
                                                        else { return GKGesture.Up }
                                                    }
                                                }
                                            }
                                            else {
                                                if x < -0.33472 { return GKGesture.Up }
                                                else {
                                                    if y < 1.03638 {
                                                        if z < 1.54525 { return nil }
                                                        else {
                                                            if x < -0.26443 { return GKGesture.Up }
                                                            else { return GKGesture.Up }
                                                        }
                                                    }
                                                    else { return GKGesture.Up }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                if y < 0.62819 {
                                    if z < 1.0888 { return nil }
                                    else {
                                        if y < 0.40969 {
                                            if x < -0.00858 { return GKGesture.Up }
                                            else { return nil }
                                        }
                                        else { return GKGesture.Up }
                                    }
                                }
                                else {
                                    if z < 1.38098 {
                                        if x < -0.05529 { return GKGesture.Up }
                                        else {
                                            if x < -0.04491 { return nil }
                                            else {
                                                if x < 0.06569 {
                                                    if z < 1.28084 { return GKGesture.Left }
                                                    else { return nil }
                                                }
                                                else { return nil }
                                            }
                                        }
                                    }
                                    else {
                                        if y < 0.8233 { return GKGesture.Up }
                                        else {
                                            if y < 1.12353 {
                                                if z < 1.62766 {
                                                    if y < 0.98297 { return GKGesture.Right }
                                                    else { return GKGesture.Right }
                                                }
                                                else { return GKGesture.Up }
                                            }
                                            else { return GKGesture.Up }
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            if z < 1.24834 {
                                if y < 1.03825 { return GKGesture.Left }
                                else {
                                    if z < 1.21207 {
                                        if x < 0.30672 { return GKGesture.Right }
                                        else {
                                            if z < 1.08772 {
                                                if x < 0.73611 { return GKGesture.Right }
                                                else { return GKGesture.Right }
                                            }
                                            else { return GKGesture.Left }
                                        }
                                    }
                                    else { return nil }
                                }
                            }
                            else {
                                if x < 0.17533 { return GKGesture.Up }
                                else { return GKGesture.Left }
                            }
                        }
                    }
                } else {
                    return nil
                }
            }
            return BFTree
        }
    }
    static var J48Tree : GKGestureClassifier {
        get{
            func J48Tree (data : CMAccelerometerData?) -> GKGesture? {
                if data != nil {
                    let x = data!.acceleration.x
                    let y = data!.acceleration.y
                    let z = data!.acceleration.z
                    if z <= 0.915421 {
                        if x <= 0.235794 {
                            if y <= 1.110031 {
                                if z <= -1.044403 {
                                    if z <= -1.351089 {
                                        if x <= -0.31218 {
                                            if z <= -1.728256 { return GKGesture.Up }
                                            else {
                                                if x <= -0.545273 { return GKGesture.Down }
                                                else {
                                                    if y <= 0.922333 { return GKGesture.Push }
                                                    else { return GKGesture.Down }
                                                }
                                            }
                                        }
                                        else { return GKGesture.Up }
                                    }
                                    else {
                                        if x <= -0.265106 {
                                            if y <= 0.241776 {
                                                if x <= -0.927231 { return GKGesture.Push }
                                                else {
                                                    if z <= -1.180206 {
                                                        if y <= -0.006882 { return GKGesture.Push }
                                                        else { return nil }
                                                    }
                                                    else { return nil }
                                                }
                                            }
                                            else {
                                                if y <= 0.594925 {
                                                    if x <= -0.512558 { return GKGesture.Down }
                                                    else {
                                                        if x <= -0.270905 { return nil }
                                                        else { return GKGesture.Down }
                                                    }
                                                }
                                                else { return GKGesture.Down }
                                            }
                                        }
                                        else {
                                            if y <= 0.749954 {
                                                if z <= -1.22966 {
                                                    if y <= 0.130585 { return GKGesture.Push }
                                                    else {
                                                        if x <= -0.163849 {
                                                            if y <= 0.583466 {
                                                                if z <= -1.265686 { return GKGesture.Up }
                                                                else { return nil }
                                                            }
                                                            else { return GKGesture.Down }
                                                        }
                                                        else { return nil }
                                                    }
                                                }
                                                else { return nil }
                                            }
                                            else {
                                                if x <= 0.007309 {
                                                    if z <= -1.155548 { return GKGesture.Down }
                                                    else { return GKGesture.Push }
                                                }
                                                else { return GKGesture.Left }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if y <= 0.616592 {
                                        if y <= -0.130569 {
                                            if y <= -0.800064 {
                                                if x <= -0.857101 { return GKGesture.Push }
                                                else {
                                                    if z <= -0.272705 {
                                                        if z <= -0.642853 {
                                                            if x <= -0.595657 { return GKGesture.Push }
                                                            else { return nil }
                                                        }
                                                        else { return nil }
                                                    }
                                                    else { return GKGesture.Push }
                                                }
                                            }
                                            else {
                                                if x <= -1.031662 {
                                                    if y <= -0.544876 { return GKGesture.Push }
                                                    else {
                                                        if y <= -0.209457 {
                                                            if x <= -1.195007 { return GKGesture.Up }
                                                            else {
                                                                if z <= -0.493774 {
                                                                    if y <= -0.304581 { return GKGesture.Push }
                                                                    else { return nil }
                                                                }
                                                                else { return nil }
                                                            }
                                                        }
                                                        else {
                                                            if z <= -0.580551 { return GKGesture.Push }
                                                            else { return GKGesture.Down }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if z <= -0.377533 {
                                                        if x <= -0.393982 { return nil }
                                                        else {
                                                            if y <= -0.290619 {
                                                                if z <= -0.717773 {
                                                                    if x <= -0.279602 { return nil }
                                                                    else {
                                                                        if z <= -0.763138 { return GKGesture.Push }
                                                                        else { return nil }
                                                                    }
                                                                }
                                                                else { return GKGesture.Push }
                                                            }
                                                            else { return nil }
                                                        }
                                                    }
                                                    else { return nil }
                                                }
                                            }
                                        }
                                        else {
                                            if z <= -0.190506 {
                                                if x <= -0.962738 {
                                                    if z <= -0.702606 {
                                                        if y <= 0.457932 { return GKGesture.Push }
                                                        else { return GKGesture.Right }
                                                    }
                                                    else {
                                                        if x <= -1.214203 {
                                                            if x <= -1.27829 {
                                                                if y <= 0.206467 { return GKGesture.Up }
                                                                else { return GKGesture.Left }
                                                            }
                                                            else { return GKGesture.Up }
                                                        }
                                                        else {
                                                            if y <= 0.293381 { return nil }
                                                            else { return GKGesture.Left }
                                                        }
                                                    }
                                                }
                                                else { return nil }
                                            }
                                            else {
                                                if x <= -1.024948 {
                                                    if z <= 0.279312 {
                                                        if x <= -1.115341 { return nil }
                                                        else { return GKGesture.Up }
                                                    }
                                                    else {
                                                        if x <= -1.256851 { return GKGesture.Up }
                                                        else {
                                                            if z <= 0.435547 { return GKGesture.Left }
                                                            else {
                                                                if z <= 0.596573 { return nil }
                                                                else {
                                                                    if z <= 0.778473 { return GKGesture.Left }
                                                                    else { return nil }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if z <= 0.522781 {
                                                        if x <= -0.624939 { return nil }
                                                        else {
                                                            if z <= 0.236816 {
                                                                if y <= 0.233002 { return nil }
                                                                else {
                                                                    if x <= -0.231644 {
                                                                        if z <= 0.070206 {
                                                                            if x <= -0.526031 {
                                                                                if y <= 0.399017 {
                                                                                    if y <= 0.347351 { return nil }
                                                                                    else { return GKGesture.Right }
                                                                                }
                                                                                else { return nil }
                                                                            }
                                                                            else {
                                                                                if x <= -0.499573 { return GKGesture.Down }
                                                                                else { return GKGesture.Right }
                                                                            }
                                                                        }
                                                                        else { return nil }
                                                                    }
                                                                    else {
                                                                        if y <= 0.27121 { return GKGesture.Right }
                                                                        else {
                                                                            if z <= 0.003143 { return nil }
                                                                            else { return GKGesture.Up }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            else {
                                                                if x <= -0.37616 {
                                                                    if z <= 0.265076 {
                                                                        if x <= -0.570801 { return GKGesture.Up }
                                                                        else {
                                                                            if x <= -0.493195 { return GKGesture.Right }
                                                                            else { return GKGesture.Up }
                                                                        }
                                                                    }
                                                                    else { return nil }
                                                                }
                                                                else {
                                                                    if y <= 0.301544 { return nil }
                                                                    else { return GKGesture.Up }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        if x <= -0.821991 {
                                                            if z <= 0.80809 { return nil }
                                                            else { return GKGesture.Up }
                                                        }
                                                        else { return nil }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        if x <= -0.840744 {
                                            if y <= 0.765335 {
                                                if x <= -0.986328 { return GKGesture.Left }
                                                else {
                                                    if z <= 0.672241 { return nil }
                                                    else { return GKGesture.Right }
                                                }
                                            }
                                            else {
                                                if y <= 0.94014 { return GKGesture.Left }
                                                else {
                                                    if z <= 0.54425 {
                                                        if x <= -0.959717 { return GKGesture.Right }
                                                        else { return GKGesture.Left }
                                                    }
                                                    else { return GKGesture.Left }
                                                }
                                            }
                                        }
                                        else {
                                            if z <= -0.647842 {
                                                if y <= 0.907654 { return nil }
                                                else {
                                                    if x <= -0.235352 {
                                                        if z <= -0.895691 { return GKGesture.Up }
                                                        else {
                                                            if x <= -0.490967 {
                                                                if y <= 1.019714 { return GKGesture.Right }
                                                                else { return GKGesture.Left }
                                                            }
                                                            else {
                                                                if z <= -0.739487 {
                                                                    if y <= 1.058701 { return nil }
                                                                    else { return GKGesture.Right }
                                                                }
                                                                else { return GKGesture.Right }
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        if z <= -0.827103 {
                                                            if x <= 0.048386 {
                                                                if z <= -0.912857 { return GKGesture.Left }
                                                                else { return GKGesture.Right }
                                                            }
                                                            else { return GKGesture.Left }
                                                        }
                                                        else {
                                                            if x <= 0.118408 {
                                                                if x <= 0.02449 {
                                                                    if x <= -0.070099 { return nil }
                                                                    else { return GKGesture.Left }
                                                                }
                                                                else { return nil }
                                                            }
                                                            else {
                                                                if z <= -0.660492 { return nil }
                                                                else { return GKGesture.Left }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            else {
                                                if z <= 0.306503 { return nil }
                                                else {
                                                    if y <= 0.77681 {
                                                        if x <= -0.671555 {
                                                            if z <= 0.596298 { return nil }
                                                            else {
                                                                if y <= 0.739548 {
                                                                    if y <= 0.678543 { return nil }
                                                                    else { return GKGesture.Right }
                                                                }
                                                                else { return GKGesture.Up }
                                                            }
                                                        }
                                                        else {
                                                            if z <= 0.697922 { return nil }
                                                            else {
                                                                if x <= -0.54425 {
                                                                    if x <= -0.613083 { return GKGesture.Left }
                                                                    else { return GKGesture.Up }
                                                                }
                                                                else { return nil }
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        if z <= 0.663162 {
                                                            if x <= -0.664566 {
                                                                if z <= 0.496841 {
                                                                    if y <= 1.009933 {
                                                                        if x <= -0.756149 {
                                                                            if x <= -0.801086 { return nil }
                                                                            else { return GKGesture.Left }
                                                                        }
                                                                        else { return nil }
                                                                    }
                                                                    else { return GKGesture.Left }
                                                                }
                                                                else {
                                                                    if x <= -0.73584 { return nil }
                                                                    else { return GKGesture.Right }
                                                                }
                                                            }
                                                            else { return nil }
                                                        }
                                                        else {
                                                            if x <= -0.253922 {
                                                                if x <= -0.716049 { return GKGesture.Left }
                                                                else {
                                                                    if z <= 0.684677 {
                                                                        if y <= 0.971512 { return GKGesture.Left }
                                                                        else { return GKGesture.Right }
                                                                    }
                                                                    else { return nil }
                                                                }
                                                            }
                                                            else {
                                                                if y <= 0.923233 {
                                                                    if x <= -0.063324 {
                                                                        if x <= -0.095871 {
                                                                            if x <= -0.195618 { return GKGesture.Left }
                                                                            else { return GKGesture.Up }
                                                                        }
                                                                        else { return GKGesture.Left }
                                                                    }
                                                                    else {
                                                                        if z <= 0.830704 { return nil }
                                                                        else {
                                                                            if x <= 0.06369 { return GKGesture.Up }
                                                                            else { return nil }
                                                                        }
                                                                    }
                                                                }
                                                                else { return GKGesture.Left }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                if y <= 1.270447 {
                                    if z <= -0.959747 {
                                        if x <= 0.046051 {
                                            if x <= -0.214081 {
                                                if y <= 1.184357 { return GKGesture.Down }
                                                else { return GKGesture.Right }
                                            }
                                            else {
                                                if x <= -0.088165 { return GKGesture.Push }
                                                else { return GKGesture.Down }
                                            }
                                        }
                                        else { return GKGesture.Left }
                                    }
                                    else {
                                        if z <= 0.395172 {
                                            if x <= -0.329193 {
                                                if z <= -0.208206 {
                                                    if z <= -0.579559 { return GKGesture.Right }
                                                    else {
                                                        if y <= 1.234009 {
                                                            if y <= 1.148987 { return GKGesture.Right }
                                                            else { return nil }
                                                        }
                                                        else { return GKGesture.Up }
                                                    }
                                                }
                                                else {
                                                    if x <= -0.423477 {
                                                        if y <= 1.160934 {
                                                            if z <= 0.140747 { return nil }
                                                            else {
                                                                if z <= 0.231598 { return GKGesture.Left }
                                                                else { return GKGesture.Right }
                                                            }
                                                        }
                                                        else { return GKGesture.Right }
                                                    }
                                                    else { return nil }
                                                }
                                            }
                                            else {
                                                if z <= -0.646454 {
                                                    if x <= 0.195038 {
                                                        if x <= -0.188065 { return GKGesture.Right }
                                                        else {
                                                            if y <= 1.19751 { return GKGesture.Left }
                                                            else { return GKGesture.Right }
                                                        }
                                                    }
                                                    else { return nil }
                                                }
                                                else { return nil }
                                            }
                                        }
                                        else {
                                            if x <= -0.479767 { return GKGesture.Right }
                                            else {
                                                if z <= 0.564148 {
                                                    if x <= -0.407654 { return nil } 
                                                    else { return GKGesture.Left } 
                                                }
                                                else {
                                                    if x <= -0.41333 { return GKGesture.Up } 
                                                    else {
                                                        if x <= -0.2939 { return GKGesture.Left } 
                                                        else { return GKGesture.Up } 
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if x <= -0.227875 {
                                        if y <= 1.405258 {
                                            if z <= -0.159454 {
                                                if z <= -0.710663 {
                                                    if z <= -0.831528 {
                                                        if x <= -0.644913 { return GKGesture.Right } 
                                                        else { return GKGesture.Up } 
                                                    }
                                                    else { return GKGesture.Right } 
                                                }
                                                else {
                                                    if y <= 1.386444 {
                                                        if x <= -0.268509 { return GKGesture.Up } 
                                                        else { return GKGesture.Left } 
                                                    }
                                                    else { return nil } 
                                                }
                                            }
                                            else {
                                                if x <= -0.56749 {
                                                    if y <= 1.336533 { return GKGesture.Left } 
                                                    else { return GKGesture.Right } 
                                                }
                                                else {
                                                    if z <= 0.476547 { return nil } 
                                                    else {
                                                        if y <= 1.279755 { return GKGesture.Up } 
                                                        else { return GKGesture.Right } 
                                                    }
                                                }
                                            }
                                        }
                                        else {
                                            if z <= 0.066696 {
                                                if x <= -0.427322 {
                                                    if x <= -1.020477 { return GKGesture.Up } 
                                                    else { return GKGesture.Left } 
                                                }
                                                else {
                                                    if y <= 1.531464 { return GKGesture.Up } 
                                                    else {
                                                        if z <= -0.263718 { return GKGesture.Right } 
                                                        else {
                                                            if z <= -0.127197 { return GKGesture.Up } 
                                                            else { return GKGesture.Right } 
                                                        }
                                                    }
                                                }
                                            }
                                            else { return GKGesture.Up } 
                                        }
                                    }
                                    else { return GKGesture.Right } 
                                }
                            }
                        }
                        else {
                            if x <= 1.120285 {
                                if y <= 0.70694 {
                                    if z <= -0.866592 {
                                        if z <= -1.201492 { return GKGesture.Push } 
                                        else {
                                            if x <= 0.620224 { return nil } 
                                            else {
                                                if y <= 0.336456 {
                                                    if y <= 0.288773 {
                                                        if x <= 0.695953 { return nil } 
                                                        else { return GKGesture.Push } 
                                                    }
                                                    else { return nil } 
                                                }
                                                else {
                                                    if y <= 0.52507 {
                                                        if x <= 1.024857 {
                                                            if y <= 0.392075 {
                                                                if x <= 0.704895 { return nil } 
                                                                else {
                                                                    if x <= 0.840088 { return GKGesture.Down } 
                                                                    else {
                                                                        if x <= 0.917221 { return GKGesture.Push } 
                                                                        else { return nil } 
                                                                    }
                                                                }
                                                            }
                                                            else { return nil } 
                                                        }
                                                        else {
                                                            if y <= 0.379913 { return nil } 
                                                            else { return GKGesture.Down } 
                                                        }
                                                    }
                                                    else {
                                                        if z <= -0.924515 { return GKGesture.Push } 
                                                        else {
                                                            if y <= 0.527237 { return GKGesture.Push } 
                                                            else { return nil } 
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        if y <= -0.01796 {
                                            if z <= -0.468246 {
                                                if x <= 0.53891 {
                                                    if y <= -0.139084 { return GKGesture.Push } 
                                                    else { return nil } 
                                                }
                                                else { return GKGesture.Push } 
                                            }
                                            else { return nil } 
                                        }
                                        else {
                                            if z <= -0.360275 {
                                                if y <= 0.323334 {
                                                    if x <= 0.81958 {
                                                        if x <= 0.544495 { return GKGesture.Down } 
                                                        else {
                                                            if y <= 0.278687 {
                                                                if x <= 0.717377 {
                                                                    if z <= -0.824448 { return nil } 
                                                                    else { return GKGesture.Down } 
                                                                }
                                                                else { return nil } 
                                                            }
                                                            else {
                                                                if y <= 0.289871 { return GKGesture.Right } 
                                                                else {
                                                                    if x <= 0.751404 { return nil } 
                                                                    else { return GKGesture.Down } 
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        if y <= 0.3172 { return nil } 
                                                        else {
                                                            if x <= 1.033188 { return nil } 
                                                            else { return GKGesture.Down } 
                                                        }
                                                    }
                                                }
                                                else { return nil } 
                                            }
                                            else {
                                                if y <= 0.245117 {
                                                    if x <= 0.60733 { return nil } 
                                                    else { return GKGesture.Right } 
                                                }
                                                else {
                                                    if z <= -0.197937 {
                                                        if z <= -0.317017 { return GKGesture.Left } 
                                                        else { return nil } 
                                                    }
                                                    else { return GKGesture.Left } 
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if z <= -0.972076 {
                                        if x <= 0.694992 {
                                            if z <= -1.1492 {
                                                if x <= 0.372391 { return GKGesture.Push } 
                                                else {
                                                    if z <= -1.398392 { return GKGesture.Push } 
                                                    else { return GKGesture.Left } 
                                                }
                                            }
                                            else { return GKGesture.Left } 
                                        }
                                        else {
                                            if x <= 0.946411 { return GKGesture.Push } 
                                            else {
                                                if z <= -1.167053 { return GKGesture.Down } 
                                                else { return GKGesture.Push } 
                                            }
                                        }
                                    }
                                    else {
                                        if y <= 1.208389 {
                                            if x <= 0.341431 {
                                                if z <= -0.631638 { return GKGesture.Left } 
                                                else {
                                                    if z <= -0.105728 { return nil } 
                                                    else {
                                                        if y <= 0.759857 { return nil } 
                                                        else { return GKGesture.Left } 
                                                    }
                                                }
                                            }
                                            else {
                                                if x <= 0.934753 {
                                                    if z <= -0.2099 {
                                                        if y <= 0.972977 {
                                                            if z <= -0.888901 { return GKGesture.Left } 
                                                            else {
                                                                if z <= -0.553604 { return nil } 
                                                                else { return GKGesture.Left } 
                                                            }
                                                        }
                                                        else { return GKGesture.Left } 
                                                    }
                                                    else {
                                                        if y <= 1.127457 { return GKGesture.Left } 
                                                        else {
                                                            if x <= 0.7155 { return GKGesture.Right } 
                                                            else {
                                                                if z <= 0.53418 { return nil } 
                                                                else { return GKGesture.Left } 
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if x <= 1.025589 { return nil } 
                                                    else { return GKGesture.Right } 
                                                }
                                            }
                                        }
                                        else {
                                            if x <= 0.31218 { return GKGesture.Right } 
                                            else { return GKGesture.Left } 
                                        }
                                    }
                                }
                            }
                            else {
                                if z <= -0.750168 {
                                    if y <= 0.256058 {
                                        if x <= 1.2164 {
                                            if z <= -0.9272 { return GKGesture.Push } 
                                            else { return nil } 
                                        }
                                        else { return GKGesture.Push } 
                                    }
                                    else {
                                        if x <= 1.310165 {
                                            if z <= -0.986984 { return GKGesture.Push } 
                                            else {
                                                if y <= 0.315201 { return nil } 
                                                else { return GKGesture.Down } 
                                            }
                                        }
                                        else {
                                            if z <= -1.218521 {
                                                if y <= 0.471786 { return GKGesture.Push } 
                                                else {
                                                    if y <= 0.683395 { return GKGesture.Down } 
                                                    else { return GKGesture.Push } 
                                                }
                                            }
                                            else { return GKGesture.Down } 
                                        }
                                    }
                                }
                                else {
                                    if y <= 0.252167 {
                                        if y <= 0.15976 { return GKGesture.Push } 
                                        else {
                                            if x <= 1.212769 { return nil } 
                                            else { return GKGesture.Down } 
                                        }
                                    }
                                    else {
                                        if y <= 1.577011 {
                                            if z <= 0.276581 { return GKGesture.Right } 
                                            else {
                                                if x <= 1.2164 { return GKGesture.Left } 
                                                else { return GKGesture.Right } 
                                            }
                                        }
                                        else { return GKGesture.Left } 
                                    }
                                }
                            }
                        }
                    }
                    else {
                        if x <= 0.137207 {
                            if z <= 1.035477 {
                                if y <= 0.634201 {
                                    if x <= -0.622742 {
                                        if y <= 0.523727 {
                                            if y <= 0.422516 {
                                                if y <= 0.244522 { return GKGesture.Right } 
                                                else { return GKGesture.Up } 
                                            }
                                            else { return nil } 
                                        }
                                        else { return GKGesture.Up } 
                                    }
                                    else { return nil } 
                                }
                                else {
                                    if x <= -0.294907 {
                                        if x <= -0.897415 {
                                            if x <= -1.04541 { return GKGesture.Left } 
                                            else { return GKGesture.Up } 
                                        }
                                        else {
                                            if y <= 0.785767 {
                                                if y <= 0.694336 { return GKGesture.Up } 
                                                else {
                                                    if y <= 0.712906 { return nil } 
                                                    else { return GKGesture.Up } 
                                                }
                                            }
                                            else {
                                                if y <= 1.220612 {
                                                    if z <= 0.933212 { return nil } 
                                                    else {
                                                        if y <= 0.879776 {
                                                            if y <= 0.813766 { return GKGesture.Right } 
                                                            else { return GKGesture.Up } 
                                                        }
                                                        else {
                                                            if x <= -0.543823 { return GKGesture.Right } 
                                                            else {
                                                                if x <= -0.397491 { return nil } 
                                                                else { return GKGesture.Right } 
                                                            }
                                                        }
                                                    }
                                                }
                                                else { return GKGesture.Up } 
                                            }
                                        }
                                    }
                                    else {
                                        if y <= 0.899612 {
                                            if x <= -0.158508 { return nil } 
                                            else { return GKGesture.Up } 
                                        }
                                        else { return GKGesture.Left } 
                                    }
                                }
                            }
                            else {
                                if x <= -0.094223 { return GKGesture.Up } 
                                else {
                                    if y <= 0.624451 {
                                        if z <= 1.088547 { return nil } 
                                        else { return GKGesture.Up } 
                                    }
                                    else {
                                        if z <= 1.316284 {
                                            if x <= 0.065659 { return GKGesture.Left } 
                                            else { return nil } 
                                        }
                                        else {
                                            if y <= 0.823227 { return GKGesture.Up } 
                                            else { return GKGesture.Right } 
                                        }
                                    }
                                }
                            }
                        }
                        else { return GKGesture.Left } 
                    }
                } else {
                    return nil
                }
            }
            return J48Tree
        }
    }
    static var REPTree : GKGestureClassifier {
        get{
            func REPTree (data : CMAccelerometerData?) -> GKGesture? {
                if data != nil {
                    let x = data!.acceleration.x
                    let y = data!.acceleration.y
                    let z = data!.acceleration.z
                    if x < 0.2 {
                        if z < 0.92 {
                            if y < 1.11 {
                                if z < -1.01 {
                                    if z < -1.27 {
                                        if z < -1.41 {
                                            if x < -0.31 {
                                                if z < -1.73 {  return GKGesture.Up }
                                                else {
                                                    if x < -0.55 {  return GKGesture.Down }
                                                    else { return GKGesture.Push }
                                                }
                                            }
                                            else { return GKGesture.Up }
                                        }
                                        else {
                                            if y < 0.75 {
                                                if x < -0.53 {  return GKGesture.Down }
                                                else { return nil }
                                            }
                                            else { return GKGesture.Down }
                                        }
                                    }
                                    else {
                                        if x < -0.46 {
                                            if y < 0.12 {
                                                if x < -0.75 {
                                                    if x < -0.83 {  return GKGesture.Push }
                                                    else { return nil }
                                                }
                                                else { return nil }
                                            }
                                            else { return GKGesture.Down }
                                        }
                                        else {
                                            if y < 0.59 {
                                                if z < -1.14 {
                                                    if y < 0.27 {
                                                        if x < -0.1 {  return nil }
                                                        else {
                                                            if x < 0.11 {  return GKGesture.Push }
                                                            else { return nil }
                                                        }
                                                    }
                                                    else { return nil }
                                                }
                                                else { return nil }
                                            }
                                            else {
                                                if x < -0.1 {
                                                    if z < -1.1 {  return GKGesture.Down }
                                                    else { return nil }
                                                }
                                                else { return nil }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if y < -0.12 {
                                        if x < -0.99 {
                                            if y < -0.55 {
                                                if x < -1.05 {  return GKGesture.Push }
                                                else {
                                                    if y < -0.8 {  return GKGesture.Push }
                                                    else { return nil }
                                                }
                                            }
                                            else {
                                                if z < -0.52 {  return GKGesture.Push }
                                                else { return nil }
                                            }
                                        }
                                        else {
                                            if z < -0.36 {
                                                if x < -0.4 {  return nil }
                                                else {
                                                    if y < -0.29 {
                                                        if z < -0.7 {
                                                            if x < -0.28 {  return nil }
                                                            else { return GKGesture.Push }
                                                        }
                                                        else { return GKGesture.Push }
                                                    }
                                                    else { return nil }
                                                }
                                            }
                                            else {
                                                if y < -0.38 {
                                                    if y < -0.89 {  return GKGesture.Push }
                                                    else { return nil }
                                                }
                                                else { return nil }
                                            }
                                        }
                                    }
                                    else {
                                        if z < -0.02 {
                                            if y < 0.74 {
                                                if z < -0.47 {
                                                    if x < -1 {  return GKGesture.Left }
                                                    else {
                                                        if y < 0.66 {
                                                            if y < -0.04 {  return nil }
                                                            else {
                                                                if z < -0.82 {
                                                                    if x < -0.41 {
                                                                        if y < 0.28 {
                                                                            if z < -0.99 {
                                                                                if z < -1 {  return nil }
                                                                                else { return GKGesture.Down }
                                                                            }
                                                                            else { return nil }
                                                                        }
                                                                        else { return nil }
                                                                    }
                                                                    else { return nil }
                                                                }
                                                                else { return nil }
                                                            }
                                                        }
                                                        else { return nil }
                                                    }
                                                }
                                                else {
                                                    if x < -0.66 {
                                                        if x < -0.94 {  return nil }
                                                        else {
                                                            if y < 0.63 {
                                                                if x < -0.74 {
                                                                    if x < -0.76 {
                                                                        if x < -0.9 {
                                                                            if y < 0.32 {  return nil }
                                                                            else { return GKGesture.Right }
                                                                        }
                                                                        else { return nil }
                                                                    }
                                                                    else { return nil }
                                                                }
                                                                else { return nil }
                                                            }
                                                            else { return nil }
                                                        }
                                                    }
                                                    else {
                                                        if y < 0.17 {
                                                            if x < -0.58 {
                                                                if x < -0.59 {  return nil }
                                                                else { return GKGesture.Down }
                                                            }
                                                            else { return nil }
                                                        }
                                                        else { return nil }
                                                    }
                                                }
                                            }
                                            else {
                                                if z < -0.25 {
                                                    if x < -0.16 {
                                                        if z < -0.4 {
                                                            if y < 0.79 {  return nil }
                                                            else {
                                                                if x < -0.25 {
                                                                    if y < 0.91 {  return nil }
                                                                    else {
                                                                        if z < -0.66 {  return GKGesture.Right }
                                                                        else { return nil }
                                                                    }
                                                                }
                                                                else { return nil }
                                                            }
                                                        }
                                                        else {
                                                            if x < -0.66 {
                                                                if y < 0.86 {  return nil }
                                                                else { return GKGesture.Left }
                                                            }
                                                            else { return nil }
                                                        }
                                                    }
                                                    else {
                                                        if z < -0.65 {
                                                            if y < 0.91 {  return nil }
                                                            else {
                                                                if x < 0.12 {  return nil }
                                                                else { return GKGesture.Left }
                                                            }
                                                        }
                                                        else { return nil }
                                                    }
                                                }
                                                else { return nil }
                                            }
                                        }
                                        else {
                                            if y < 0.62 {
                                                if x < -1.02 {
                                                    if x < -1.27 {  return GKGesture.Up }
                                                    else {
                                                        if z < 0.3 {
                                                            if x < -1.11 {  return nil }
                                                            else { return GKGesture.Up }
                                                        }
                                                        else { return GKGesture.Left }
                                                    }
                                                }
                                                else {
                                                    if z < 0.47 {
                                                        if x < -0.62 {
                                                            if y < 0.17 {
                                                                if y < 0.14 {
                                                                    if y < 0.05 {  return nil }
                                                                    else {
                                                                        if x < -0.8 {  return GKGesture.Up }
                                                                        else {
                                                                            if y < 0.12 {  return nil }
                                                                            else { return GKGesture.Up }
                                                                        }
                                                                    }
                                                                }
                                                                else {
                                                                    if x < -0.74 {  return GKGesture.Right }
                                                                    else { return nil }
                                                                }
                                                            }
                                                            else { return nil }
                                                        }
                                                        else {
                                                            if x < -0.38 {
                                                                if y < 0.57 {
                                                                    if y < 0.29 {  return nil }
                                                                    else {
                                                                        if z < 0.07 {
                                                                            if x < -0.56 {  return nil }
                                                                            else { return GKGesture.Right }
                                                                        }
                                                                        else { return nil }
                                                                    }
                                                                }
                                                                else { return nil }
                                                            }
                                                            else {
                                                                if y < 0.3 {  return nil }
                                                                else {
                                                                    if x < -0.27 {  return nil }
                                                                    else { return GKGesture.Up }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        if y < 0.16 {  return nil }
                                                        else {
                                                            if x < -0.86 {  return nil }
                                                            else {
                                                                if y < 0.55 {  return nil }
                                                                else {
                                                                    if x < -0.52 {  return nil }
                                                                    else {
                                                                        if x < -0.41 {  return nil }
                                                                        else {
                                                                            if y < 0.55 {  return GKGesture.Up }
                                                                            else { return nil }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            else {
                                                if z < 0.31 {
                                                    if x < -0.98 {  return GKGesture.Left }
                                                    else {
                                                        if y < 0.95 {  return nil }
                                                        else {
                                                            if x < -0.52 {
                                                                if z < 0.18 {
                                                                    if x < -0.69 {  return GKGesture.Left }
                                                                    else { return nil }
                                                                }
                                                                else { return GKGesture.Left }
                                                            }
                                                            else {
                                                                if z < 0.12 {  return nil }
                                                                else {
                                                                    if x < -0.42 {  return nil }
                                                                    else {
                                                                        if x < 0.05 {  return nil }
                                                                        else {
                                                                            if y < 1 {  return GKGesture.Right }
                                                                            else { return nil }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if x < -0.76 {
                                                        if z < 0.6 {
                                                            if y < 0.76 {
                                                                if x < -0.99 {  return GKGesture.Left }
                                                                else { return nil }
                                                            }
                                                            else { return GKGesture.Left }
                                                        }
                                                        else { return GKGesture.Left }
                                                    }
                                                    else {
                                                        if y < 0.78 {  return nil }
                                                        else {
                                                            if z < 0.66 {
                                                                if x < -0.34 {
                                                                    if z < 0.38 {
                                                                        if y < 0.99 {
                                                                            if x < -0.39 {  return nil }
                                                                            else {
                                                                                if y < 0.88 {  return GKGesture.Left }
                                                                                else { return nil }
                                                                            }
                                                                        }
                                                                        else { return GKGesture.Left }
                                                                    }
                                                                    else { return nil }
                                                                }
                                                                else { return nil }
                                                            }
                                                            else {
                                                                if x < -0.43 {  return nil } 
                                                                else {
                                                                    if y < 0.92 {  return nil } 
                                                                    else {
                                                                        if x < -0.18 {  return nil } 
                                                                        else { return GKGesture.Left } 
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                if y < 1.26 {
                                    if z < -0.65 {  return GKGesture.Left } 
                                    else {
                                        if x < -0.13 {
                                            if z < -0.34 {  return GKGesture.Right } 
                                            else {
                                                if x < -0.44 {
                                                    if x < -0.82 {  return GKGesture.Left } 
                                                    else {
                                                        if y < 1.18 {  return nil } 
                                                        else { return GKGesture.Right } 
                                                    }
                                                }
                                                else { return nil } 
                                            }
                                        }
                                        else { return nil } 
                                    }
                                }
                                else {
                                    if x < -0.25 {
                                        if y < 1.37 {
                                            if z < -0.21 {  return GKGesture.Up } 
                                            else {
                                                if z < 0.48 {
                                                    if x < -0.62 {  return GKGesture.Left } 
                                                    else { return nil } 
                                                }
                                                else {
                                                    if y < 1.28 {  return GKGesture.Up } 
                                                    else { return GKGesture.Right } 
                                                }
                                            }
                                        }
                                        else {
                                            if x < -0.78 {  return GKGesture.Up } 
                                            else {
                                                if z < -0.64 {  return GKGesture.Right } 
                                                else {
                                                    if z < -0.12 {  return GKGesture.Up } 
                                                    else {
                                                        if x < -0.37 {
                                                            if z < 0.21 {  return GKGesture.Right } 
                                                            else { return GKGesture.Up } 
                                                        }
                                                        else { return GKGesture.Right } 
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else { return GKGesture.Right } 
                                }
                            }
                        }
                        else {
                            if y < 0.58 {
                                if x < -0.59 {
                                    if x < -1.06 {  return GKGesture.Left } 
                                    else {
                                        if z < 1.04 {
                                            if x < -0.88 {  return GKGesture.Up } 
                                            else { return nil } 
                                        }
                                        else { return GKGesture.Up } 
                                    }
                                }
                                else {
                                    if z < 1.12 {
                                        if x < -0.1 {
                                            if x < -0.16 {  return nil } 
                                            else { return GKGesture.Up } 
                                        }
                                        else { return nil } 
                                    }
                                    else { return GKGesture.Up } 
                                }
                            }
                            else {
                                if x < -0.24 {  return GKGesture.Up } 
                                else {
                                    if y < 0.98 {
                                        if z < 1.44 {
                                            if x < -0.03 {
                                                if y < 0.63 {  return nil } 
                                                else {
                                                    if y < 0.71 {  return nil } 
                                                    else { return GKGesture.Up } 
                                                }
                                            }
                                            else { return GKGesture.Left } 
                                        }
                                        else { return GKGesture.Up } 
                                    }
                                    else {
                                        if y < 1.19 {  return GKGesture.Right } 
                                        else { return GKGesture.Left } 
                                    }
                                }
                            }
                        }
                    }
                    else {
                        if y < 0.73 {
                            if x < 1.11 {
                                if z < -0.71 {
                                    if z < -1.21 {
                                        if x < 0.23 {  return GKGesture.Up } 
                                        else { return GKGesture.Push } 
                                    }
                                    else {
                                        if x < 0.6 {  return nil } 
                                        else {
                                            if z < -0.87 {
                                                if y < 0.53 {
                                                    if y < 0.29 {
                                                        if x < 0.64 {  return nil } 
                                                        else { return GKGesture.Push } 
                                                    }
                                                    else {
                                                        if x < 0.77 {  return nil } 
                                                        else {
                                                            if z < -0.93 {
                                                                if x < 1.06 {
                                                                    if x < 1.03 {
                                                                        if x < 0.83 {
                                                                            if y < 0.4 {  return GKGesture.Down } 
                                                                            else { return GKGesture.Push } 
                                                                        }
                                                                        else {
                                                                            if z < -0.94 {  return nil } 
                                                                            else { return GKGesture.Push } 
                                                                        }
                                                                    }
                                                                    else { return GKGesture.Down } 
                                                                }
                                                                else { return nil } 
                                                            }
                                                            else {
                                                                if y < 0.43 {  return nil } 
                                                                else {
                                                                    if x < 1.02 {  return nil } 
                                                                    else { return GKGesture.Down } 
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    if z < -0.97 {  return GKGesture.Push } 
                                                    else {
                                                        if x < 0.76 {  return nil } 
                                                        else { return GKGesture.Push } 
                                                    }
                                                }
                                            }
                                            else {
                                                if y < 0.01 {  return GKGesture.Push } 
                                                else {
                                                    if z < -0.81 {  return nil } 
                                                    else {
                                                        if x < 0.72 {
                                                            if y < 0.43 {  return GKGesture.Down } 
                                                            else { return nil } 
                                                        }
                                                        else { return nil } 
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if y < 0.33 {
                                        if y < -0.26 {  return GKGesture.Push } 
                                        else {
                                            if x < 0.73 {
                                                if z < -0.33 {
                                                    if y < 0.3 {
                                                        if y < -0.03 {  return nil } 
                                                        else {
                                                            if x < 0.33 {  return nil } 
                                                            else { return GKGesture.Down } 
                                                        }
                                                    }
                                                    else { return nil } 
                                                }
                                                else { return nil } 
                                            }
                                            else { return nil } 
                                        }
                                    }
                                    else {
                                        if z < -0.36 {  return nil } 
                                        else {
                                            if x < 0.88 {
                                                if z < 0.96 {
                                                    if x < 0.33 {  return nil } 
                                                    else { return GKGesture.Left } 
                                                }
                                                else { return GKGesture.Left } 
                                            }
                                            else { return nil } 
                                        }
                                    }
                                }
                            }
                            else {
                                if y < 0.34 {
                                    if y < 0.16 {  return GKGesture.Push } 
                                    else {
                                        if z < -1.01 {  return GKGesture.Push } 
                                        else {
                                            if x < 1.36 {  return nil } 
                                            else { return GKGesture.Down } 
                                        }
                                    }
                                }
                                else {
                                    if z < -0.76 {  return GKGesture.Down } 
                                    else { return GKGesture.Right } 
                                }
                            }
                        }
                        else {
                            if z < -1 {
                                if x < 0.7 {
                                    if z < -1.11 {
                                        if x < 0.38 {  return GKGesture.Push } 
                                        else { return GKGesture.Left } 
                                    }
                                    else {
                                        if z < -1.05 {  return GKGesture.Left } 
                                        else {
                                            if z < -1.02 {  return nil } 
                                            else { return GKGesture.Left } 
                                        }
                                    }
                                }
                                else { return GKGesture.Push } 
                            }
                            else {
                                if z < 0.01 {
                                    if x < 0.33 {  return nil } 
                                    else {
                                        if x < 1.27 {
                                            if x < 0.94 {
                                                if y < 0.95 {
                                                    if z < -0.41 {
                                                        if y < 0.93 {
                                                            if z < -0.99 {  return nil } 
                                                            else {
                                                                if z < -0.87 {  return GKGesture.Left } 
                                                                else {
                                                                    if z < -0.56 {  return nil } 
                                                                    else { return GKGesture.Left } 
                                                                }
                                                            }
                                                        }
                                                        else { return nil } 
                                                    }
                                                    else { return GKGesture.Left } 
                                                }
                                                else { return GKGesture.Left } 
                                            }
                                            else {
                                                if y < 1.27 {  return nil } 
                                                else { return GKGesture.Left } 
                                            }
                                        }
                                        else { return GKGesture.Right } 
                                    }
                                }
                                else {
                                    if y < 1.22 {
                                        if z < 1.36 {
                                            if y < 0.9 {  return GKGesture.Left } 
                                            else {
                                                if z < 1 {
                                                    if x < 1.02 {
                                                        if x < 0.85 {  return GKGesture.Right } 
                                                        else {
                                                            if x < 0.95 {  return GKGesture.Left } 
                                                            else { return nil } 
                                                        }
                                                    }
                                                    else { return GKGesture.Right } 
                                                }
                                                else { return GKGesture.Left } 
                                            }
                                        }
                                        else { return GKGesture.Left } 
                                    }
                                    else {
                                        if x < 0.34 {  return GKGesture.Right } 
                                        else { return GKGesture.Left } 
                                    }
                                }
                            }
                        }
                    }
                } else {
                    return nil
                }
            }
            return REPTree
        }
    }
}