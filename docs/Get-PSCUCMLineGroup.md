---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Get-PSCUCMLineGroup

## SYNOPSIS
Get Line Group

## SYNTAX

### name (Default)
```
Get-PSCUCMLineGroup [-name] <String> [-EnableException] [<CommonParameters>]
```

### uuid
```
Get-PSCUCMLineGroup [-uuid] <String> [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
Get Line Group

## EXAMPLES

### EXAMPLE 1
```
Get-PSCUCMLineGroup -name 'Line Group 3'
```

Get 'Line Group 3' information.

## PARAMETERS

### -uuid
UUID of Line Group

```yaml
Type: String
Parameter Sets: uuid
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Name of Line Group

```yaml
Type: String
Parameter Sets: name
Aliases:

Required: True
Position: 1
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
