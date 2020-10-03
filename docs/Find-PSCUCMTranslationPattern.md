---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Find-PSCUCMTranslationPattern

## SYNOPSIS
Find Translation Patterns within CUCM

## SYNTAX

```
Find-PSCUCMTranslationPattern [[-Pattern] <String>] [[-Description] <String>] [[-RoutePartitionName] <String>]
 [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
Find Translation Patterns within CUCM

## EXAMPLES

### EXAMPLE 1
```
Find-PSCUCMTranslationPattern -Pattern 1234
```

Returns the information for Translation Pattern 1234.

## PARAMETERS

### -Pattern
Pattern to possibly search for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description to possibly search for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoutePartitionName
Route Partition to possibly search for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
