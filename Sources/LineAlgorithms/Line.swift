
extension SIMD2 where Scalar == Int {
    /// Bresenham's line algorithm
    /// - Parameters:
    ///   - from: origin
    ///   - to: end point
    /// - Returns: plot points
    public static func protLine(from: Self, to: Self) -> [Self] {
        var points: [SIMD2<Int>] = []
        
        var x0 = from.x
        var y0 = from.y
        let x1 = to.x
        let y1 = to.y
        
        let dx = abs(x1 - x0)
        let sx = x0 < x1 ? 1 : -1
        let dy = -abs(y1 - y0)
        let sy = y0 < y1 ? 1 : -1
        var err = dx + dy
        var e2: Int = 0
        
        while true {
            points.append(SIMD2<Int>(x: x0, y: y0))
            if x0 == x1 && y0 == y1 {
                break
            }
            
            e2 = 2 * err
            if e2 >= dy {
                err += dy
                x0 += sx
            }
            if e2 <= dx {
                err += dx
                y0 += sy
            }
        }
        return points
    }
}

