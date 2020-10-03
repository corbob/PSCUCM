---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Find-PSCUCMHuntPilot

## SYNOPSIS
Find Hunt Pilots

## SYNTAX

```
Find-PSCUCMHuntPilot [[-pattern] <Int32>] [[-Description] <String>] [[-RoutePartitionName] <String>]
 [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
Find Hunt Pilots within CUCM Environment

## EXAMPLES

### EXAMPLE 1
```
Find-PSCUCMHuntPilot -Description %
```

Search for all Hunt Pilots without Route Partion

## PARAMETERS

### -pattern
Pattern to search for

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description to search for.

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
Route Partition to search within.

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
