---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Add-PSCUCMPhone

## SYNOPSIS
Adds a phone to CUCM.

## SYNTAX

```
Add-PSCUCMPhone [-Name] <String> [-Product] <String> [-DevicePoolName] <String> [-Protocol] <String>
 [[-Description] <String>] [-EnableException] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a phone of the appropriate parameters to CUCM.

## EXAMPLES

### EXAMPLE 1
```
Add-Phone -Name SEP00000000000 -Product 'Cisco 6941' -DevicePoolName 'DEFAULT-DP' -Protocol SCCP
```

Adds a phone to CUCM.

## PARAMETERS

### -Name
Name of the phone.

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

### -Product
Phone Model.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Model

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DevicePoolName
Device Pool to place phone in.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Protocol
Protocol for the phone.
Typically SCCP or SIP.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description for the phone.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

### -WhatIf
What If?

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Confirm...

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
