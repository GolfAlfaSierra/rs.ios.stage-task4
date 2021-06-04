import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        var result = image
        
        if (!image.indices.contains(row) || !image[row].indices.contains(column)) {
            return image
        }
        
        let prevColor = image[row][column]
        
        floodFill(&result, m: image.count, n: image[row].count, x: row, y: column, prevC: prevColor, newColor)
        
        return result
    }
    
    func isValid(_ screen:[[Int]], _ m:Int , _ n:Int , x:Int, y:Int, _ prevC:Int, _ newC:Int) -> Bool {
        if (x < 0 || x >= m || y < 0 || y >= n ||
                screen[x][y] != prevC || screen[x][y] == newC) {
            return false
        }
        
        return true
    }
    
    func floodFill(_ screen: inout [[Int]], m:Int , n:Int , x:Int, y:Int, prevC:Int,_ newC:Int) {
        var que = [[Int]]()
        
        que.append([x,y])
        
        screen[x][y] = newC
        
        while !que.isEmpty {
            let currentPixel = que.popLast()
            
            let pX = currentPixel![0]
            let pY = currentPixel![1]
            
            var valid = isValid(screen,
                                m, n,
                                x: pX + 1, y: pY,
                                prevC, newC)
            
            if (valid) {
                screen[pX+1][pY] = newC
                que.append([pX + 1, pY])
            }
            
            valid = isValid(screen, m, n,
                            x: pX-1, y: pY,
                            prevC, newC)
            
            if (valid) {
                screen[pX-1][pY] = newC
                que.append([pX - 1, pY])
            }
            
            valid = isValid(screen, m, n, x: pX, y: pY+1, prevC, newC)
            
            if (valid) {
                screen[pX][pY+1] = newC
                que.append([pX, pY+1])
            }
            
            valid = isValid(screen, m, n, x: pX, y: pY-1, prevC, newC)
            
            if (valid) {
                screen[pX][pY-1] = newC
                que.append([pX, pY-1])
            }
        }
    }
    
}
