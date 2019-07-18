Get-ChildItem ".\" -Filter *.txt | 
Foreach-Object {
	if ($_.BaseName.Contains('.')) {
		Rename-Item -Path $_.FullName -NewName "$($_.BaseName.Replace('.', '-'))$($_.Extension)"
	} 
}