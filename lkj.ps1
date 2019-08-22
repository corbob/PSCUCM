function aa {
    [CmdletBinding()]
    Param(
        [ValidateSet(1,2,3,4,5,6,7,8,9)]
        [Parameter(Mandatory)]
        $a,
        [Parameter(Mandatory)]
        [ValidateSet(1,2,3,4,5,6,7,8,9)]
        $b
    )
}
function aaa {
    Param(
        $a,
        [ValidateSet(1,2,3,4,5,6,7,8,9)]
        [Parameter(Mandatory)]
        $b,
        [switch]
        $c
    )
}
