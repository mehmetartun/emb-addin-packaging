
set shell = CreateObject("Shell.Application")
set fso = CreateObject("Scripting.FileSystemObject")
dim openfinAddIn 
'dim embondsAddIn 




' Verify that we can create an Excel object, otherwise abort the install
on error resume next
set excel = CreateObject("Excel.Application")
if err.number <> 0 then WScript.Quit err.number
on error goto 0

' Move all necessary files to a shared location -------------------------------
'   This code will ultimately be replaced by RVM Plugin System

' Get the root folder containing this script as well as the XLLs
rootFolder = fso.GetParentFolderName(fso.GetFile(WScript.ScriptFullName))

localappdata = shell.NameSpace(&h1c).Self.Path 'See https://msdn.microsoft.com/en-us/library/windows/desktop/bb774096(v=vs.85).aspx
targetDir = "Openfin\shared\assets\embonds-addin"
addInRoot = localappdata & "\" & targetDir

' Attempt to remove any previous installation, will fail if XLL is running
if fso.FolderExists(addInRoot) then
    on error resume next
    tempFolder = addInRoot & "_{AE913FDC-92E5-483C-B823-24B9A1837D93}"
    fso.MoveFolder addInRoot, tempFolder
    if err.number = 0 then fso.DeleteFolder tempFolder, true
    on error goto 0
end if

' If remove successful or first time installing, create folder and copy files
if not fso.FolderExists(addInRoot) then
    shell.NameSpace(localappdata).NewFolder(targetDir)
    with shell.NameSpace(addInRoot)
        .CopyHere(rootFolder & "\*.xll")
        .CopyHere(rootFolder & "\*.dll")
        .CopyHere(rootFolder & "\*.dna")
        .CopyHere(rootFolder & "\*.vbs")
        .CopyHere(rootFolder & "\*.xlsm")

    end with
end if

' Register the correct XLL with Excel ----------------------------------------

addInFile = addInRoot

' See https://support.microsoft.com/en-us/kb/3120274
if Mid(excel.ProductCode, 21, 1) = "0" then
    addInFile = addInFile & "\OpenFin.ExcelApi-AddIn.xll"
    'addInFileEmbonds = addInRoot & "\EMBonds_32.xll"
else
    addInFile = addInFile & "\OpenFin.ExcelApi-AddIn64.xll"
    'addInFileEmbonds = addInRoot & "\EMBonds_64.xll"
end if

' See https://blogs.msdn.microsoft.com/accelerating_things/2010/09/16/loading-excel-add-ins-at-runtime/

excel.Workbooks.Add

'isOpenfinAddinRegistered = false
isEmbondsAddinRegistered = false

for each addIn in excel.AddIns
    if not instr(addIn.Name,"OpenFin.ExcelApi") = 0 then
        set openfinAddIn = addIn
        isOpenfinAddinRegistered = true
        openfinAddIn.Installed = true
        exit for
    end if
next

'for each addIn in excel.AddIns
''    if not instr(addIn.Name,"EMBonds") = 0 then
''        set embondsAddIn = addIn
''        isEmbondsAddinRegistered = true
''        embondsAddIn.Installed = true
''        exit for
''    end if
'next



if not isOpenfinAddinRegistered then
    set openfinAddIn = excel.AddIns.Add(addInFile, false)
end if
'if not isEmbondsAddinRegistered then
''    set embondsAddIn = excel.AddIns.Add(addInFileEmbonds, false)
'end if


' TODO: Uncomment the code below
openfinAddIn.Installed = true
'embondsAddIn.Installed = true

set openfinAddIn = nothing
'set addInEmbonds = nothing
excel.Quit
