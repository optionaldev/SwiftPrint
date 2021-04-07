# SwiftPrint

To avoid importing SwiftPrint everywhere you need it, you can create a global wrapper function that passes along the expected arguments:

```
import SwiftPrint

func log(_ message: Any?,
           object: AnyObject? = nil,
           type: SwiftPrint.LogType = .error,
           filePath: String = #file,
           lineOfCode: UInt = #line)
{
    if let output = SwiftPrint.generateOutput(message: message,
                                              object: object,
                                              logType: type,
                                              filePath: filePath,
                                              lineOfCode: lineOfCode)
    {
        Swift.print(output)
    }
}
```
