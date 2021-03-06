---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Get-PSCUCMTranslationPattern

## SYNOPSIS
Get the Translation Pattern

## SYNTAX

```
Get-PSCUCMTranslationPattern [-TranslationPattern] <String> [-RoutePartitionName] <String> [-EnableException]
 [<CommonParameters>]
```

## DESCRIPTION
Get the Translation Pattern

## EXAMPLES

### EXAMPLE 1
```
Get-PSCUCMTranslationPattern -TranslationPattern 1234 -RoutePartitonName default-rp
```

Gets the Translation Pattern for 1234.

## PARAMETERS

### -TranslationPattern
Translation Pattern to look up.

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

### -RoutePartitionName
Route Partition that houses the Translation Pattern.

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
