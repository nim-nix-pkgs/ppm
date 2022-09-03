import strformat
type Pixel*[D:static[int]] = ref object
    r*:range[0..D]
    g*:range[0..D]
    b*:range[0..D]

proc toString*(this:Pixel):string{.inline.}=
    return &"{this.r} {this.g} {this.b}"

proc newPixel*[D:static[int]](r:int,g:int,b:int):Pixel[D]{.inline.}= 
    result = new Pixel[D]
    result.r = r
    result.g = g
    result.b = b
