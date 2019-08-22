Function ConvertTo-XMLString 
{
<#
.SYNOPSIS
    Outputs a human readable simple text XML representation of a simple PS object.
.PARAMETER InputObject
    The input object to inspect and dump.
.PARAMETER ObjectName
    The name of the root element in the document. Defaults to "Object"
.PARAMETER ExcludeProperty
    Optional.  Property(s) to exclude from output
.PARAMETER RootAttributes
    Optional.  Attributes to put on root element
.PARAMETER BooleanValuesAsLowercase
    Optional.  Print boolean values as lowercase instead of propercase (true vs True)
.PARAMETER DateFormat
    Optional.  DateFormat string to use for datetime properties
.PARAMETER IndentLevel
    Internal use, this is a recursive function 
.PARAMETER Root
    Internal use, this is a recursive function
    .NOTES
    Provided by Ish__ in PowerShell Discord (https://pwsh.ca/discord): https://gist.github.com/charlieschmidt/57292a97a3a8760e4baaffba425e5010
#>
    [cmdletbinding()]
	param (
        [parameter(Mandatory=$true,valuefrompipeline=$true)]
		[object]$InputObject,
        [Parameter(Mandatory=$false)]
		[String]$ObjectName = "Object",
        [Parameter(Mandatory=$false)]
        [string[]]$ExcludeProperty,
        [Parameter(Mandatory=$false)]
        [hashtable]$RootAttributes,
        [Parameter(Mandatory=$false)]
        [switch]$BooleanValuesAsLowercase,
        [Parameter(Mandatory=$false)]
        [string]$DateFormat = "",
        [Parameter(Mandatory=$false)]
		[Int32]$IndentLevel = 1,
        [Parameter(Mandatory=$false)]
		[boolean]$Root = $true
	)
    begin
	{
        $OutputStrings = New-Object System.Collections.Generic.List[System.String]
	}
    process
    {
        $IndentString = ("`t" * $IndentLevel)

	    # Output the root element opening tag
	    if ($Root) 
        {
            $RootElement = $ObjectName

            if ($RootAttributes)
            {
                foreach ($Key in $RootAttributes.Keys)
                {
                    $RootElement += " {0}=`"{1}`"" -f $Key, $RootAttributes[$Key]
                }
            }
            $OutputStrings.Add("<$RootElement>")
	    }
 
        # Iterate through all of the note properties in the object.
        $Properties = @()
        if ($InputObject.GetType().Name -eq "Hashtable" -or $InputObject.GetType().Name -eq "OrderedDictionary")
        {
            $Properties = $InputObject.Keys
        }
        elseif ($InputObject.GetType().Name -eq "PSCustomObject")
        {
            $Properties = Get-Member -InputObject $InputObject -MemberType NoteProperty | Select-Object -Expand Name
        }
        elseif ($InputObject.GetType().Name -eq "Boolean" -and $BooleanValuesAsLowerCase.IsPresent)
        {
            $PropertyValueString = ([string]$InputObject).ToLower()
        }
        elseif ($InputObject.GetType().Name -ieq "datetime")
        {
            $PropertyValueString = [string]($InputObject).ToString($DateFormat)
        }
        else
        {
            $PropertyValueString = $InputObject.ToString()
        }

        if ($Properties.Count -eq 0)
        {
            $OutputStrings.Add($PropertyValueString)
        }
        else 
        {
            foreach ($Property in $Properties) 
            {
                if ($ExcludeProperty -inotcontains $Property)
                {
                    $PropertyValue = $InputObject.($Property)
    
                    # Check if the property is an object and we want to dig into it
                    if ($null -eq $PropertyValue)
                    {
                        $OutputStrings.Add("$IndentString<$Property />")
                    }
                    elseif ($PropertyValue.GetType().Name -eq "PSCustomObject" -or $PropertyValue.gettype().name -eq "Hashtable" -or $PropertyValue.GetType().Name -eq "OrderedDictionary") 
                    { # is object, so dig in, with wrapping xml tags
                        $OutputStrings.Add("$IndentString<$Property>")
                        $PropertyXml = ConvertTo-XMLString -InputObject $PropertyValue -Root $false -IndentLevel ($IndentLevel + 1) -DateFormat $DateFormat  -BooleanValuesAsLowercase:$BooleanValuesAsLowercase
                        $OutputStrings.Add($PropertyXml)
                        $OutputStrings.Add("$IndentString</$Property>")
                    }
                    elseif ($PropertyValue.GetType().Name.ToString().EndsWith("[]"))
                    { # is array, so get value for each element in array, then wrap total (if those were objects) or wrap individually (if they were strings/ints/etc)
                        $PropertyXml = @()
                        $SubObjectPropertyNames = @()
                        foreach ($APropertyValue in $PropertyValue) 
                        {
                            $ValueIsObject = $false
                            if ($APropertyValue.gettype().name -eq "PSCustomObject" -or $APropertyValue.gettype().name -eq "Hashtable" -or $APropertyValue.GetType().Name -eq "OrderedDictionary")
                            {
                                switch ($APropertyValue.GetType().Name)
                                {
                                    "Hashtable" { $SubObjectPropertyNames += $APropertyValue.Keys }
                                    "OrderedDictionary" { $SubObjectPropertyNames += $APropertyValue.Keys }
                                    "PSObject" { $SubObjectPropertyNames += $APropertyValue.PSObject.Properties.Name }
                                    "PSCustomObject" { $SubObjectPropertyNames += $APropertyValue.PSObject.Properties.Name }
                                }
                                $ValueIsObject = $true
                            }

                            $PropertyXml += ConvertTo-XMLString -InputObject $APropertyValue -Root $false -DateFormat $DateFormat -BooleanValuesAsLowercase:$BooleanValuesAsLowercase -IndentLevel ($IndentLevel + 1)
                        }

                        $ValueIsWrapper = $false
                        if ($ValueIsObject)
                        {
                            $Ps = ($SubObjectPropertyNames | Select-Object -Unique).Count
                            if ($PS -eq 1)
                            {
                                $ValueIsWrapper = $true
                            }
                        }
                        if ($PropertyXml.Count -ne 0)
                        {
                            if ($ValueIsObject)
                            {
                                if ($ValueIsWrapper)
                                {
                                    $OutputStrings.Add("$IndentString<$Property>")
                                    $PropertyXmlString = $PropertyXml -join "`n"
                                    $OutputStrings.Add($PropertyXmlString)
                                    $OutputStrings.Add("$IndentString</$Property>")
                                }
                                else
                                {
                                    $OutputStrings.Add("$IndentString<$Property>")
                                    $PropertyXmlString = $PropertyXml -join "`n$IndentString</$Property>`n$IndentString<$Property>`n"
                                    $OutputStrings.Add($PropertyXmlString)
                                    $OutputStrings.Add("$IndentString</$Property>")
                                }
                            }
                            else 
                            {
                                foreach ($PropertyXmlString in $PropertyXml)
                                {
                                    $OutputStrings.Add("$IndentString<$Property>$PropertyXmlString</$Property>")
                                }
                            }
                        }
                        else
                        {
                            $OutputStrings.Add("$IndentString<$Property />")
                        }
                    }
                    else    
                    { # else plain old property
                        $PropertyXml = ConvertTo-XMLString -InputObject $PropertyValue -Root $false -DateFormat $DateFormat -BooleanValuesAsLowercase:$BooleanValuesAsLowercase -IndentLevel ($IndentLevel + 1)
                        $OutputStrings.Add("$IndentString<$Property>$PropertyXml</$Property>")
                    }
                }
            }
        }
 
	    # Output the root element closing tag
	    if ($Root) 
        {
            $OutputStrings.Add("</$ObjectName>")
	    }
    }

    End
    {
        $OutputStrings.ToArray() -join "`n" | Write-Output
    }
}
