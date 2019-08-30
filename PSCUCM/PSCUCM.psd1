@{
    # Script module or binary module file associated with this manifest
    ModuleToProcess   = 'PSCUCM.psm1'
	
    # Version number of this module.
    ModuleVersion     = '0.2.0'
	
    # ID used to uniquely identify this module
    GUID              = '6dce3384-d179-4bcd-92c0-445b281e4510'
	
    # Author of this module
    Author            = 'corbob'
	
    # Company or vendor of this module
    CompanyName       = ''
	
    # Copyright statement for this module
    Copyright         = 'Copyright (c) 2018 corbob'
	
    # Description of the functionality provided by this module
    Description       = 'Module for interfacing with the Cisco Unified Call Manager (CUCM) Administrative XML Service (AXL).'
	
    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.0'
	
    # Modules that must be imported into the global environment prior to importing
    # this module
    RequiredModules   = @(
        @{ ModuleName = 'PSFramework'; ModuleVersion = '0.10.31.179' }
    )
	
    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @('bin\PSCUCM.dll')
	
    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @('xml\PSCUCM.Types.ps1xml')
	
    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @('xml\PSCUCM.Format.ps1xml')
	
    # Functions to export from this module
    FunctionsToExport = @(
        'Get-PSCUCMPhone'
        'Get-PSCUCMPhoneServices'
        'Invoke-PSCUCMAxlQuery'
        'Invoke-PSCUCMSqlQuery'
        'Add-PSCUCMPhone'
        'Get-PSCUCMTranslationPattern'
        'Set-PSCUCMTranslationPattern'
        'Invoke-PSCUCMLdapSync'
        'Connect-PSCucm'
        'Disconnect-PSCucm'
    )
	
    # Cmdlets to export from this module
    CmdletsToExport   = ''
	
    # Variables to export from this module
    VariablesToExport = ''
	
    # Aliases to export from this module
    AliasesToExport   = ''
	
    # List of all modules packaged with this module
    ModuleList        = @()
	
    # List of all files packaged with this module
    FileList          = @()
	
    # Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{
		
        #Support for PowerShellGet galleries.
        PSData = @{
			
            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()
			
            # A URL to the license for this module.
            # LicenseUri = ''
			
            # A URL to the main website for this project.
            # ProjectUri = ''
			
            # A URL to an icon representing this module.
            # IconUri = ''
			
            # ReleaseNotes of this module
            # ReleaseNotes = ''
			
        } # End of PSData hashtable
		
    } # End of PrivateData hashtable
}
