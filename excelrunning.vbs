
If IsRunning("Excel") Then msgbox( "Excel is running.")

Function IsRunning(name)
 On Error Resume Next
 Dim app : Set app = GetObject(, name & ".Application")
 Select Case Err.Number
 Case 0
 IsRunning = True
 Set app = Nothing
 Case 429
 IsRunning = False
 Case Else
 WScript.Echo "Unexpected error: " & Err.Description & " (" & Err.Number & ")"
 WScript.Quit 1
 End Select
 On Error Goto 0
End Function
