// simd is an extensive vector math library
import simd

extension FloatingPoint {
    // Converts degrees to radians.
    var degreesToRadians: Self { self * (.pi / 180) }
    // Converts radians to degrees.
    var radiansToDegrees: Self { self * (180 / .pi) }
}

// Provides the azimuth from an argument 3D directional, simd_float3.
func azimuth(from direction: simd_float3) -> Float {
    return asin(direction.x)
}

// Provides the elevation from the argument 3D directional, simd_float3.
func elevation(from direction: simd_float3) -> Float {
    return atan2(direction.z, direction.y) + (.pi / 2)
}

var float3 = simd_float3.init(100, 100, 100)
print(elevation(from: float3))

/* How the code works
    extending FloatingPoint creates custom made functionality to the type
    here we added FloatingPoint.degreesToRadians and FloatingPoint.radiansToDegrees

    we also implement functions azimuth() and elevation() that take a 3D vector
    and converts it to azimuth and elevation
*/


/* Example code
    var myDegrees = 180
    var myRadians = myDegrees.degreesToRadians
    print(myRadians) --> 3.14159

    var myVector = simd_float3.init(100, 100, 100)
    var myElevation = elevation(from: myVector)
    print(myElevation) --> 2.35619
*/

