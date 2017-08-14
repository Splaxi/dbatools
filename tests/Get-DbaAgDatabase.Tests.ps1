$CommandName = $MyInvocation.MyCommand.Name.Replace(".ps1", "")
Write-Host -Object "Running $PSCommandpath" -ForegroundColor Cyan
. "$PSScriptRoot\constants.ps1"

Describe "$CommandName Unit Tests" -Tag 'UnitTests' {
	Context "Validate parameters" {
		$paramCount = 5
		<# 
			Get commands, Default count = 11
			Commands with SupportShouldProcess = 13
		#>
		$defaultParamCount = 11
		[object[]]$params = (Get-ChildItem function:\Get-DbaAgDatabase).Parameters.Keys
		$knownParameters = 'SqlInstance', 'SqlCredential', 'AvailabilityGroup', 'Database', 'Silent'
		it "Should contian our parameters" {
			( (Compare-Object -ReferenceObject $knownParameters -DifferenceObject $params -IncludeEqual | Where-Object SideIndicator -eq "==").Count ) | Should Be $paramCount
		}
		it "Should only contain our parameters" {
			$params.Count - $defaultParamCount | Should Be $paramCount
		}
	}
}