---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Connect-PSCucm

## SYNOPSIS
"Connect" to CUCM Server

## SYNTAX

```
Connect-PSCucm [-AXLVersion] <String> [-server] <String> [-Credential] <PSCredential> [-EnableException]
 [-SkipCertificateCheck] [-PersistSettings] [<CommonParameters>]
```

## DESCRIPTION
"Connect" to a CUCM Server using the supplied values.

## EXAMPLES

### EXAMPLE 1
```
Connect-PSCucm -AXLVersion 11.5 -server cucm.example.com -Credential $AXLCredential
```

It connects to CUCM Server cucm.example.com

## PARAMETERS

### -AXLVersion
AXL Version for the Server to connect to.
Typically same version as CUCM itself.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -server
Server to connect to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credential Object for the Application User that has the appropriate AXL permissions.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableException
Replaces user friendly yellow warnings with bloody red exceptions of doom!
Use this if you want the function to throw terminating errors you want to catch.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Skip the check of the certificate.
Needed in test environments, and environments without "valid" signed certificates.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersistSettings
Persist the settings beyond the current session.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
