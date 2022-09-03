import strformat,pixel
type PPM*[W:static[int],H:static[int],D:static[int]] = ref object
    colorDepth*:int
    width*:int
    height*:int

    pixs*:array[H, array[W, Pixel[D]]]
    buffer*:string
    currentLine*:int

proc createPPMHeader*(this:PPM) =
    this.buffer = &"P3\n{this.width} {this.height}\n{this.colorDepth}\n"
    
proc addLine*[W:static[int],D:static[int]](this:PPM,line:array[W,Pixel[D]]) =
    this.pixs[this.currentLine] = line
    this.currentLine += 1

proc writePixsToBuffer*(this:PPM) =
    var currbuffer:string = ""
    for line in this.pixs:
        var currline:string = ""
        for p in line:
            currline &= p.toString() & " "
        currbuffer &= currline & "\n"
    this.buffer &= currbuffer

proc newPPM*[W,H,D]():PPM[W,H,D] = 
    result = new(PPM[W,H,D])
    result.colorDepth = D
    result.width = W
    result.height = H
    result.currentLine = 0

proc writeBufferToFile*(this:PPM,filename:string) =
  var file = open(filename,fmWrite)
  file.write(this.buffer)
  defer:
    file.close()