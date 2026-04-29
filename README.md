# SwiftPrint

To avoid importing SwiftPrint everywhere you need it, you can create a global wrapper function that passes along the expected arguments:

```
import SwiftPrint

func log(_ message: Any?,
           object: AnyObject? = nil,
           type: SwiftPrint.LogType = .error,
           filePath: String = #file,
           lineOfCode: UInt = #line,
           timestamp: Bool = true,
           persist: Bool = true)
{
    #if DEBUG
    if let output = SwiftPrint.generateOutput(rawMessageOrInstance: message,
                                              objectForPrintingAddress: object,
                                              logType: type,
                                              filePath: filePath,
                                              lineOfCode: lineOfCode,
                                              includeTimestamp: timestamp,
                                              shouldPersist: persist)
    {
        Swift.print(output)
    }
    #endif
}
```

Don't forget to use  **Swift Compiler - Custom Flags** section from **Build Settings** to define debug flags to ensure that the printing is only happening in the debug versions of your app, especially if you're using the persitence feature. 
```
#if DEBUG
...
#endif
```
