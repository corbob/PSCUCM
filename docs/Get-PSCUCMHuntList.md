---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Get-PSCUCMHuntList

## SYNOPSIS
Get Hunt List

## SYNTAX

### name (Default)
```
Get-PSCUCMHuntList [-name] <String> [-EnableException] [<CommonParameters>]
```

### uuid
```
Get-PSCUCMHuntList [-uuid] <String> [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
Get Hunt List

## EXAMPLES

### EXAMPLE 1
```
Get-PSCUCMHuntList 'My Hunt List'
```

Get Hunt List named 'My Hunt List'

## PARAMETERS

### -uuid
UUID of hunt list

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
Name of the hunt list

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
