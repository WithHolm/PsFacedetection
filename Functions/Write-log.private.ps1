function Write-Log {
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [psobject[]]$Inputobject,
        
        [ValidateSet("Verbose","Debug","Info")]
        $Loglevel = "Verbose"
    )
    
    begin {
    }
    
    process {
        # write-host (get-PSCallStack)[1].FunctionName
        $Message = "$((get-PSCallStack)[1].FunctionName): $($Inputobject -join " ")"
        switch($loglevel)
        {
            "Verbose"{Write-Verbose $Message}
            "Debug"{Write-Debug $Message}
            "Info"{Write-host $Message}
        }
    }
    
    end {
    }
}