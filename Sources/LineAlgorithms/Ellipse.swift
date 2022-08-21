
extension SIMD2 where Scalar == Int {
    /// Bresenham's line algorithm
    /// - Parameters:
    ///   - from: origin
    ///   - to: end point
    /// - Returns: plot points
    public static func plotEllipse(from: Self, to: Self) -> [Self] {
        var x0 = from.x
        var y0 = from.y
        var x1 = to.x
        var y1 = to.y
        var a = abs(x1 - x0)
        let b = abs(y1 - y0)
        var b1 = b & 1 /* values of diameter */
        var dx: Double = Double(4 * (1 - a) * b * b)
        var dy: Double = Double(4 * (b1 + 1) * a * a) /* error increment */
        var err: Double = Double(dx + dy + Double(b1) * Double(a) * Double(a))
        var e2: Double = 0 /* error of 1.step */

        if x0 > x1 {
            x0 = x1
            x1 += a
        } /* if called with swapped points */
        if y0 > y1 {
            y0 = y1
        } /* .. exchange them */
        y0 += (b + 1) / 2
        y1 = y0 - b1 /* starting pixel */
        a *= 8 * a
        b1 = 8 * b * b

        var points: [Self] = []

        repeat {
            points.append(Self(x: x1, y: y0)) /*   I. Quadrant */
            points.append(Self(x: x0, y: y0)) /*  II. Quadrant */
            points.append(Self(x: x0, y: y1)) /* III. Quadrant */
            points.append(Self(x: x1, y: y1)) /*  IV. Quadrant */
            e2 = 2 * err
            if e2 <= dy {
                y0 += 1
                y1 -= 1
                dy += Double(a)
                err += dy
            } /* y step */
            if e2 >= dx || 2 * err > dy {
                x0 += 1
                x1 -= 1
                dx += Double(b1)
                err += dx
            } /* x step */
        } while x0 <= x1

        while y0 - y1 < b { /* too early stop of flat ellipses a=1 */
            points.append(Self(x: x0 - 1, y: y0)) /* -> finish tip of ellipse */
            y0 += 1
            points.append(Self(x: x1 + 1, y: y0))
            points.append(Self(x: x0 - 1, y: y1))
            y1 -= 1
            points.append(Self(x: x1 + 1, y: y1))
        }

        return points
    }
}
