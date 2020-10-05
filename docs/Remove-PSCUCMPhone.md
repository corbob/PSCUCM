---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Remove-PSCUCMPhone

## SYNOPSIS
Remove a phone from CUCM

## SYNTAX

### Name
```
Remove-PSCUCMPhone -Name <String> [-EnableException] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### UUID
```
Remove-PSCUCMPhone -UUID <String> [-EnableException] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove a phoen from CUCM

## EXAMPLES

### EXAMPLE 1
```
Remove-PSCUCMPhone -UUID {3C33ADA6-70DF-F16C-C5B9-16CE14AE58B3}
```

Removes phone with UUID {3C33ADA6-70DF-F16C-C5B9-16CE14AE58B3}

## PARAMETERS

### -Name
Name of phone to remove

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UUID
UUID of phone to remove

```yaml
Type: String
Parameter Sets: UUID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableException
Parameter description

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
