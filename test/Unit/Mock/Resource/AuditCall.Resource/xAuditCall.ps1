Set-StrictMode -Version 'Latest'

. "$PSScriptRoot\Model\xAuditCallResourceModel.ps1"

class xAuditCall {
    [ValidateNotNullOrEmpty()][String]$Title
    hidden [int]$UpdateCallCount = 0
    hidden [int]$GetCallCount = 0
    hidden [int]$TestCallCount = 0
    hidden [int]$SetCallCount = 0
    hidden [int]$GetResourceInfoCount = 0

    xAuditCall() {}

    [System.Boolean]Update_TargetResource() {
        $this.UpdateCallCount++
        if ( !$this.Test_TargetResource()) {
            $this.Set_TargetResource()
            return $this.Test_TargetResource()
        }
        else {
            return $true
        }
    }
    
    [System.Collections.Hashtable]Get_TargetResource() {   
        $this.GetCallCount++
        return $this.Get_ResourceModel()
    }

    [System.Collections.Hashtable]Get_ResourceInfo() {
        $this.GetResourceInfoCount++
        return $this.Get_ResourceModel()
    }


    [System.Collections.Hashtable]Get_ResourceModel() {
        $returnValue = New-xAuditCallResourceModel
        
        $returnValue.ResourceName = "xAuditCall"
        $returnValue.Title = $this.Title
        $returnValue.UpdateCallCount = $this.UpdateCallCount
        $returnValue.GetCallCount = $this.GetCallCount
        $returnValue.TestCallCount = $this.TestCallCount
        $returnValue.SetCallCount = $this.SetCallCount
        $returnValue.GetResourceInfoCount = $this.GetResourceInfoCount

        return $returnValue
    }

    [System.Boolean] Test_TargetResource() {
        $this.TestCallCount++
        if ($this.SetCallCount -eq 0) {
            return $false
        }
        else {
            return $true
        }
    } 

    [void] Set_TargetResource() {
        $this.SetCallCount++
    }
}


function New-xAuditCall() {
    [CmdletBinding()]
    [OutputType([xAuditCall])]
    param (
        [parameter(Mandatory = $true)]
        [Hashtable]$DesiredState
    )

    return [xAuditCall]@{
        Title = $DesiredState.Title;
    }
}