---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Get-PSCUCMHuntPilot

## SYNOPSIS
Get Hunt Pilot

## SYNTAX

### pattern (Default)
```
Get-PSCUCMHuntPilot [-pattern] <Int32> [-EnableException] [<CommonParameters>]
```

### uuid
```
Get-PSCUCMHuntPilot [-uuid] <String> [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
Get Hunt Pilot

## EXAMPLES

### EXAMPLE 1
```
Get-PSCUCMHuntPilot 1234
```

Get Hunt Pilot for pattern 1234

## PARAMETERS

### -uuid
UUID of Hunt Pilot

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

### -pattern
Pattern of Hunt Pilot

```yaml
Type: Int32
Parameter Sets: pattern
Aliases:

Required: True
Position: 1
Default value: 0
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
