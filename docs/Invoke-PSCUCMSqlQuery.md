---
external help file: PSCUCM-help.xml
Module Name: PSCUCM
online version:
schema: 2.0.0
---

# Invoke-PSCUCMSqlQuery

## SYNOPSIS
Invoke a SQL Query against CUCM Server.

## SYNTAX

```
Invoke-PSCUCMSqlQuery [-SqlQuery] <String> [-EnableException] [-OutputXml] [<CommonParameters>]
```

## DESCRIPTION
Invoke a SQL Query against CUCM Server.

## EXAMPLES

### EXAMPLE 1
```
Invoke-PSCUCMSqlQuery -SqlQuery "Select * from phones"
```

Will execute the query against the CUCM server.
This is probably a bad query...
Do *not* try this at home.

## PARAMETERS

### -SqlQuery
SQL Query to invoke.

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

### -OutputXml
Output just XML

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
